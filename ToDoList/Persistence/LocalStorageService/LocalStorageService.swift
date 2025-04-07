import Foundation
import CoreData

class DefaultLocalStorageService: LocalStorageServiceProtocol {

    private let persistentContainer: NSPersistentContainer
    private let entityName: String
    
    init<T: NSManagedObject>(containerName: String, entityType: T.Type) {
        self.entityName = String(describing: entityType)
        self.persistentContainer = NSPersistentContainer(name: containerName)
        self.persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
    }
    
    func fetchAll<T: NSManagedObject, U>(predicate: NSPredicate? = nil, transform: @escaping (T) -> U, completion: @escaping (Result<[U], Error>) -> Void) {

        let context = persistentContainer.newBackgroundContext()
        context.perform {
            do {
                let request = NSFetchRequest<T>(entityName: self.entityName)
                request.predicate = predicate
                let fetch = try context.fetch(request)
                let result = fetch.map(transform)

                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func save<T: NSManagedObject, U>(item: U, transform: @escaping (T) -> U, configure: @escaping (U, T) -> Void, completion: @escaping (Result<U, Error>) -> Void) {
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            do {
                let object = T(context: context)
                configure(item, object)
                try context.save()
                
                let response = transform(object)
                
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                context.rollback()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func save<T: NSManagedObject, U>(items: [U], transform: @escaping (T) -> U, configure: @escaping (U, T) -> Void, completion: @escaping (Result<[U], Error>) -> Void) {
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            var savedObjects: [T] = []
            do {
                for item in items {
                    let object = T(context: context)
                    configure(item, object)
                    savedObjects.append(object)
                }
                try context.save()

                let response = savedObjects.map(transform)
                
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                context.rollback()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func update<T: NSManagedObject, U>(predicate: NSPredicate, transform: @escaping (T) -> U, updates: @escaping (T) -> Void, completion: @escaping (Result<U, Error>) -> Void) {
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            do {
                let request = NSFetchRequest<T>(entityName: self.entityName)
                request.predicate = predicate
                request.fetchLimit = 1
                if let object = try context.fetch(request).first {
                    updates(object)
                    try context.save()

                    let response = transform(object)
                    
                    DispatchQueue.main.async {
                        completion(.success(response))
                    }
                } else {
                    let error = NSError(domain: "LocalStorageService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Object not found"])
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } catch {
                context.rollback()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func delete<T: NSManagedObject>(predicate: NSPredicate, T: T.Type, completion: @escaping (Result<Bool, Error>) -> Void) {
        let context = persistentContainer.newBackgroundContext()
        context.perform {
            do {
                let request = NSFetchRequest<T>(entityName: self.entityName)
                request.predicate = predicate
                request.fetchLimit = 1
                if let object = try context.fetch(request).first {
                    context.delete(object)
                    try context.save()

                    DispatchQueue.main.async {
                        completion(.success(true))
                    }
                } else {
                    let error = NSError(domain: "LocalStorageService", code: 404, userInfo: [NSLocalizedDescriptionKey: "Object not found"])
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            } catch {
                context.rollback()
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }
}

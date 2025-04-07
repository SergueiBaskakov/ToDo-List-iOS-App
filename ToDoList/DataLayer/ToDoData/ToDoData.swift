//
//  ToDoData.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import CoreData

class DefaultToDoData: ToDoDataProtocol {
    weak var output: ToDoDataOutput?
    
    let networkService: NetworkServiceProtocol?
    
    let localStorageService: LocalStorageServiceProtocol?
    
    let baseURLString: String
    
    init(output: ToDoDataOutput? = nil, networkService: NetworkServiceProtocol?, localStorageService: (any LocalStorageServiceProtocol)?, baseURLString: String) {
        self.output = output
        self.networkService = networkService
        self.localStorageService = localStorageService
        self.baseURLString = baseURLString
    }
    
    private func getToDoListFromNetwork() {
        networkService?.request(from: .init(string: "\(baseURLString)/todos"), method: .get, body: nil, completion: { [weak self] (completion: Result<ToDoListMapper, Error>) in
            switch completion {
            case .success(let list):
                guard let items = list.execute() else { return }
                self?.localStorageService?.save(
                    items: items,
                    transform: ToDoCDEntity.toDomainEntity,
                    configure: { (todo, entity: ToDoCDEntity) in
                        entity.fromToDoEntity(todo)
                    }, completion: { [weak self] (completion: Result<[ToDoEntity], Error>) in
                        switch completion {
                        case .success(let list):
                            self?.output?.onToDoListReceived(list)
                        case .failure(let failure):
                            self?.output?.onError(failure)
                        }
                    })
            case .failure(let failure):
                self?.output?.onError(failure)
            }
        })
    }
    
    func getToDoList() {
        localStorageService?.fetchAll(
            predicate: nil,
            transform: ToDoCDEntity.toDomainEntity,
            completion: { [weak self] (completion: Result<[ToDoEntity], Error>) in
                switch completion {
                case .success(let list):
                    if list.isEmpty {
                        self?.getToDoListFromNetwork()
                    }
                    else {
                        self?.output?.onToDoListReceived(list)
                    }
                case .failure(let failure):
                    self?.output?.onError(failure)
                }
            })
    }
    
    func getFilteredToDoList(_ filter: String) {
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", filter)
        
        self.localStorageService?.fetchAll(
            predicate: predicate,
            transform: ToDoCDEntity.toDomainEntity,
            completion: { [weak self] (completion: Result<[ToDoEntity], Error>) in
                switch completion {
                case .success(let list):
                    self?.output?.onToDoListReceived(list)
                case .failure(let failure):
                    self?.output?.onError(failure)
                }
            })
    }
    
    func addToDo(_ toDo: ToDoEntity) {
        let newToDo = ToDoEntity(
            id: UUID().uuidString,
            title: toDo.title,
            description: toDo.description,
            date: toDo.date,
            isDone: toDo.isDone
        )
        
        self.localStorageService?.save(
            item: newToDo,
            transform: ToDoCDEntity.toDomainEntity,
            configure: { (toDo, entity: ToDoCDEntity) in
                entity.fromToDoEntity(toDo)
            },
            completion: { [weak self] (completion: Result<ToDoEntity, Error>) in
                switch completion {
                case .success(let entity):
                    self?.output?.onToDoAdded(entity)
                case .failure(let failure):
                    self?.output?.onError(failure)
                }
            }
        )
    }
    
    func updateToDo(_ toDo: ToDoEntity) {
        guard let id = toDo.id else { return }
        let predicate = NSPredicate(format: "id == %@", id)
        
        self.localStorageService?.update(
            predicate: predicate,
            transform: ToDoCDEntity.toDomainEntity,
            updates: { (entity: ToDoCDEntity) in
                entity.fromToDoEntity(toDo)
            },
            completion: { [weak self] (completion: Result<ToDoEntity, Error>) in
            switch completion {
            case .success(let entity):
                self?.output?.onToDoUpdated(entity)
            case .failure(let failure):
                self?.output?.onError(failure)
            }
        })
    }
    
    func deleteToDo(_ toDo: ToDoEntity) {
        guard let id = toDo.id else { return }
        let predicate = NSPredicate(format: "id == %@", id)
        
        self.localStorageService?.delete(
            predicate: predicate,
            T: ToDoCDEntity.self,
            completion: { [weak self] (completion: Result<Bool, Error>) in
            switch completion {
            case .success(_):
                self?.output?.onToDoDeleted(nil, removedToDoId: toDo.id)
            case .failure(let failure):
                self?.output?.onError(failure)
            }
        })
    }
}

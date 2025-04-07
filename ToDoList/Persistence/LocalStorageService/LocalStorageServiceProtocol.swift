//
//  CoreDataServiceProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import Foundation
import CoreData

protocol LocalStorageServiceProtocol {
            
    func fetchAll<T: NSManagedObject, U>(predicate: NSPredicate?, transform: @escaping (T) -> U, completion: @escaping (Result<[U], Error>) -> Void)
    
    func save<T: NSManagedObject, U>(item: U, transform: @escaping (T) -> U, configure: @escaping (U, T) -> Void, completion: @escaping (Result<U, Error>) -> Void)
    
    func save<T: NSManagedObject, U>(items: [U], transform: @escaping (T) -> U, configure: @escaping (U, T) -> Void, completion: @escaping (Result<[U], Error>) -> Void)
    
    func update<T: NSManagedObject, U>(predicate: NSPredicate, transform: @escaping (T) -> U, updates: @escaping (T) -> Void, completion: @escaping (Result<U, Error>) -> Void)
    
    func delete<T: NSManagedObject>(predicate: NSPredicate, T: T.Type, completion: @escaping (Result<Bool, Error>) -> Void)
}

//
//  ToDoCDEntity+CoreDataProperties.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//
//

import Foundation
import CoreData


extension ToDoCDEntity {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ToDoCDEntity> {
        return NSFetchRequest<ToDoCDEntity>(entityName: "ToDoCDEntity")
    }
    
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var date: Date?
    @NSManaged public var isDone: Bool
    
}

extension ToDoCDEntity : Identifiable {
    
    convenience init(from todoEntity: ToDoEntity, context: NSManagedObjectContext) {
        self.init(context: context)
        self.id = todoEntity.id
        self.title = todoEntity.title
        self.desc = todoEntity.description
        self.date = todoEntity.date
        self.isDone = todoEntity.isDone
    }
    
    func fromToDoEntity(_ todoEntity: ToDoEntity) {
        self.id = todoEntity.id
        self.title = todoEntity.title
        self.desc = todoEntity.description
        self.date = todoEntity.date
        self.isDone = todoEntity.isDone
    }
    
    func toDomainEntity() -> ToDoEntity {
        return ToDoEntity(
            id: self.id,
            title: self.title ?? "",
            description: self.desc ?? "",
            date: self.date,
            isDone: self.isDone
        )
    }
    
    static func toDomainEntity(_ self: ToDoCDEntity) -> ToDoEntity {
        return ToDoEntity(
            id: self.id,
            title: self.title ?? "",
            description: self.desc ?? "",
            date: self.date,
            isDone: self.isDone
        )
    }
    
}

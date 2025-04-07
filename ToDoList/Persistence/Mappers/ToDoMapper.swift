//
//  ToDoMapper.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

struct ToDoMapper: MapperProtocol {
    
    typealias T = ToDoEntity
    
    let id : Int
    let todo: String
    let completed: Bool
    let userId: Int
    
    func execute() -> ToDoEntity? {
        return .init(
            id: "\(id)",
            title: todo,
            description: "some description",
            date: nil,
            isDone: completed
        )
    }
}

struct ToDoListMapper: MapperProtocol {
    
    typealias T = [ToDoEntity]
    
    let todos: [ToDoMapper]
    let total: Int
    let skip: Int
    let limit: Int
    
    func execute() -> [ToDoEntity]? {
        return todos.compactMap { mapper in
            mapper.execute()
        }
    }
    
}

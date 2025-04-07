//
//  ToDoDataProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

protocol ToDoDataProtocol: AnyObject {
    
    var output: ToDoDataOutput? { get }
    
    func getToDoList()
    
    func getFilteredToDoList(_ filter: String)
    
    func addToDo(_ toDo: ToDoEntity)
    
    func updateToDo(_ toDo: ToDoEntity)
    
    func deleteToDo(_ toDo: ToDoEntity)
    
}

protocol ToDoDataOutput: AnyObject {
    
    func onError(_ error: Error)
    
    func onToDoListReceived(_ toDoList: [ToDoEntity])
    
    func onToDoAdded(_ toDo: ToDoEntity)
    
    func onToDoUpdated(_ toDo: ToDoEntity)
    
    func onToDoDeleted(_ toDo: ToDoEntity?, removedToDoId: String?)
}

extension ToDoDataOutput {
    
    func onError(_ error: Error){}
    
    func onToDoListReceived(_ toDoList: [ToDoEntity]){}
    
    func onToDoAdded(_ toDo: ToDoEntity){}
    
    func onToDoUpdated(_ toDo: ToDoEntity){}
    
    func onToDoDeleted(_ toDo: ToDoEntity?, removedToDoId: String?){}
    
}


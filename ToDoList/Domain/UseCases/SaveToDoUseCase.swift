//
//  SaveToDoUseCase.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

protocol SaveToDoUseCase: AnyObject {
    
    var presenter: SaveToDoOutput? { get }
    
    func saveToDo(_ toDo: ToDoEntity)
}

protocol SaveToDoOutput: AnyObject {
    
    var saveToDoInteractor: SaveToDoUseCase { get }
    
    func onSaveToDoSuccess(_ toDo: ToDoEntity)
    
    func onSaveToDoError(_ error: Error)
    
}

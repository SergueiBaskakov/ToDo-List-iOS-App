//
//  DeleteToDoUseCase.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

protocol DeleteToDoUseCase: AnyObject {
    
    var presenter: DeleteToDoOutput? { get }
    
    func deleteToDo(_ toDo: ToDoEntity)
}

protocol DeleteToDoOutput: AnyObject {
    
    var deleteToDoInteractor: DeleteToDoUseCase { get }
    
    func onDeleteToDoSuccess(_ toDo: ToDoEntity?, removedToDoId: String?)
    
    func onDeleteToDoError(_ error: Error)
    
}

//
//  ChangeToDoStatusUseCase.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

protocol ChangeToDoStatusUseCase: AnyObject {
    
    var presenter: ChangeToDoStatusOutput? { get }
    
    func changeToDoStatus(_ toDo: ToDoEntity)
}

protocol ChangeToDoStatusOutput: AnyObject {
    
    var changeToDoStatusInteractor: ChangeToDoStatusUseCase { get }
    
    func onChangeToDoStatusSuccess(_ toDo: ToDoEntity)
    
    func onChangeToDoStatusError(_ error: Error)
    
}

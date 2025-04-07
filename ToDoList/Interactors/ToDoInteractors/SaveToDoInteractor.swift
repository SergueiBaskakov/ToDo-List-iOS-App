//
//  SaveToDoInteractor.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

import Foundation

class DefaultSaveToDoInteratctor: SaveToDoUseCase, ToDoDataOutput {
    
    weak var presenter: SaveToDoOutput?
    
    var toDoData: ToDoDataProtocol?
    
    func saveToDo(_ toDo: ToDoEntity) {
        if toDo.id == nil {
            toDoData?.addToDo(toDo)
        }
        else {
            toDoData?.updateToDo(toDo)
        }
    }
    
    func onToDoAdded(_ toDo: ToDoEntity) {
        presenter?.onSaveToDoSuccess(toDo)
    }
    
    func onToDoUpdated(_ toDo: ToDoEntity) {
        presenter?.onSaveToDoSuccess(toDo)
    }
    
    func onError(_ error: Error) {
        presenter?.onSaveToDoError(error)
    }
    
}

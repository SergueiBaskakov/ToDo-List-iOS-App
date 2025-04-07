//
//  ChangeToDoStatusInteractor.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

class DefaultChangeToDoStatusInteractor: ChangeToDoStatusUseCase, ToDoDataOutput {
    
    weak var presenter: ChangeToDoStatusOutput?
    
    var toDoData: ToDoDataProtocol?
    
    func changeToDoStatus(_ toDo: ToDoEntity) {
        var newToDo = toDo
        newToDo.isDone.toggle()
        
        toDoData?.updateToDo(newToDo)
    }
    
    func onError(_ error: any Error) {
        presenter?.onChangeToDoStatusError(error)
    }
    
    func onToDoUpdated(_ toDo: ToDoEntity) {
        presenter?.onChangeToDoStatusSuccess(toDo)
    }
    
}

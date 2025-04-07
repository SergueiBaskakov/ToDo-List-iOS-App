//
//  DeleteToDoInteractor.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

class DefaultDeleteToDoInteractor: DeleteToDoUseCase, ToDoDataOutput {
    
    weak var presenter: DeleteToDoOutput?
    
    var toDoData: ToDoDataProtocol?
    
    func deleteToDo(_ toDo: ToDoEntity) {
        toDoData?.deleteToDo(toDo)
    }
    
    func onError(_ error: any Error) {
        presenter?.onDeleteToDoError(error)
    }
    
    func onToDoDeleted(_ toDo: ToDoEntity?, removedToDoId: String?) {
        presenter?.onDeleteToDoSuccess(toDo, removedToDoId: removedToDoId)
    }
}

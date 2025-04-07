//
//  GetToDoListInteractor.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

class DefaultGetToDoListInteractor: GetToDoListUseCase, ToDoDataOutput {
    
    weak var presenter: GetToDoListOutput?
    
    var toDoData: ToDoDataProtocol?
    
    func getToDoList() {
        toDoData?.getToDoList()
    }
    
    func getFilteredToDoList(_ filter: String) {
        toDoData?.getFilteredToDoList(filter)
    }
    
    func onError(_ error: any Error) {
        presenter?.onReceiveToDoListError(error)
    }
    
    func onToDoListReceived(_ toDoList: [ToDoEntity]) {
        presenter?.onReceiveToDoListSuccess(toDoList)
    }
}

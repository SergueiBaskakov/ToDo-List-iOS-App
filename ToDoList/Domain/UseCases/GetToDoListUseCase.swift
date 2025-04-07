//
//  GetToDoListUseCase.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

protocol GetToDoListUseCase: AnyObject {
    
    var presenter: GetToDoListOutput? { get }
    
    func getToDoList()
    
    func getFilteredToDoList(_ filter: String)
}

protocol GetToDoListOutput: AnyObject {
    
    var getToDoListInteractor: GetToDoListUseCase { get }
    
    func onReceiveToDoListSuccess(_ toDoList: [ToDoEntity])
    
    func onReceiveToDoListError(_ error: Error)
    
}

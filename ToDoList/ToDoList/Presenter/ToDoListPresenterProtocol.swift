//
//  ToDoListPresenterProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

protocol ToDoListPresenterProtocol: GetToDoListOutput, ChangeToDoStatusOutput, DeleteToDoOutput {
    
    var view: ToDoListViewControllerProtocol? { get }
    
    var router: ToDoListRouterProtocol? { get }
    
    func deleteToDo(_ toDo: ToDoEntity)
    
    func changeToDoStatus(_ toDo: ToDoEntity)
    
    func getToDoList()
    
    func getFilteredToDoList(_ filter: String)
    
    func newToDo()
    
    func goToDetailToDo(_ toDo: ToDoEntity)
    
}

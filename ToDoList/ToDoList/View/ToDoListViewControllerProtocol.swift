//
//  ToDoListViewControllerProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

protocol ToDoListViewControllerProtocol: AnyObject {
    
    var presenter: ToDoListPresenterProtocol { get }
    
    func showError(_ message: String)
    
    func showToDoList(_ toDoList: [ToDoEntity])
    
    func changeToDoStatus(_ toDo: ToDoEntity)
    
    func deleteToDo(_ toDoId: String)
    
}

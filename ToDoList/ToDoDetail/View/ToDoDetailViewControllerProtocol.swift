//
//  ToDoDetailViewControllerProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

protocol ToDoDetailViewControllerProtocol: AnyObject {
    
    var presenter: ToDoDetailPresenterProtocol { get }
    
    var toDo: ToDoEntity? { get set }
    
    func showError(_ message: String)
    
}

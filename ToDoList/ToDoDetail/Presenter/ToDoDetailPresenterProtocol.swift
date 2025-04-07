//
//  ToDoDetailPresenterProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

protocol ToDoDetailPresenterProtocol: SaveToDoOutput {
    
    var view: ToDoDetailViewControllerProtocol? { get }
    
    var router: ToDoDetailRouterProtocol? { get }
    
    func saveToDo(toDo: ToDoEntity)
    
}

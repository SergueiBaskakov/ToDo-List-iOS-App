//
//  ToDoListRouterProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

import UIKit

protocol ToDoListRouterProtocol {
    
    static func createModule() -> UIViewController
    
    func goToDetail(from view: ToDoListViewControllerProtocol, for toDo: ToDoEntity)
    
    func goToNewToDo(from view: ToDoListViewControllerProtocol)
    
}

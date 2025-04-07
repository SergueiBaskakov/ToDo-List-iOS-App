//
//  ToDoDetailRouterProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import UIKit

protocol ToDoDetailRouterProtocol {
    
    static func createModule(with toDo: ToDoEntity?) -> UIViewController
        
}

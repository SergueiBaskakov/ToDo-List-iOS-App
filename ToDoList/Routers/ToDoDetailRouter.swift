//
//  ToDoDetailRouter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import UIKit

struct DefaultToDoDetailRouter: ToDoDetailRouterProtocol {
    
    static func createModule(with toDo: ToDoEntity?) -> UIViewController {
        
        let saveToDoInteractor = DefaultSaveToDoInteratctor()
        
        let networkService = DefaultNetworkService()
        let localStorageService = DefaultLocalStorageService(containerName: "ToDoList", entityType: ToDoCDEntity.self)
                
        let presenter = DefaultToDoDetailPresenter(
            saveToDoInteractor: saveToDoInteractor,
            router: Self()
        )
        
        saveToDoInteractor.presenter = presenter
        
        saveToDoInteractor.toDoData = DefaultToDoData(output: saveToDoInteractor, networkService: networkService, localStorageService: localStorageService, baseURLString: Environment.baseURL)
        
        let view = DefaultToDoDetailViewController(presenter: presenter, toDo: toDo)
        
        presenter.view = view

        return view
    }
    
}

//
//  ToDoListRouter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 04.04.2025.
//

import UIKit

struct DefaultToDoListRouter: ToDoListRouterProtocol {
    
    static func createModule() -> UIViewController {
        
        let getToDoListInteractor = DefaultGetToDoListInteractor()
        let deleteToDoInteractor = DefaultDeleteToDoInteractor()
        let changeToDoStatusInteractor = DefaultChangeToDoStatusInteractor()
        
        let networkService = DefaultNetworkService()
        let localStorageService = DefaultLocalStorageService(containerName: "ToDoList", entityType: ToDoCDEntity.self)
        
        getToDoListInteractor.toDoData = DefaultToDoData(output: getToDoListInteractor, networkService: networkService, localStorageService: localStorageService, baseURLString: Environment.baseURL)
        
        deleteToDoInteractor.toDoData = DefaultToDoData(output: deleteToDoInteractor, networkService: networkService, localStorageService: localStorageService, baseURLString: Environment.baseURL)
                
        changeToDoStatusInteractor.toDoData = DefaultToDoData(output: changeToDoStatusInteractor, networkService: networkService, localStorageService: localStorageService, baseURLString: Environment.baseURL)
        
        let presenter = DefaultToDoListPresenter(
            getToDoListInteractor: getToDoListInteractor,
            deleteToDoInteractor: deleteToDoInteractor,
            changeToDoStatusInteractor: changeToDoStatusInteractor,
            router: Self()
        )
        
        getToDoListInteractor.presenter = presenter
        deleteToDoInteractor.presenter = presenter
        changeToDoStatusInteractor.presenter = presenter
        
        let view = DefaultToDoListViewController(presenter: presenter)
        
        presenter.view = view

        return view
    }
    
    func goToDetail(from view: ToDoListViewControllerProtocol, for toDo: ToDoEntity) {
        
        let newViewController = DefaultToDoDetailRouter.createModule(with: toDo)
        
        guard let currentViewController = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        currentViewController.navigationController?.pushViewController(newViewController, animated: true)
         
    }
    
    func goToNewToDo(from view: ToDoListViewControllerProtocol) {
        
        let newViewController = DefaultToDoDetailRouter.createModule(with: nil)
        
        guard let currentViewController = view as? UIViewController else {
            fatalError("Invalid View Protocol type")
        }
        
        currentViewController.navigationController?.pushViewController(newViewController, animated: true)
         
    }
}

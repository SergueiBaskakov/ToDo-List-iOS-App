//
//  MockGetToDoListPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import Foundation
@testable import ToDoList

class MockGetToDoListPresenter: GetToDoListOutput {
    
    var getToDoListInteractor: GetToDoListUseCase
    
    init(getToDoListInteractor: GetToDoListUseCase) {
        self.getToDoListInteractor = getToDoListInteractor
    }
    
    var didReceiveSuccess = false
    var didReceiveError = false
    var receivedToDoList: [ToDoEntity] = []
    
    func onReceiveToDoListSuccess(_ toDoList: [ToDoEntity]) {
        didReceiveSuccess = true
        receivedToDoList = toDoList
    }
    
    func onReceiveToDoListError(_ error: Error) {
        didReceiveError = true
    }
}

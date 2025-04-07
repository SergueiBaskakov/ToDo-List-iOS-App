//
//  MockChangeToDoStatusPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import Foundation
@testable import ToDoList

class MockChangeToDoStatusPresenter: ChangeToDoStatusOutput {
    
    var changeToDoStatusInteractor: ChangeToDoStatusUseCase
    
    init(changeToDoStatusInteractor: ChangeToDoStatusUseCase) {
        self.changeToDoStatusInteractor = changeToDoStatusInteractor
    }

    var successCalled = false
    var successToDo: ToDoEntity?

    var errorCalled = false
    var receivedError: Error?

    func onChangeToDoStatusSuccess(_ toDo: ToDoEntity) {
        successCalled = true
        successToDo = toDo
    }

    func onChangeToDoStatusError(_ error: Error) {
        errorCalled = true
        receivedError = error
    }
}

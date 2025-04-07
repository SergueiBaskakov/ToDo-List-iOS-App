//
//  MockSaveToDoPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import Foundation
@testable import ToDoList

class MockSaveToDoPresenter: SaveToDoOutput {

    var saveToDoInteractor: SaveToDoUseCase
    
    init(saveToDoInteractor: SaveToDoUseCase) {
        self.saveToDoInteractor = saveToDoInteractor
    }

    var successCalled = false
    var receivedToDo: ToDoEntity?

    var errorCalled = false
    var receivedError: Error?

    func onSaveToDoSuccess(_ toDo: ToDoEntity) {
        successCalled = true
        receivedToDo = toDo
    }

    func onSaveToDoError(_ error: Error) {
        errorCalled = true
        receivedError = error
    }
}

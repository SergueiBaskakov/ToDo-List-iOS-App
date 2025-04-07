//
//  MockDeleteToDoPresenter.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//
import Foundation
@testable import ToDoList

class MockDeleteToDoPresenter: DeleteToDoOutput {
    
    var deleteToDoInteractor: DeleteToDoUseCase
    
    init(deleteToDoInteractor: DeleteToDoUseCase) {
        self.deleteToDoInteractor = deleteToDoInteractor
    }
    
    var successCalled = false
    var receivedToDo: ToDoEntity?
    var receivedId: String?

    var errorCalled = false
    var receivedError: Error?

    func onDeleteToDoSuccess(_ toDo: ToDoEntity?, removedToDoId: String?) {
        successCalled = true
        receivedToDo = toDo
        receivedId = removedToDoId
    }

    func onDeleteToDoError(_ error: Error) {
        errorCalled = true
        receivedError = error
    }
}

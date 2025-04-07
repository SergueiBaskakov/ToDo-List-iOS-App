//
//  ChangeToDoStatusInteractorTests.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import XCTest
@testable import ToDoList

final class ChangeToDoStatusInteractorTests: XCTestCase {

    var interactor: DefaultChangeToDoStatusInteractor!
    var mockToDoData: MockToDoData!
    var mockPresenter: MockChangeToDoStatusPresenter!

    override func setUp() {
        super.setUp()
        interactor = DefaultChangeToDoStatusInteractor()
        mockToDoData = MockToDoData()
        mockPresenter = MockChangeToDoStatusPresenter(changeToDoStatusInteractor: interactor)
        
        interactor.toDoData = mockToDoData
        interactor.presenter = mockPresenter
        mockToDoData.output = interactor
    }

    func testChangeToDoStatus_callsUpdateToDoWithToggledStatus() {
        let original = ToDoEntity(id: "001", title: "Test", description: "Test desc", date: nil, isDone: false)
        
        interactor.changeToDoStatus(original)
        
        XCTAssertTrue(mockToDoData.updateToDoCalled)
        XCTAssertEqual(mockToDoData.updatedToDo?.isDone, true)
    }

    func testOnToDoUpdated_callsPresenterSuccess() {
        let updated = ToDoEntity(id: "002", title: "Updated", description: "Updated desc", date: nil, isDone: true)
        
        interactor.onToDoUpdated(updated)
        
        XCTAssertTrue(mockPresenter.successCalled)
        XCTAssertEqual(mockPresenter.successToDo?.id, updated.id)
    }

    func testOnError_callsPresenterError() {
        let error = NSError(domain: "Test", code: 1)
        
        interactor.onError(error)
        
        XCTAssertTrue(mockPresenter.errorCalled)
        XCTAssertNotNil(mockPresenter.receivedError)
    }
}

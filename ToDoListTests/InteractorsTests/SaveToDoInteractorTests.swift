//
//  SaveToDoInteractorTests.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import XCTest
@testable import ToDoList

final class SaveToDoInteractorTests: XCTestCase {

    var interactor: DefaultSaveToDoInteratctor!
    var mockToDoData: MockToDoData!
    var mockPresenter: MockSaveToDoPresenter!

    override func setUp() {
        super.setUp()
        interactor = DefaultSaveToDoInteratctor()
        mockToDoData = MockToDoData()
        mockPresenter = MockSaveToDoPresenter(saveToDoInteractor: interactor)

        interactor.toDoData = mockToDoData
        interactor.presenter = mockPresenter
        mockToDoData.output = interactor
    }

    func testSaveToDo_withNilID_callsAddToDo() {
        var toDo = ToDoEntity(id: nil, title: "Test", description: "Add this", date: nil, isDone: false)

        interactor.saveToDo(toDo)

        XCTAssertTrue(mockToDoData.addToDoCalled)
        XCTAssertEqual(mockToDoData.addedToDo?.title, "Test")
    }

    func testSaveToDo_withID_callsUpdateToDo() {
        let toDo = ToDoEntity(id: "001", title: "Existing", description: "Update this", date: nil, isDone: false)

        interactor.saveToDo(toDo)

        XCTAssertTrue(mockToDoData.updateToDoCalled)
        XCTAssertEqual(mockToDoData.updatedToDo?.title, "Existing")
    }

    func testOnToDoAdded_callsPresenterSuccess() {
        let toDo = ToDoEntity(id: "002", title: "Added", description: "Test", date: nil, isDone: false)

        interactor.onToDoAdded(toDo)

        XCTAssertTrue(mockPresenter.successCalled)
        XCTAssertEqual(mockPresenter.receivedToDo?.title, "Added")
    }

    func testOnToDoUpdated_callsPresenterSuccess() {
        let toDo = ToDoEntity(id: "003", title: "Updated", description: "Test", date: nil, isDone: true)

        interactor.onToDoUpdated(toDo)

        XCTAssertTrue(mockPresenter.successCalled)
        XCTAssertEqual(mockPresenter.receivedToDo?.title, "Updated")
    }

    func testOnError_callsPresenterError() {
        let error = NSError(domain: "SaveToDo", code: 999)

        interactor.onError(error)

        XCTAssertTrue(mockPresenter.errorCalled)
        XCTAssertNotNil(mockPresenter.receivedError)
    }
}

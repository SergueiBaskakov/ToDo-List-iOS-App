//
//  DeleteToDoInteractorTests.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import XCTest
@testable import ToDoList

final class DeleteToDoInteractorTests: XCTestCase {

    var interactor: DefaultDeleteToDoInteractor!
    var mockToDoData: MockToDoData!
    var mockPresenter: MockDeleteToDoPresenter!

    override func setUp() {
        super.setUp()
        interactor = DefaultDeleteToDoInteractor()
        mockToDoData = MockToDoData()
        mockPresenter = MockDeleteToDoPresenter(deleteToDoInteractor: interactor)
        
        interactor.toDoData = mockToDoData
        interactor.presenter = mockPresenter
        mockToDoData.output = interactor
    }

    func testDeleteToDo_callsDataLayerWithCorrectToDo() {
        let toDo = ToDoEntity(id: "001", title: "Test", description: "Test desc", date: nil, isDone: false)
        
        interactor.deleteToDo(toDo)
        
        XCTAssertTrue(mockToDoData.deleteToDoCalled)
        XCTAssertEqual(mockToDoData.deletedToDo?.id, toDo.id)
    }

    func testOnToDoDeleted_callsPresenterSuccess() {
        let toDo = ToDoEntity(id: "002", title: "ToDelete", description: "desc", date: nil, isDone: true)
        let id = toDo.id
        
        interactor.onToDoDeleted(toDo, removedToDoId: id)
        
        XCTAssertTrue(mockPresenter.successCalled)
        XCTAssertEqual(mockPresenter.receivedToDo?.id, toDo.id)
        XCTAssertEqual(mockPresenter.receivedId, id)
    }

    func testOnError_callsPresenterError() {
        let error = NSError(domain: "TestError", code: 500)
        
        interactor.onError(error)
        
        XCTAssertTrue(mockPresenter.errorCalled)
        XCTAssertNotNil(mockPresenter.receivedError)
    }
}

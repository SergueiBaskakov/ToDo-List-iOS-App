//
//  DefaultGetToDoListInteractorTests.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import XCTest
@testable import ToDoList

class DefaultGetToDoListInteractorTests: XCTestCase {
    
    var interactor: DefaultGetToDoListInteractor!
    var mockPresenter: MockGetToDoListPresenter!
    var mockToDoData: MockToDoData!
    
    override func setUp() {
        super.setUp()
        interactor = DefaultGetToDoListInteractor()
        mockPresenter = MockGetToDoListPresenter(getToDoListInteractor: interactor)
        mockToDoData = MockToDoData()
        
        interactor.presenter = mockPresenter
        interactor.toDoData = mockToDoData
    }
    
    func test_getToDoList_callsDataLayer() {
        interactor.getToDoList()
        XCTAssertTrue(mockToDoData.didCallGetToDoList)
    }
    
    func test_getFilteredToDoList_callsDataLayerWithCorrectFilter() {
        let filter = "important"
        interactor.getFilteredToDoList(filter)
        XCTAssertTrue(mockToDoData.didCallGetFilteredToDoList)
        XCTAssertEqual(mockToDoData.lastFilter, filter)
    }
    
    func test_onToDoListReceived_callsPresenterWithList() {
        let sampleToDos = [ToDoEntity(id: "001", title: "Some Title", description: "Some description", date: nil, isDone: false)]
        interactor.onToDoListReceived(sampleToDos)
        XCTAssertTrue(mockPresenter.didReceiveSuccess)
        XCTAssertEqual(mockPresenter.receivedToDoList.count, 1)
    }
    
    func test_onError_callsPresenterError() {
        interactor.onError(NSError(domain: "Test", code: 1))
        XCTAssertTrue(mockPresenter.didReceiveError)
    }
}

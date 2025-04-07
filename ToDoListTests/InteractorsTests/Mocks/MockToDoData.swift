//
//  MockToDoData.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import Foundation
@testable import ToDoList

class MockToDoData: ToDoDataProtocol {
    
    var output: ToDoDataOutput?
    
    var didCallGetToDoList = false
    var didCallGetFilteredToDoList = false
    var lastFilter: String?
    
    var updateToDoCalled = false
    var updatedToDo: ToDoEntity?
    
    var deleteToDoCalled = false
    var deletedToDo: ToDoEntity?
    
    var addToDoCalled = false
    var addedToDo: ToDoEntity?
    
    func getToDoList() {
        didCallGetToDoList = true
    }
    
    func getFilteredToDoList(_ filter: String) {
        didCallGetFilteredToDoList = true
        lastFilter = filter
    }
    
    func addToDo(_ toDo: ToDoEntity) {
        addToDoCalled = true
        addedToDo = toDo
    }
    
    func updateToDo(_ toDo: ToDoEntity) {
        updateToDoCalled = true
        updatedToDo = toDo
    }
    
    func deleteToDo(_ toDo: ToDoEntity) {
        deleteToDoCalled = true
        deletedToDo = toDo
    }
}

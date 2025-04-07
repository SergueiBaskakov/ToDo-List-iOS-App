//
//  ToDoEntity.swift
//  ToDoList
//
//  Created by Serguei Diaz on 03.04.2025.
//

import Foundation

struct ToDoEntity: Hashable {
    let id: String?
    let title: String
    let description: String
    let date: Date?
    var isDone: Bool
}

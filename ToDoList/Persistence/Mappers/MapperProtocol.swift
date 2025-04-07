//
//  MapperProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

protocol MapperProtocol: Codable {
    
    associatedtype T
    
    func execute() -> T?
    
}

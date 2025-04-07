//
//  NetworkServiceProtocol.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import Foundation

protocol NetworkServiceProtocol {
    func request<T: Decodable>(from url: URL?, method: networkMethod, body: Data?, completion: @escaping (Result<T, Error>) -> Void)
}

enum networkMethod: String {
    case get = "GET"
    case post = "POST"
}

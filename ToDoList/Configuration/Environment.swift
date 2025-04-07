//
//  Environment.swift
//  ToDoList
//
//  Created by Serguei Diaz on 07.04.2025.
//

import Foundation

enum Environment {
    static let baseURL: String = {
        guard let baseURL = Bundle.main.object(forInfoDictionaryKey: "BASE_URL") as? String else {
            fatalError("BASE_URL not set in Info.plist")
        }
        return "https://\(baseURL)"
    }()
}

//
//  Untitled.swift
//  ToDoList
//
//  Created by Serguei Diaz on 06.04.2025.
//

import Foundation

class DefaultNetworkService: NetworkServiceProtocol {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func request<T: Decodable>(from url: URL?, method: networkMethod, body: Data?, completion: @escaping (Result<T, Error>) -> Void) {
        
            guard let url = url else {
                completion(.failure(NSError(domain: "Invalid URL", code: 0, userInfo: nil)))
                return
            }
            
            var request = URLRequest(url: url)
            request.httpMethod = method.rawValue
            request.httpBody = body
            
            let task = self.session.dataTask(with: request) { data, response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                    return
                }
                
                guard
                    let httpResponse = response as? HTTPURLResponse,
                    (200..<300).contains(httpResponse.statusCode),
                    let data = data
                else {
                    DispatchQueue.main.async {
                        completion(.failure(NSError(domain: "Invalid response", code: 0)))
                    }
                    return
                }
                
                do {
                    let decoded = try JSONDecoder().decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(decoded))
                    }
                } catch {
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
            task.resume()
    }
}


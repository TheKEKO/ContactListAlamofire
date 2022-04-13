//
//  NetworkManager.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import Foundation
import Alamofire

enum Link: String {
    case infoURL = "https://jsonplaceholder.typicode.com/users"
}

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func downloadJSON(_ url: String, completion: @escaping(Result<[Person], NetworkError>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let courses = Person.getCourses(from: value)
                    completion(.success(courses))
                case .failure(let error):
                    print(error)
                    completion(.failure(.decodingError))
                }
            }
    }
}

//
//  NetworkManager.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    static let infoURL = "https://api.randomuser.me/?results=20"
    
    enum NetworkError: Error {
        case invalidUrl
        case noData
        case decodingError
        case encodingError
    }
    
    static func downloadJSON(url: String, completion: @escaping (Result<[Contact], Error>) -> Void) {
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let news = Person.getResult(value: value)
                    DispatchQueue.main.async {
                        completion(.success(news))
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        completion(.failure(error))
                    }
                }
            }
    }
}

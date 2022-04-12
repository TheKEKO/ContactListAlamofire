//
//  NetworkManager.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func downloadJSON(completed: @escaping ([Person]) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/users") else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let persons = try JSONDecoder().decode([Person].self, from: data)
                
                completed(persons)
                
            } catch let error {
                print(error)
            }
        }
        .resume()
    }
}

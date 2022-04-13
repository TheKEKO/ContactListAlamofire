//
//  Person.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

struct Person:Codable {
    
    let name: String?
    let username: String?
    let email: String?
    let phone: String?
    let website: String?
    
    init(personData: [String: Any]) {
        name = personData["name"] as? String
        username = personData["username"] as? String
        email = personData["email"] as? String
        phone = personData["phone"] as? String
        website = personData["website"] as? String
    }
    
    static func getUsers(from value: Any) -> [Person] {
        guard let personData = value as? [[String: Any]] else { return [] }
        return personData.compactMap { Person(personData: $0) }
    }
}

enum Contacts: String {
    case phone = "phone"
    case email = "tray"
}


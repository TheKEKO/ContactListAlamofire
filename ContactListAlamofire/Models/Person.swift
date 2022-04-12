//
//  Person.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//

import Foundation

struct Person:Decodable {
    let name: String
    let username: String
    let email: String
    let phone: String
    var website: String
    
    var fullName: String {
        "\(name) \(username)"
    }
}

enum Contacts: String {
    case phone = "phone"
    case email = "tray"
}


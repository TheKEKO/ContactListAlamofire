//
//  Person.swift
//  ContactListAlamofire
//
//  Created by Aleksandr F. on 12.04.2022.
//
// отсюда меняю проект

// MARK: - Person
struct Person: Codable {
    
    let results: [Contact]?
    
    static func getResult(value: Any) -> [Contact] {
        guard let value = value as? [String: Any],
              let currenciesData = value["results"] else { return [] }
        let currencies = Contact.getContact(value: currenciesData)
        return currencies
    }
}

struct Contact: Codable {
    let name: Name?
    let email: String?
    let phone: String?
    
    init(value: [String: Any]) {
        name = value["name"] as? Name
        email = value["email"] as? String
        phone = value["phone"] as? String
    }
    
    static func getContact(value: Any) -> [Contact] {
        guard let value = value as? [[String:Any]] else { return [] }
        return value.compactMap { Contact(value: $0) }
    }
}

// я так и не понял как передать Name (((
// разберите на разборе, пожалуйста

    struct Name: Codable {
        let title: String?
        let first: String?
        let last: String?

        init(value: [String: Any]) {
            title = value["title"] as? String
            first = value["first"] as? String
            last = value["last"] as? String
        }

        static func getName(value: Any) -> [Contact] {
            guard let value = value as? [[String:Any]] else { return [] }
            return value.compactMap { Contact(value: $0) }
        }
    }

enum Contacts: String {
    case phone = "phone"
    case email = "tray"
}


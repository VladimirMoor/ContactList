//
//  Contact.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import Foundation

class ListOfContacts: ObservableObject, Identifiable {
    @Published var list: [Contact] = []
}

struct Contact: Codable, Identifiable, Comparable {

    var id = UUID()
    let fullName: String
    let email: String
    let interest: String
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.fullName < rhs.fullName
    }
    
}

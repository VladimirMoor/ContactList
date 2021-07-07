//
//  Contact.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import Foundation

class ListOfContacts: ObservableObject, Identifiable {
    @Published var list: [Contact]
    init() {
        list = []
    }
}

struct Contact: Codable, Identifiable {
    
    var id = UUID()
    let fullName: String
    let email: String
    let interest: String
    
}

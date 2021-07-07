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
    
//
//    enum CodingKeys: CodingKey {
//        case list
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(list, forKey: .list)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        list = try container.decode([Contact].self, forKey: .list)
//    }
    
}

struct Contact: Codable, Identifiable {
    
    var id = UUID()
    let fullName: String
    let email: String
    let interest: String
    
}

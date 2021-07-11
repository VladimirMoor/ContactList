//
//  Contact.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import Foundation
import MapKit

class ListOfContacts: ObservableObject, Identifiable {
    @Published var list: [Contact] = []
}

struct Contact: Codable, Identifiable, Comparable {

    var id = UUID()
    let fullName: String
    let email: String
    let interest: String
    let lat: CLLocationDegrees
    let long: CLLocationDegrees
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
    
    static func < (lhs: Contact, rhs: Contact) -> Bool {
        return lhs.fullName < rhs.fullName
    }
    
}

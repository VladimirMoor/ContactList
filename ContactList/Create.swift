//
//  Create.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI

struct Create: View {
    
    @ObservedObject var myList: ListOfContacts
    var image: UIImage?
    
    
    var body: some View {
        if image != nil {
            Text("Hi image!")
        } else {
            Text("Image is nil")
        }
    }
}


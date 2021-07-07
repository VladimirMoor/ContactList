//
//  Create.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI

struct Create: View {
    var image: UIImage
    
    var body: some View {
        VStack {
            
            Image(uiImage: image)
                .resizable()
                .frame(width: 100, height: 100)
            Text("Hi")
        }
    }
}


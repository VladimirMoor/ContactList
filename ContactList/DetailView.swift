//
//  DetailView.swift
//  ContactList
//
//  Created by Vladimir on 08.07.2021.
//

import SwiftUI

struct DetailView: View {
    
    var showContact: Contact
    private var image: UIImage {
        var image = UIImage()
        let url = Helper.getDocumentDirectory().appendingPathComponent(showContact.id.uuidString)
        
        do {
        let data = try Data(contentsOf: url)
        image = UIImage(data: data) ?? UIImage(systemName: "person")!
        
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    var body: some View {
        VStack {
            Image(uiImage: image)
                .resizable()
                .scaledToFit()
            
            Text(showContact.fullName)
                .font(.headline)
                .fontWeight(.heavy)
            Text(showContact.interest)
                .onAppear() {
                    print("\(showContact.coordinate)")
                }
            
        }
    }
}


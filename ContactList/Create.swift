//
//  Create.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI

struct Create: View {
    
    var image: UIImage
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var myList: ListOfContacts
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var interest = ""
    
    var body: some View {
        VStack {
            Form {
            Image(uiImage: image)
                .resizable()
                .frame(width: 150, height: 150)
                
                Section {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                    TextField("Interest", text: $interest)
                }
                
                Section {
                    Button("Save") {
                        let contact = Contact(fullName: fullName, email: email, interest: interest)
                        
                        // saving Image to file:
                        saveImage(with: contact.id)
                        
                        myList.list.append(contact)
                        myList.list.sort()
                        
                        // saving myList to file:
                        do {
                            let filename = Helper.getDocumentDirectory().appendingPathComponent("SavedList")
                            let data = try JSONEncoder().encode(self.myList.list)
                            try data.write(to: filename, options: [.atomicWrite, .completeFileProtection])
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
        }
    }

    
    func saveImage(with contactID: UUID) {
        
        let url = Helper.getDocumentDirectory().appendingPathComponent(contactID.uuidString)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
            print("Image write to file: \(url.absoluteString)")
        }
    }
}

class Helper {
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


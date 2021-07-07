//
//  ContentView.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @ObservedObject var myList = ListOfContacts()
    @State private var showPicker = false
    @State private var inputImage: UIImage?
    @State private var showCreate = false
    @State private var newContact = Contact(fullName: "", email: "", interest: "")
    
    var body: some View {
        NavigationView {
            VStack {
                    
            List(myList.list) { contact in
                Text(contact.fullName)
            }
            .navigationTitle("Contacts")
            .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    showPicker = true
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
            .sheet(isPresented: $showPicker, onDismiss: showCreateView) {
                ImagePicker(presentPicker: $showPicker, newContact: $newContact)
         }
        
        }
      }
        .sheet(isPresented: $showCreate, content: {
            Text(newContact.id.uuidString)
            
        })
    }
    
    func showCreateView() {
        showCreate = true
        
    }
    

    func loadImage() {
        let url = Api.getDocumentDirectory().appendingPathComponent(newContact.id.uuidString)
        do {
            let data = try Data(contentsOf: url)
            self.inputImage = UIImage(data: data)

        } catch {
            print(error.localizedDescription)
        }
    }
}


class Api {
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}

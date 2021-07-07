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
    @State private var showCreate = false
    @State private var inputImage = UIImage(systemName: "person")!
    @State private var newContact = Contact(fullName: "", email: "", interest: "")
    @State private var cancelPressed = false
    
    var body: some View {
        NavigationView {
            
            List(myList.list) { contact in
                HStack {
                    
                ContactImage(imageID: contact.id)
                    
                VStack(alignment: .leading, spacing: 5) {
                Text("Full Name: \(contact.fullName)")
                Text("Email: \(contact.email)")
                Text("Interest: \(contact.interest)")
                }
            }
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
            ImagePicker(presentPicker: $showPicker, image: $inputImage, cancelPressed: $cancelPressed)
            }
      }
        .sheet(isPresented: $showCreate) {
            Create(image: inputImage, myList: myList)
        }
        .onAppear(perform: loadList)
    }
    
    func showCreateView() {
        if !cancelPressed {
        showCreate = true
        }
        
    }
    
    func loadList() {
        let filename = Helper.getDocumentDirectory().appendingPathComponent("SavedList")
        
        do {
            let data = try Data(contentsOf: filename)
            myList.list = try JSONDecoder().decode([Contact].self, from: data)
            
        } catch {
            print("Some error produced while loading listFile to myList:")
            print(error.localizedDescription)
        }
    }
}

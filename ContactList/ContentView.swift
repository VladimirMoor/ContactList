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
            ImagePicker(presentPicker: $showPicker, image: $inputImage, cancelPressed: $cancelPressed)
            }
      }
        .sheet(isPresented: $showCreate) {
            Create(image: inputImage)
        }
    }
    
    func showCreateView() {
        if !cancelPressed {
        showCreate = true
        }
        
    }

//    func loadImage(withId: UUID) -> UIImage? {
//        let url = Api.getDocumentDirectory().appendingPathComponent(withId.uuidString)
//        do {
//            print("trying to load image with ID --- \(withId.uuidString)")
//            let data = try Data(contentsOf: url)
//            return UIImage(data: data) ?? UIImage(systemName: "person")!
//        } catch {
//            print(error.localizedDescription)
//        }
//
//        return nil
//    }
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

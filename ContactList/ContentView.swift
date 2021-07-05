//
//  ContentView.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var contacts: [Contact] = []
    @State private var showPicker = false
    
    var body: some View {
        NavigationView {
        List(contacts) { contact in
            VStack {
                Text(contact.fullName)
            }
        }
        .navigationTitle("Contacts")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    print("test")
                }, label: {
                    Image(systemName: "plus")
                })
            }
        }
      }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

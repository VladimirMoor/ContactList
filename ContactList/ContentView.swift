//
//  ContentView.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    @ObservedObject var myList = ListOfContacts()
    @State private var showPicker = false
    @State private var showCreate = false
    @State private var inputImage = UIImage(systemName: "person")!
    @State private var cancelPressed = false
    @State private var showMap = false
    
    
    var body: some View {
        NavigationView {
            
            List(myList.list) { contact in
                NavigationLink(destination: DetailView(showContact: contact)) {
                    HStack {
                        
                        ContactImage(imageID: contact.id)
                        
                        VStack(alignment: .leading, spacing: 5) {
                            
                            Text("Full Name: \(contact.fullName)")
                            Text("Email: \(contact.email)")
                            Text("Interest: \(contact.interest)")
                            
                        }
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
                
                ToolbarItem(placement: .navigationBarLeading) {
                    NavigationLink(destination: MapToShow(myList: myList)) {
                        Text("Map")
                    }
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

struct MapToShow: View {
    
    @ObservedObject var myList: ListOfContacts
    
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 13.00, longitude: 16.00), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180))

    var body: some View {
        Map(coordinateRegion: $region, annotationItems: myList.list ) { pin in
            
            MapAnnotation(coordinate: pin.coordinate, anchorPoint: CGPoint(x: 0.5, y: 1)) {
                NavigationLink(destination: DetailView(showContact: pin)) {
                VStack {
                    
                Text(pin.fullName)
                    .background(Color.green)
                    .opacity(0.7)
                    
                Image(systemName: "figure.wave")
                }
                }
            }
            
        }
        .navigationTitle("Meeting Map")

    }
}


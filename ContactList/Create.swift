//
//  Create.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI
import MapKit

struct Create: View {
    
    var image: UIImage
    
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var myList: ListOfContacts
    
    @State private var fullName = ""
    @State private var email = ""
    @State private var interest = ""
    @State private var annotationCoordinates = CLLocationCoordinate2D()
    @State private var showMap = false
    
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
                    Button("Add meeting point") {
                        showMap = true
                    }
                }
                
                Section {
                    Button("Save") {
                        let contact = Contact(fullName: fullName, email: email, interest: interest, lat: annotationCoordinates.latitude, long: annotationCoordinates.longitude)
                        
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
        .sheet(isPresented: $showMap) {
            MapToSave(pointCoordinate: $annotationCoordinates)
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

struct MapToSave: View {
    
    @Environment(\.presentationMode) var presentationMode
    @Binding var pointCoordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 13.00, longitude: 80.00), span: MKCoordinateSpan(latitudeDelta: 180, longitudeDelta: 180))
    @State private var tracking: MKUserTrackingMode = .follow
    
    
    var body: some View {
        ZStack {
            
            Map(coordinateRegion: $region)
            
            Circle()
                .fill(Color.blue)
                .opacity(0.3)
                .frame(width: 30, height: 30)
            Image(systemName: "plus")
                .resizable()
                .opacity(0.4)
                .frame(width: 10, height: 10)
            VStack {
                Spacer()
                HStack {
                    Spacer()
                    Button("Save") {
                        pointCoordinate = region.center
                        print(pointCoordinate)
                        print("Saved")
                        presentationMode.wrappedValue.dismiss()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.black.opacity(0.4))
                    .clipShape(Circle())
                    .padding(.bottom, 40)
                    .padding(.trailing, 30)
                }
            }
            
        }
    }
}

class Helper {
    static func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}


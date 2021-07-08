//
//  ContactImage.swift
//  ContactList
//
//  Created by Vladimir on 07.07.2021.
//

import SwiftUI

struct ContactImage: View {
    
    var imageID: UUID
    
    private var image: UIImage {
        var image = UIImage()
        let url = Helper.getDocumentDirectory().appendingPathComponent(imageID.uuidString)
        
        do {
        let data = try Data(contentsOf: url)
        image = UIImage(data: data) ?? UIImage(systemName: "person")!
        
        } catch {
            print(error.localizedDescription)
        }
        return image
    }
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .frame(width: 100, height: 100)
    }
}


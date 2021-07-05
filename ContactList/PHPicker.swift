//
//  PHPicker.swift
//  ContactList
//
//  Created by Vladimir on 05.07.2021.
//

import SwiftUI
import PhotosUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @Binding var image: UIImage
    @Binding var presentPicker: Bool
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        config.selectionLimit = 1
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
        
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController , context: Context) {
    }
    
    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        
        var parent: ImagePicker
        
        init(parent1: ImagePicker) {
            parent = parent1
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            
            parent.presentPicker.toggle()
            guard let img = results.first else { return }
            if img.itemProvider.canLoadObject(ofClass: UIImage.self) {
                img.itemProvider.loadObject(ofClass: UIImage.self) { image, error in
                    guard let image1 = image else {
                        print(error?.localizedDescription ?? "Unknown error in loading image from picker")
                        return
                    }
                    
                    self.parent.image = image1 as! UIImage
            
                }
            } else {
                print("Cannot load image")
            }
            
        }
        
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent1: self)
    }
    
}

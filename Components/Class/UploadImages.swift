//
//  UploadImages.swift
//  E-commerce
//
//  Created by Erick Gámez Sánchez on 07/12/23.
//

import SwiftUI

//clase para subir imagenes desde galeria y camara
class ImagePickerCoordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @Binding var image: UIImage?
    @Binding var isImagePickerPresented: Bool
    @Binding var imageIdentifier : String? //ruta de imagen

    init(image: Binding<UIImage?>, isImagePickerPresented: Binding<Bool>, imageIdentifier: Binding<String?>) {
        _image = image
        _isImagePickerPresented = isImagePickerPresented
        _imageIdentifier = imageIdentifier
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let uiImage = info[.originalImage] as? UIImage {
            image = uiImage
            if let url = info[.imageURL] as? URL{
                imageIdentifier = url.absoluteString
            }
        }
        isImagePickerPresented = false
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        isImagePickerPresented = false
    }
}

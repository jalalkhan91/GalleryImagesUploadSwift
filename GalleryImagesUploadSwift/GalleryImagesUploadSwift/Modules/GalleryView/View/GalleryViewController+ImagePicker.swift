//
//  GalleryViewController+ImagePicker.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 27/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit
import MobileCoreServices


extension GalleryViewController {
    
    
    func openCamera() {
        if(UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera)) {
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Alert!", message: "No camera found", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary() {
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.mediaTypes = [kUTTypeImage as String]
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func openImageOptionsPicker(sourceView: UIBarButtonItem) {
        
        let alert = UIAlertController.actionSheetImageUpload(title: "Choose image from:", message: "Images you upload will not be shared with any third party platforms", gallery: { _ in
            self.openGallary()
        }) { _ in
            self.openCamera()
        }
        
        self.present(alert, animated: true, completion: nil)
    }
    
    
}

// MARK:- UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension GalleryViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        dismiss(animated:true, completion: nil)
        if let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String {
            if mediaType  == "public.image" {
                let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage ?? info[UIImagePickerController.InfoKey.originalImage] as! UIImage
                print(image)
//                presenter?.userDidSelectImageToUpload(image: selectedImage)
                self.selectedImage = image
                self.showAlertControllerWithDescription()
            }
        }
    }
}


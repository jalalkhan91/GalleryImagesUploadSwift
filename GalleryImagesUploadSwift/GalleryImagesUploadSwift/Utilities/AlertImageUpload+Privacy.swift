//
//  AlertImageUpload+Privacy.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 10/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController{
    
    static func actionSheet(title:String, message:String, actions:[UIAlertAction]) -> UIAlertController{
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for action in actions{
            alert.addAction(action)
        }
        
        return alert
    }
    
    static func actionSheetImageUpload(title:String,
                                       message:String,
                                       gallery: @escaping (UIAlertAction)-> Void,
                                       camera: @escaping (UIAlertAction)-> Void, facebook: @escaping (UIAlertAction)-> Void) -> UIAlertController{
        return self.actionSheet(title: title,
                         message: message,
                         actions: [
                            UIAlertAction(title: "Camera", style: .default, handler: camera),
                            UIAlertAction(title: "Gallery", style: .default, handler: gallery),
                            UIAlertAction(title: "Facebook", style: .default, handler: facebook),
                            UIAlertAction(title: "Cancel", style: .destructive, handler: nil),
                        ])
        
    }
}

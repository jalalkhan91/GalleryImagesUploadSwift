//
//  GalleryDetailViewController.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 29/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import UIKit
import SDWebImage

class GalleryDetailViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var galleryObj:GalleryResource?
    @IBOutlet weak var imageViewDescription: UITextView!
    var apiManager = APIManager.shared

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imageURL = URL.init(string: (galleryObj?.url)!)
        self.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Image-Placeholder"))
        self.imageViewDescription.text = UserDefaultsHelper.getDescription(key: imageURL?.absoluteString ?? Constants.notAvailable)
    }
    
    // MARK: Actions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        
        self.showHud()

        self.apiManager.deleteImage((self.galleryObj?.publicId)!) {(isSuccessful, errorMessage, response) in
            
            self.hideHud()

            if isSuccessful{
                self.showAlert(title: "Alert!", message: errorMessage ?? "")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    DispatchQueue.main.async {
                        self.presentingViewController?.viewWillAppear(true)
                        self.dismiss(animated: true, completion: nil)
                    }
                }
            }else{
                self.showAlert(title: "Error!", message: errorMessage ?? "")
            }
        }
    }
}

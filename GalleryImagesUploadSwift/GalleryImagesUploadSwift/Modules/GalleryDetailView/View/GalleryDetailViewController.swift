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
    @IBOutlet weak var buttonSetProfilePicture: UIButton!
    var apiManager = APIManager.shared
    var parentVC: GalleryViewController?
    var defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.galleryObj != nil{
            loadPicture()
        }
    }
    
    func loadPicture(){
        let imageURL = URL.init(string: (galleryObj?.url)!)
        self.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Image-Placeholder"))
        self.imageViewDescription.text = UserDefaultsHelper.getDescription(key: imageURL?.absoluteString ?? Constants.notAvailable)
        self.showHideSetProfilePictureButton()
    }
    
    func showHideSetProfilePictureButton(){
//        let profilePicId = UserDefaults.standard.value(forKey: Constants.profilePicture) as? String ?? ""
        guard
            let profileId = UserDefaults.standard.value(forKey: Constants.profilePicture) as? String,
            profileId ==  galleryObj?.publicId else {
            self.buttonSetProfilePicture.isEnabled = true
            return
        }
        self.buttonSetProfilePicture.isEnabled = false
    }
    
    // MARK: Actions
    @IBAction func closeButtonPressed(_ sender: Any) {
        DispatchQueue.main.async {
            self.parentVC?.reloadCollectionView()
        }
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
    
    @IBAction func setProfilePicturePressed(_ sender: Any) {
        defaults.set((self.galleryObj?.publicId)!, forKey: Constants.profilePicture)
        self.buttonSetProfilePicture.isEnabled = false
    }
    
    
}

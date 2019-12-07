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
    var imageURL:URL?
    @IBOutlet weak var imageViewDescription: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.imageView.sd_setImage(with: imageURL, placeholderImage: UIImage(named: "Image-Placeholder"))

        self.imageViewDescription.text = UserDefaultsHelper.getDescription(key: imageURL?.absoluteString ?? Constants.notAvailable)
    }
    
    // MARK: Actions
    @IBAction func closeButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

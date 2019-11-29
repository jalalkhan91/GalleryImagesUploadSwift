//
//  GalleryDetailViewRouter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 29/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

class GalleryDetailViewRouter: GalleryDetailViewRouterProtocol{
    
    static func createGalleryDetailedView(selectedImageUrl: URL) -> GalleryDetailViewController{

        let view = mainstoryboard.instantiateViewController(withIdentifier: Constants.galleryDetailViewController) as! GalleryDetailViewController
        view.imageURL = selectedImageUrl
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:Constants.mainStoryBoard,bundle: Bundle.main)
    }
}

//
//  GalleryDetailInteractor.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 27/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import Foundation
import Alamofire

class GalleryDetailInteractor: GalleryDetailPresentorToInteractorProtocol{
    
    var presenter: GalleryDetailInteractorToPresenterProtocol?
    var apiManager = APIManager.shared

    func deleteImageAPI(publicId: String) {
        
        self.apiManager.deleteImage(publicId) { (isSuccessful, errorMessage, response) in
            if isSuccessful{
                self.presenter?.deleteImageSuccessful(msg: errorMessage ?? "")
            }else{
                self.presenter?.deleteImageFailed(msg: errorMessage ?? "")
            }
        }
    }
    
    
}

//
//  GalleryInteractor.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import Alamofire

class GalleryInteractor: GalleryPresentorToInteractorProtocol{

    // MARK: Properties
    var pulledToRefresh: Bool?
    var cursor: String?
    var presenter: GalleryInteractorToPresenterProtocol?
    var apiManager = APIManager.shared

    // MARK: Methods
     func convertImageToBase64(image: UIImage) -> String {
        let imageData = image.jpegData(compressionQuality: 0.5)!
        return imageData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 3))
    }
    
    func fetchImagesAPI(cursorNext:String){

        if self.pulledToRefresh == true{
            self.cursor = ""
        }else{
            self.cursor = cursorNext
        }
        
        self.apiManager.getGalleryImages(self.cursor ?? "") {(isSuccessful, errorMessage, arrUsers) in

            if isSuccessful{
                self.presenter?.galleryUpdated(imagesArray: arrUsers?.resources ?? [GalleryResource](), nextCursor: arrUsers?.nextCursor ?? "")
            }
            else{
                self.presenter?.imageFetchedFailed(error: errorMessage ?? "Something went wrong...")
            }
        }
    }
    
    func uploadImage(image: UIImage) {
        let base64Image = convertImageToBase64(image: image)

        self.apiManager.uploadImage(base64Image) {(isSuccessful, errorMessage, arrUsers) in

            if isSuccessful{
                self.presenter?.imageUploaded(imageData: arrUsers!)
            }
            else{
                self.presenter?.imageUploadFailed(error: errorMessage ?? "Something went wrong...")
            }
        }
    }
}

//
//  GalleryDetailPresenter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 27/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

class GalleryDetailPresenter: GalleryDetailViewToPresenterProtocol {
   
    var view: GalleryDetailPresenterToViewProtocol?
    var interactor: GalleryDetailPresentorToInteractorProtocol?
    
    func deleteImageAPI(publicId: String) {
        interactor?.deleteImageAPI(publicId: publicId)
    }
    
}

extension GalleryDetailPresenter: GalleryDetailInteractorToPresenterProtocol{
    func deleteImageSuccessful(msg: String) {
        view?.showDeleteImageSuccessAlert(msg: msg)
    }
    
    func deleteImageFailed(msg: String) {
        view?.showErrorAlert(msg: msg)
    }
    
}

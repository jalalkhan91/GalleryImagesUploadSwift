//
//  GalleryPresenter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation

class GalleryPresenter: GalleryViewToPresenterProtocol {

    var view: GalleryPresenterToViewProtocol?
    var interactor: GalleryPresentorToInteractorProtocol?
    var router: GalleryPresenterToRouterProtocol?

    func loadImages() {
        interactor?.fetchImagesAPI()
    }
}

extension GalleryPresenter: GalleryInteractorToPresenterProtocol {
    
    func imageFetchedFailed(){
        view?.showError()
    }
    
    func numberOfItems() -> Int {
        return 5
    }
}

//
//  GalleryPresenter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation

class GalleryPresenter: GalleryViewToPresenterProtocol {

    // MARK: Properties
    var view: GalleryPresenterToViewProtocol?
    var interactor: GalleryPresentorToInteractorProtocol?
    var router: GalleryPresenterToRouterProtocol?
    var galleryData:[GalleryResource]?
    var cursorNext:String?
    var pulledToRefreshh:Bool?
    
    // MARK: Methods
    func loadImages(pulledToRefresh: Bool) {
        self.pulledToRefreshh = pulledToRefresh
        interactor?.pulledToRefresh = pulledToRefresh
        interactor?.fetchImagesAPI(cursorNext: cursorNext ?? "")
    }
}


// MARK:- GalleryInteractorToPresenterProtocol
extension GalleryPresenter: GalleryInteractorToPresenterProtocol {
    
    func imageFetchedFailed(error:String){
        view?.showError(message: error)
    }
    
    func numberOfItems() -> Int {
        return self.galleryData?.count ?? 0
    }
    
    func itemAt(index: Int) -> GalleryResource {
        return self.galleryData![index]
    }
    
    func galleryUpdated(imagesArray:[GalleryResource], nextCursor:String){

        self.cursorNext = nextCursor
        
        if imagesArray.count == 0{
             view?.showError(message: "No data found!")
             return
        }
        
        // Pull To Refresh and Infinite Scrolling logics
        if self.galleryData != nil{
            if pulledToRefreshh == true{
                self.galleryData! = imagesArray
                view?.stopPullToRefresh()
            }else{
                self.galleryData! += imagesArray
                view?.stopPagination()
            }
        }else{
            self.galleryData = imagesArray
        }
        
        if nextCursor == ""{
            view?.noMoreData()
        }
        
        view?.hideLoader()
        view?.reloadCollectionView()
    }
}

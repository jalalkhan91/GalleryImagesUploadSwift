//
//  GalleryPresenter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

class GalleryPresenter: GalleryViewToPresenterProtocol {

    // MARK: Properties
    var view: GalleryPresenterToViewProtocol?
    var interactor: GalleryPresentorToInteractorProtocol?
    var router: GalleryPresenterToRouterProtocol?
    var galleryData:[GalleryResource]?
    var cursorNext:String?
    var pulledToRefreshh:Bool?
    var selectedImageDescription: String?
    
    // MARK: Methods
    func loadImages(pulledToRefresh: Bool) {
        self.pulledToRefreshh = pulledToRefresh
        interactor?.pulledToRefresh = pulledToRefresh
        interactor?.fetchImagesAPI(cursorNext: cursorNext ?? "")
    }
    
    func userDidSelectImageToUpload(image: UIImage) {
        view?.showLoader()
        interactor?.uploadImage(image: image)
    }
    
    func usedDidSelectItem(index: Int) {
        router?.view = view as! UIViewController
//        router?.openImageDetailedView(url: URL.init(string: galleryData![index].url!)!)
        router?.openImageDetailedView(galleryObj:galleryData![index])

    }
}


// MARK:- GalleryInteractorToPresenterProtocol
extension GalleryPresenter: GalleryInteractorToPresenterProtocol {
    
    func imageUploadFailed(error: String) {
        view?.hideLoader()
        view?.showError(message: error)
    }
    
    func imageFetchedFailed(error:String){
        view?.hideLoader()
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
    
    
    func imageUploaded(imageData: GalleryResource) {
        
        UserDefaultsHelper.saveDescription(key: imageData.url!, value: self.selectedImageDescription ?? Constants.notAvailable)
        self.selectedImageDescription = ""

        self.galleryData?.insert(imageData, at: 0)
        view?.hideLoader()
        view?.reloadCollectionView()
    }

}

//
//  GalleryViewProtocols.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

//MARK: Gallery Presenter -> View Protocol
protocol GalleryPresenterToViewProtocol: class {
    func reloadCollectionView()
    func showError(message: String)
    
    func showLoader()
    func hideLoader()

    func stopPagination()
    func noMoreData()
    func resetNoMoreData()
    func stopPullToRefresh()
}

//MARK: Gallery Interactor -> Presenter Protocol
protocol GalleryInteractorToPresenterProtocol: class {
    func imageFetchedFailed(error:String)
    func galleryUpdated(imagesArray:[GalleryResource], nextCursor:String)
    func imageUploaded(imageData:GalleryResource)
    func imageUploadFailed(error:String)
}

//MARK: Gallery Presenter -> Interactor Protocol
protocol GalleryPresentorToInteractorProtocol: class {
    var presenter: GalleryInteractorToPresenterProtocol? {get set}
    var cursor:String? {get set}
    var pulledToRefresh:Bool? {get set}
    func fetchImagesAPI(cursorNext:String)
    func uploadImage(image: UIImage)
}

//MARK: Gallery View -> Presenter Protocol
protocol GalleryViewToPresenterProtocol: class {
    var view: GalleryPresenterToViewProtocol? {get set}
    var interactor: GalleryPresentorToInteractorProtocol? {get set}
    var router: GalleryPresenterToRouterProtocol? {get set}
    
    func loadImages(pulledToRefresh:Bool)
    func numberOfItems() -> Int
    func itemAt(index: Int) -> GalleryResource
    func userDidSelectImageToUpload(image: UIImage)

}

//MARK: Gallery Router Protocol
protocol GalleryPresenterToRouterProtocol: class {
    static func createGalleryView() -> UIViewController
}

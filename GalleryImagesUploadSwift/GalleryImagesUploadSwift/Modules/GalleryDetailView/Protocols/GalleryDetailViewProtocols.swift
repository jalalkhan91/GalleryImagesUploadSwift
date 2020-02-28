//
//  GalleryDetailViewProtocols.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 29/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation

//MARK: Gallery Detail View Router Protocol

protocol GalleryDetailViewToPresenterProtocol: class {
    var view: GalleryDetailPresenterToViewProtocol? {get set}
    var interactor: GalleryDetailPresentorToInteractorProtocol? {get set}
//    var router: GalleryDetailPresenterToRouterProtocol? {get set}
    
    func deleteImageAPI(publicId: String)
}

protocol GalleryDetailPresentorToInteractorProtocol: class {
    var presenter: GalleryDetailInteractorToPresenterProtocol? {get set}
    func deleteImageAPI(publicId:String)
}

protocol GalleryDetailInteractorToPresenterProtocol: class {
    func deleteImageSuccessful(msg:String)
    func deleteImageFailed(msg:String)
}

protocol GalleryDetailPresenterToViewProtocol: class {
    func showDeleteImageSuccessAlert(msg:String)
    func showErrorAlert(msg:String)
}

protocol GalleryDetailViewRouterProtocol: class {
//    static func createGalleryDetailedView(selectedImageObj: GalleryResource) -> GalleryDetailViewController

}

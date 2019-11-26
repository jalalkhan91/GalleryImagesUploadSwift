//
//  GalleryViewProtocols.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryPresenterToViewProtocol: class {
    func reloadCollectionView()
    func showError()
}

protocol GalleryInteractorToPresenterProtocol: class {
    func imageFetchedFailed()
}

protocol GalleryPresentorToInteractorProtocol: class {
    var presenter: GalleryInteractorToPresenterProtocol? {get set}
    
    func fetchImagesAPI()
}

protocol GalleryViewToPresenterProtocol: class {
    var view: GalleryPresenterToViewProtocol? {get set}
    var interactor: GalleryPresentorToInteractorProtocol? {get set}
    var router: GalleryPresenterToRouterProtocol? {get set}
    
    func loadImages()
    func numberOfItems() -> Int
}

protocol GalleryPresenterToRouterProtocol: class {
    static func createGalleryView() -> UIViewController
}


//
//  GalleryViewRouter.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

class GalleryRouter: GalleryPresenterToRouterProtocol{
    
    var presenter: GalleryInteractorToPresenterProtocol?

    class func createGalleryView() -> UIViewController{
        
        // Initializing Gallery module components
        let view = mainstoryboard.instantiateViewController(withIdentifier: Constants.galleryViewController) as! GalleryViewController

        let presenter: GalleryViewToPresenterProtocol & GalleryInteractorToPresenterProtocol = GalleryPresenter()
        let interactor: GalleryPresentorToInteractorProtocol = GalleryInteractor()
        let router: GalleryPresenterToRouterProtocol = GalleryRouter()

        // Connecting components
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:Constants.mainStoryBoard,bundle: Bundle.main)
    }
}

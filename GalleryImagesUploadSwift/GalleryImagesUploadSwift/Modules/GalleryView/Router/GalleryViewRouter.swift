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
        
        let view = mainstoryboard.instantiateViewController(withIdentifier: "GalleryViewController") as! GalleryViewController

        let presenter: GalleryViewToPresenterProtocol & GalleryInteractorToPresenterProtocol = GalleryPresenter()
        let interactor: GalleryPresentorToInteractorProtocol = GalleryInteractor()
        let router: GalleryPresenterToRouterProtocol = GalleryRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
            
        return view
    }
    
    static var mainstoryboard: UIStoryboard{
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
}

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
    weak var view: UIViewController?

    class func createGalleryView() -> GalleryViewController{
        
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
    
    func openImageDetailedView(url: URL) {
        
        let galleryDetailedView = GalleryDetailViewRouter.createGalleryDetailedView(selectedImageUrl: url)
        
        DispatchQueue.main.async {
            self.view?.present(galleryDetailedView, animated: true, completion: nil)
        }
    }
}

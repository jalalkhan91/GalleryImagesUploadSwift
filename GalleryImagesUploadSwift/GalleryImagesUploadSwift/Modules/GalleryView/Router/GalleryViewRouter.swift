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
    var detailPresenter: GalleryDetailInteractorToPresenterProtocol?
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
    
    func openImageDetailedView(galleryObj: GalleryResource) {

//        let galleryDetailedView = GalleryDetailViewRouter.createGalleryDetailedView(selectedImageUrl: url)
        let galleryDetailedView = GalleryDetailViewRouter.createGalleryDetailedView(selectedImageObj: galleryObj)
        galleryDetailedView.parentVC = self.view as? GalleryViewController

        let presenter: GalleryDetailViewToPresenterProtocol & GalleryDetailInteractorToPresenterProtocol = GalleryDetailPresenter()
        let interactor: GalleryDetailPresentorToInteractorProtocol = GalleryDetailInteractor()

        galleryDetailedView.presenter = presenter
        presenter.view = galleryDetailedView
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        DispatchQueue.main.async {
            self.view?.present(galleryDetailedView, animated: true, completion: nil)
        }
    }
}

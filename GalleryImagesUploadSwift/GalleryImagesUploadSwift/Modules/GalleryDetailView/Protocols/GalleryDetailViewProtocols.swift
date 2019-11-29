//
//  GalleryDetailViewProtocols.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 29/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation

//MARK: Gallery Detail View Router Protocol
protocol GalleryDetailViewRouterProtocol: class {
    static func createGalleryDetailedView(selectedImageUrl: URL) -> GalleryDetailViewController
}

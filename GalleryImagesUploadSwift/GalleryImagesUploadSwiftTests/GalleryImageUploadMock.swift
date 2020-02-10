//
//  GalleryImageUploadMock.swift
//  GalleryImagesUploadSwiftTests
//
//  Created by Jalal Khan on 10/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import XCTest

@testable import GalleryImagesUploadSwift

class GalleryViewControllerMock: GalleryViewController {

    var numberOfTimesShowAlertDescriptionCalled = 0
    
    override func showAlertControllerWithDescription(){
        numberOfTimesShowAlertDescriptionCalled += 1
    }

}

//
//  ImageUploadActionSheetTests.swift
//  GalleryImagesUploadSwiftTests
//
//  Created by Jalal Khan on 10/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import XCTest
@testable import GalleryImagesUploadSwift


class ImageUploadActionSheetTests: XCTestCase {
    
    func testPrivacyMessageAdded(){
        let alert = UIAlertController.actionSheetImageUpload(title: "Title", message: "Privacy message", gallery: { _ in
            
        }) { _ in
            
        }
        XCTAssertEqual(alert.title, "Title")
        XCTAssertEqual(alert.message, "Privacy message")
        
    }
    
}

//
//  GalleryDetailViewControllerTests.swift
//  GalleryImagesUploadSwiftTests
//
//  Created by Jalal Khan on 10/02/2020.
//  Copyright © 2020 Jalal Khan. All rights reserved.
//

import XCTest
import UIKit
@testable import GalleryImagesUploadSwift

class GalleryDetailViewControllerTests: XCTestCase {

    var controller:GalleryDetailViewController!
    var mockDefaults = UserDefaults(suiteName: "testing")!
    static let publicId = "test1234"
    static let json = """
    {"url": "http://www.google.com", "public_id" : "\(publicId)"}
    """
    let resource = try! JSONDecoder().decode(GalleryResource.self, from: json.data(using: .utf8)!)
    
    override func setUp() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "GalleryDetailViewController") as? GalleryDetailViewController
        controller.galleryObj = resource
        controller.defaults = mockDefaults
        _ = controller.view
        XCTAssertNotNil(controller.view)
    }
    
    func testMakeProfileButton() {
        XCTAssertTrue(controller.buttonSetProfilePicture.isEnabled)
        //make it profile picture
        controller.setProfilePicturePressed(UIButton())
        
        //
        XCTAssertFalse(controller.buttonSetProfilePicture.isEnabled)
        
    }
    
    func testProfilePictureStoredInDefaults() {
        controller.setProfilePicturePressed(UIButton())
        XCTAssertNotNil(mockDefaults.string(forKey: Constants.profilePicture))
    }
    
    override func tearDown() {
        super.tearDown()
        mockDefaults.removePersistentDomain(forName: "testing")
        mockDefaults.synchronize()
    }
}

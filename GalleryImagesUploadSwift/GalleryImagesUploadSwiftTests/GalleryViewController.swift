//
//  GalleryViewController.swift
//  GalleryImagesUploadSwiftTests
//
//  Created by Jalal Khan on 28/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import XCTest
import Foundation
@testable import GalleryImagesUploadSwift

class GalleryViewControllerTests: XCTestCase {

    var galleryViewController:GalleryViewController!
    var apiManager = APIManager.shared

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        super.setUp()
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        galleryViewController = storyboard.instantiateViewController(withIdentifier: "GalleryViewController") as? GalleryViewController
        _ = galleryViewController.view
        
        let presenter: GalleryViewToPresenterProtocol & GalleryInteractorToPresenterProtocol = GalleryPresenter()
        let interactor: GalleryPresentorToInteractorProtocol = GalleryInteractor()
        let router: GalleryPresenterToRouterProtocol = GalleryRouter()

        // Connecting components
        galleryViewController.presenter = presenter
        presenter.view = galleryViewController
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    //MARK:- TableView Delegate/DataSource Tests

    func testTableViewIsNotNilAfterViewDidLoad() {
        XCTAssertNotNil(galleryViewController.tableView)
    }
    
    func testShouldSetTableViewDataSource() {
        XCTAssertNotNil(galleryViewController.tableView.dataSource)
    }
    
    func testShouldSetTableViewDelegate() {
        XCTAssertNotNil(galleryViewController.tableView.delegate)
    }

    func testConformsToTableViewDataSourceProtocol() {
         
         XCTAssert(galleryViewController.conforms(to: UITableViewDataSource.self))
         XCTAssert(galleryViewController.responds(to: #selector(galleryViewController.tableView(_:numberOfRowsInSection:))))
         XCTAssert(galleryViewController.responds(to: #selector(galleryViewController.tableView(_:cellForRowAt:))))
     }
     
     func testTableViewUsesCustomCell_TableViewCustomCell() {
         
        if galleryViewController.presenter?.numberOfItems() ?? 0 > 0{
            let cell = galleryViewController.tableView(galleryViewController.tableView, cellForRowAt: IndexPath.init(row: 0, section: 0))
            XCTAssert(cell is GalleryTableViewCell)
         }

     }
    
    //MARK:- Get Gallery Images API Test
    func testGetGalleryImagesAPI(){
        
        let expectation = XCTestExpectation.init(description: "Image fetch successful")

        self.apiManager.getGalleryImages("") {(isSuccessful, errorMessage, responseArray) in

            if isSuccessful{
                expectation.fulfill()
            }else{
                XCTAssert(false)
            }
        }
        wait(for: [expectation], timeout: 10)
    }
    
    //MARK:- Upload Image API Test
    func testUplopadImage(){
        
        let expectation = XCTestExpectation.init(description: "Image upload successful")

        let imageData = UIImage.init(named: "XCTestImage")!.jpegData(compressionQuality: 0.5)!
        let base64Image = imageData.base64EncodedString(options: Data.Base64EncodingOptions.init(rawValue: 3))
        
        self.apiManager.uploadImage(base64Image) {(isSuccessful, errorMessage, response) in
            if isSuccessful{
                UserDefaultsHelper.saveDescription(key: String((response?.url)!), value: "XCTest Image")
                expectation.fulfill()
            }
            else{
                XCTAssert(false)
            }
        }
        wait(for: [expectation], timeout: 10)

    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

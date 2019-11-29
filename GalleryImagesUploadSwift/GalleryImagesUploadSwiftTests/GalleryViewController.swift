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
    
    func testGetGalleryImagesAPI(){
        galleryViewController.presenter?.loadImages(pulledToRefresh: true)
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

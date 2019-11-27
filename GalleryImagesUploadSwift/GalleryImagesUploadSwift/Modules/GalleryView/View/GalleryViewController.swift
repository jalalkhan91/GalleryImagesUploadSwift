//
//  GalleryViewController.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import UIKit
import SDWebImage
import ESPullToRefresh

class GalleryViewController: UIViewController {

    // MARK: Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var buttonAddImage: UIBarButtonItem!
    
    var presenter: GalleryViewToPresenterProtocol?{
        didSet{
            print("Presenter value changed")
            print(self.presenter as Any)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView.init(frame: .zero)
        
        self.customizeUI()
        presenter?.loadImages(pulledToRefresh: true)
    }
    
    func customizeUI(){
        self.tableView.es.addPullToRefresh {
            [unowned self] in

            self.tableView.es.resetNoMoreData()

            self.presenter?.loadImages(pulledToRefresh: true)
        }
        self.tableView.es.addInfiniteScrolling {
            [unowned self] in

            self.presenter?.loadImages(pulledToRefresh: false)
        }
    }
    
    
    // MARK: Actions
    @IBAction func addButtonPressed(_ sender: Any) {
        
    }
    
}


// MARK:- GalleryPresenterToViewProtocol Methods
extension GalleryViewController:GalleryPresenterToViewProtocol{
    
    func reloadCollectionView() {
        self.tableView.reloadData()
    }
        
    func showError(message: String) {
        self.showAlert(title: "Alert!", message: message)
    }
    
    func showLoader(){
        self.showHud()
    }
    
    func hideLoader(){
        self.hideHud()
    }

    func stopPagination(){
        self.tableView.es.stopLoadingMore()
    }
    
    func noMoreData(){
        self.tableView.es.noticeNoMoreData()
    }
    
    func resetNoMoreData(){
        self.tableView.es.resetNoMoreData()
    }
    
    func stopPullToRefresh(){
        self.tableView.es.stopPullToRefresh(ignoreDate: true, ignoreFooter: false)
    }
}

//MARK:- UITableView Delegates
extension GalleryViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.galleryCellName, for: indexPath) as! GalleryTableViewCell
        
        let item = presenter?.itemAt(index: indexPath.row)
        cell.cellImageView.sd_setImage(with: URL.init(string: (item?.url)!))
        
        return cell
    }
}

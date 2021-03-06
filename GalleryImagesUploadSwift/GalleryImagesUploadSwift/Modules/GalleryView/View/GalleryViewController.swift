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
    var selectedImage:UIImage?
    var presenter: GalleryViewToPresenterProtocol?{
        didSet{
            print("Presenter value changed")
            print(self.presenter as Any)
        }
    }
    lazy var imagePicker : UIImagePickerController = {
        let picker = UIImagePickerController()
        picker.delegate = self
        return picker
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView.init(frame: .zero)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
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
        openImageOptionsPicker(sourceView: sender as! UIBarButtonItem)
    }
    
    func showAlertControllerWithDescription(){
        let alertController = UIAlertController(title: "Add description", message: "", preferredStyle: UIAlertController.Style.alert)
        alertController.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = "Description..."
        }
        let saveAction = UIAlertAction(title: "Save", style: UIAlertAction.Style.default, handler: { alert -> Void in
            let firstTextField = alertController.textFields![0] as UITextField
            
            self.presenter?.selectedImageDescription = firstTextField.text ?? ""
            self.presenter?.userDidSelectImageToUpload(image: self.selectedImage!)

        })
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: {
            (action : UIAlertAction!) -> Void in })

        alertController.addAction(saveAction)
        alertController.addAction(cancelAction)

        self.present(alertController, animated: true, completion: nil)
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
        
        cell.cellImageView.sd_setImage(with: URL.init(string: (item?.url)!), placeholderImage: UIImage(named: "Image-Placeholder"))
        
        self.highlightProfilePicture(cell: cell, item: item!)

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.usedDidSelectItem(index: indexPath.row)
    }

}

extension GalleryViewController{
    
    func highlightProfilePicture(cell: GalleryTableViewCell, item: GalleryResource){
        
        let profilePicId = UserDefaults.standard.value(forKey: "profilePicture") as? String ?? ""
        
        if profilePicId != ""{
            if profilePicId == item.publicId{
                cell.layer.borderWidth = 10.0
                cell.layer.borderColor = UIColor.green.cgColor
                cell.layer.cornerRadius = 5.0
                cell.layoutIfNeeded()
                cell.clipsToBounds = true
            }else{
                cell.layer.borderWidth = 0.0
                cell.layer.borderColor = UIColor.clear.cgColor
                cell.layer.cornerRadius = 0.0
                cell.layoutIfNeeded()
                cell.clipsToBounds = true
            }
        }
    }
}

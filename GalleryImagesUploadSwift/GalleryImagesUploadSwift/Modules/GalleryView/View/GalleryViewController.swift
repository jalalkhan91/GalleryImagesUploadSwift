//
//  GalleryViewController.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import UIKit

class GalleryViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var presenter: GalleryViewToPresenterProtocol?{
        didSet{
            print("Presenter value changed")
            print(self.presenter as Any)
        }
    }
    
    var iPhoneCellWidth: CGFloat {
        return (self.view.frame.width / Constants.numberOfCellsPerRow) - (Constants.numberOfCellsPerRow * Constants.cellSpacing)
    }
    var iPhoneCellHeight: CGFloat {
        return iPhoneCellWidth * Constants.iPhoneHeightToWidthRatio
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.delegate = self
        self.collectionView.dataSource = self

        presenter?.loadImages()
    }

}

extension GalleryViewController:GalleryPresenterToViewProtocol{
    
    func reloadCollectionView() {
        self.collectionView.reloadData()
    }
    
    
    
    func showError() {
        self.showAlert(title: "Alert!", message: "Some error occured. Please try again.")
    }
}


extension GalleryViewController : UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.numberOfItems() ?? 0
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.imageCellName, for: indexPath) as! GalleryCollectionViewCell
        cell.backgroundColor = UIColor.yellow
//           cell.configure(image: presenter!.itemAt(index: indexPath.item))
        return cell
    }
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if UIDevice.current.userInterfaceIdiom == .pad {
           return CGSize(width: Constants.iPadCellSize, height: Constants.iPadCellSize)
        }
        return CGSize(width: iPhoneCellWidth, height: iPhoneCellHeight)
    }
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//           presenter?.usedDidSelectItem(index: indexPath.item)
    }
}

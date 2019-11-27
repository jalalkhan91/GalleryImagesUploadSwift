//
//  GalleryTableViewCell.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 27/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import UIKit

class GalleryTableViewCell: UITableViewCell {

    @IBOutlet weak var cellImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

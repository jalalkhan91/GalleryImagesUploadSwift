//
//  Constants.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    static let galleryCellName = "GalleryTableViewCell"
    static let galleryViewController = "GalleryViewController"

    static let mainStoryBoard = "Main"
}

struct URLs {
//    static let k_BASE_URL = "https://api.cloudinary.com/v1_1/ddivp0mah/resources/image?next_cursor="
    static let k_BASE_URL = "https://api.cloudinary.com/v1_1/ddivp0mah/"

}

public enum Endpoints: String {
    case getImages = "resources/image?next_cursor="
    case uploadImage = "image/upload"
}


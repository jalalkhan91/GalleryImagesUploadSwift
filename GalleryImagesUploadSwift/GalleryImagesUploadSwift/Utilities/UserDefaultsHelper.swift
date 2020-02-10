//
//  UIViewController+UserDefaults.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 07/12/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import UIKit

public class UserDefaultsHelper {

    class func saveDescription(key:String, value:String){
        
        if UserDefaults.standard.value(forKey: Constants.descriptionDictionary) != nil{
            var descriptionDict = UserDefaults.standard.value(forKey: Constants.descriptionDictionary) as? [String:String] ?? [String:String]()
            descriptionDict[key] = String(value)
            UserDefaults.standard.set(descriptionDict, forKey: Constants.descriptionDictionary)
        }else{
            var descriptionDict = [String:String]()
            descriptionDict[key] = String(value)
            UserDefaults.standard.set(descriptionDict, forKey: Constants.descriptionDictionary)
        }
        UserDefaults.standard.synchronize()
    }
    
    class func getDescription(key:String) -> String{

        guard UserDefaults.standard.value(forKey: Constants.descriptionDictionary) != nil else{
            return Constants.notAvailable
        }
        
        let descriptionDict = UserDefaults.standard.value(forKey: Constants.descriptionDictionary) as? [String:String] ?? [String:String]()
        
        if let descriptionStr = descriptionDict[key]{
            return descriptionStr
        }else{
            return Constants.notAvailable
        }
    }
}

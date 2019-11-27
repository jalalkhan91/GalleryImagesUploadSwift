//
//  HttpHandler.swift
//  CiklumCodeChallenge
//
//  Created by Jalal Khan on 23/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import Alamofire


struct requestParameters {
    let url:String
    let method: HTTPMethod
    let parameters:[String: Any]?
    let headers : [String : String]?
}

final class HttpHandler: NSObject {
    
    // Can't init is singleton
    private override init() { }
    
    // MARK: Shared Instance
    static let shared = HttpHandler()
    
    func AlamoFireRequest(rp: requestParameters,completed:@escaping (_ resJson : Any?, _ error : Error?) -> Void) {
        
        switch rp.headers {
            
        case .none:
    
            Alamofire.request(rp.url, method:rp.method, parameters: rp.parameters).validate().responseJSON { response in
                switch response.result {
                case .success:

                    completed(response.data as AnyObject?, nil)
                case .failure(let error):
                    print ("#########################failure : \(rp.url)###############################")
                    print("HttpHandler : .none error message : \(String(describing: response.result.value))")
                    
                    print("HttpHandler : .none error message : \(String(describing: response.result.value))")
                    print("HttpHandler : .none error : \(error.localizedDescription)")
                    completed(nil, error)
                }
            }
            
            break
            
        case .some( _):
            
            Alamofire.request(rp.url, method:rp.method, parameters: rp.parameters, headers: rp.headers).validate().responseJSON { response in
                switch response.result {
                case .success:

                    completed(response.data, nil)
                    
                    
                case .failure(let error):
                    print ("#########################failure : \(rp.url)###############################")
                    print("HttpHandler : .some error : \(error.localizedDescription)")
                    completed(nil, error)
                }
            }
            
            break
            
        }
    }
    
    func AlamoFireUploadImage(img: UIImage?, rp: requestParameters, completed:@escaping (_ resJson : AnyObject?, _ error : Error?) -> Void) {

        let url = try! URLRequest(url: URL(string:rp.url)!, method: rp.method, headers: rp.headers)
        
        print ("url : \(url)")
        print ("parameters : \(String(describing: rp.parameters))")
        print ("method : \(rp.method)")
        print ("headers : \(String(describing: rp.headers))")
        
        
        Alamofire.upload(
            multipartFormData: { multipartFormData in
                
                if img != nil
                {
                    let imageData = img!.jpegData(compressionQuality: 0.5)!
                    multipartFormData.append(imageData, withName: "profile_image", fileName: "\(Date().timeIntervalSince1970).jpeg", mimeType: "image/jpg")
                }
                
                for (key, value) in rp.parameters!
                {
                    multipartFormData.append((value as AnyObject).data(using: String.Encoding.utf8.rawValue)!, withName: key )
                }
        },
            with: url,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    upload.uploadProgress(closure: { (progress) in
                        //Print progress
                        print("Upload  - progress : .some Successful : \(progress)")
                        
                    })
                    
                    upload.responseJSON { response in
                        //print response.result
                        print("Upload  - HttpHandler : .some Successful : \(String(describing: response.result.value))")
                        completed(response.data as AnyObject?, nil)
                    }
                    
                case .failure(let error):
                    print("Upload - HttpHandler : .some error : \(error.localizedDescription)")
                    completed(nil, error)
                }
        })
        
    }
    
}

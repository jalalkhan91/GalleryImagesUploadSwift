//
//  APIManager.swift
//  CiklumCodeChallenge
//
//  Created by Jalal Khan on 23/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import Alamofire

final class APIManager
{
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    static let shared = APIManager()
    var httpHandler: HttpHandler =  HttpHandler.shared
    
    
    //MARK: -  API's
    
    // Get Movies Data API
        func getGalleryImages(_ next:String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : Gallery?) -> Void) {

        let url = URLs.k_BASE_URL+Endpoints.getImages.rawValue+"\(next)"
        let headers = getApiHeaders()
        
        let reqParams: requestParameters = requestParameters(url: url, method: .get, parameters: nil, headers: headers)
        print(url)
        httpHandler.AlamoFireRequest(rp: reqParams) { (resJson, error) in
            
            if resJson != nil {
                do {
                    let response = try JSONDecoder().decode(Gallery.self, from: resJson as! Data)
                    completion(true,nil,response)
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }
            else{
                completion(false, error?.localizedDescription, nil)
            }
        }
    }
    
    // Upload Image API
    func uploadImage(_ base64Image:String, completion : @escaping (_ isSuccessful: Bool, _ errorMessage : String?, _ arrResults : GalleryResource?) -> Void) {

        let url = URLs.k_BASE_URL+Endpoints.uploadImage.rawValue
        let headers = getApiHeaders()
        
        let params: [String: Any] = ["file": "data:image/jpg;base64,"+base64Image,"upload_preset":"jalalKhan"]

        Alamofire.request(url, method: .post, parameters: params, encoding: JSONEncoding.default, headers: headers).responseJSON { response in

            if response != nil{
                do {

                    if let theJSONData = try? JSONSerialization.data(withJSONObject: response.result.value as! [String:Any],options: []) {

                        let responseMapped = try JSONDecoder().decode(GalleryResource.self, from: theJSONData)
                        completion(true,nil,responseMapped)
                    }
                } catch {
                    print(error)
                    completion(false,error.localizedDescription, nil)
                }
            }else{
                completion(false,response.result.error! as? String,nil)
            }
        }
    }
    
    
    // MARK: Get API Headers
    func getApiHeaders() ->  [String:String]{
        
        let user = "554652571641736"
        let password = "j_aMCHr0oNR6riLliLXUGsqEOIU"

        let credentialData = "\(user):\(password)".data(using: String.Encoding(rawValue: String.Encoding.utf8.rawValue))!
        let base64Credentials = credentialData.base64EncodedString()
        
        let headers = [
                    "Authorization": "Basic \(base64Credentials)",
                    "Accept": "application/json",
                    "Content-Type": "application/json" ]
        return headers
    }
    
}


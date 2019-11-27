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
        
        let url = URLs.k_BASE_URL+"\(next)"
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


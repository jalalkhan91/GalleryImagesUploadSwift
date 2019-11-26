//
//  GalleryInteractor.swift
//  GalleryImagesUploadSwift
//
//  Created by Jalal Khan on 26/11/2019.
//  Copyright © 2019 Jalal Khan. All rights reserved.
//

import Foundation
import Alamofire

class GalleryInteractor: GalleryPresentorToInteractorProtocol{

    var presenter: GalleryInteractorToPresenterProtocol?
    
    func fetchImagesAPI(){
        
    }
    
//    func fetchImages(pageNumber:Int, searchString:String) {
                
//        let urlStr = URLs.k_BASE_URL+searchString+"&page="+"\(pageNumber)"

//        Alamofire.request(urlStr).response { response in
//            if(response.response?.statusCode == 200){
//                guard let data = response.data else { return }
//                do {
//                    let decoder = JSONDecoder()
//                    let newsResponse = try decoder.decode(MoviesData.self, from: data)
//
//                    self.presenter?.moviesFetched(movies: newsResponse.results!)
//                } catch let error {
//                    print(error)
//                }
//            }
//            else {
//                self.presenter?.moviesFetchedFailed()
//            }
//        }
//    }
}

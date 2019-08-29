//
//  ServiceResponseAPI.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import Alamofire
import RealmSwift

class ServiceResponseAPI {
    
    static let shared = ServiceResponseAPI()
    
    func getImages(page: Int, completion: @escaping ServiceResponseCompletion) {

        func fireErrorCompletion(_ error: Error?) {
            completion(nil)
        }
        
        let parameters: Parameters = [
            "key": API_KEY,
            "page": page
        ]
        
        Alamofire.request(URL_BASE, method: .get, parameters: parameters).responseJSON { (response) in
            
            if let error = response.error {
                fireErrorCompletion(error)
                return
            }
            
            guard let data = response.data else { return completion(nil) }
            let jsonDecoder = JSONDecoder()
            do {
                let serviceResponse = try jsonDecoder.decode(ServiceResponse.self, from: data)
                PageCounter.currentPage = page
                completion(serviceResponse.hits)
            } catch {
                fireErrorCompletion(error)
                debugPrint(error.localizedDescription)
                return
            }
        }
    }
}


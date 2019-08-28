//
//  ServiceResponseAPI.swift
//  seeImages
//
//  Created by Michael Sidoruk on 28/08/2019.
//  Copyright © 2019 Michael Sidoruk. All rights reserved.
//

import Foundation
import Alamofire

class ServiceResponseAPI {
    func getImages(page: Int, completion: @escaping ServiceResponseCompletion) {
        
        func fireErrorCompletion(_ error: Error?) {
            completion(RecordingsResult(recordings: nil,
                                        error: error,
                                        currentPage: 0))
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
            
            print(response)
            
            guard let data = response.data else { return completion(nil) }
            let jsonDecoder = JSONDecoder()
            do {
                let serviceResponse = try jsonDecoder.decode(ServiceResponse.self, from: data)
                completion(RecordingsResult(recordings: serviceResponse.hits,
                                            error: nil,
                                            currentPage: page))
            } catch {
                debugPrint(error.localizedDescription)
                fireErrorCompletion(error)
            }
        }
    }
}


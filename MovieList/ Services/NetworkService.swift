//
//  NetworkService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation
import Alamofire

class NetworkService {
    private init(){}
    
    class func request(type: RequestType, parameters: Parameters?, completion: ((_ success: Bool, _ data: Any?)->())?) {
        Alamofire.request(type.getURL(), method: type.getHTTPMethod(), parameters: parameters, encoding: type.getEncoding(), headers: type.getHeaders()).responseJSON { (response) in
            guard let statusCode = response.response?.statusCode else {
                completion?(false, nil)
                return
            }
            
            if statusCode == 200 {
                completion?(true, response.value)
            } else {
                completion?(false, nil)
            }
        }
    }
}

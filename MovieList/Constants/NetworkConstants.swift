//
//  NetworkConstants.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation
import Alamofire

private struct NetworkConstants {
    static let baseURL = "https://desafio-mobile.nyc3.digitaloceanspaces.com/"
}

enum RequestType {
    case movieList
//    case movie
    
    func getURL() -> String {
        switch self {
        case .movieList:
            return "\(NetworkConstants.baseURL)movies"
        }
    }
    
    func getHTTPMethod() -> HTTPMethod {
        switch self {
        case .movieList:
            return .get
        }
    }
    
    func getEncoding() -> ParameterEncoding {
        switch self {
        case .movieList:
            return JSONEncoding.default
        }
    }
    
    func getHeaders() -> HTTPHeaders? {
        switch self {
        case .movieList:
            return nil
        }
    }
}

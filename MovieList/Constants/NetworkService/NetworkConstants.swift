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
    static let movieListURL = "movies"
}

enum RequestType {
    case movieList
    case movieDetail(id: Int)
    
    func getURL() -> String {
        switch self {
        case .movieList:
            return "\(NetworkConstants.baseURL)\(NetworkConstants.movieListURL)"
        case .movieDetail(let id):
            return "\(NetworkConstants.baseURL)\(NetworkConstants.movieListURL)/\(id)"
        }
    }
    
    func getHTTPMethod() -> HTTPMethod {
        switch self {
        case .movieList, .movieDetail:
            return .get
        }
    }
    
    func getEncoding() -> ParameterEncoding {
        switch self {
        case .movieList, .movieDetail:
            return JSONEncoding.default
        }
    }
    
    func getHeaders() -> HTTPHeaders? {
        switch self {
        case .movieList, .movieDetail:
            return nil
        }
    }
}

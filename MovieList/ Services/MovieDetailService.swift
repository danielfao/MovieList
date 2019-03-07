//
//  MovieDetailService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 05/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

class MovieDetailService {
    class func getMovieDetail(movie: Movie, completion: @escaping()->()) {
        NetworkService.request(type: .movieDetail(id: movie.id)) { (success, data) in
            guard let movieDetailDict = data as? [String : Any] else {
                completion()
                return
            }
            
            movie.update(dict: movieDetailDict)
            completion()
        }
    }
}

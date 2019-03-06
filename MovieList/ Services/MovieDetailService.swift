//
//  MovieDetailService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 05/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

class MovieDetailService {
    class func getMovieList(id: Int, completion: @escaping([MovieList])->()) {
        NetworkService.request(type: .movieDetail(id: id), parameters: nil) { (success, data) in
            guard let movieDetailDicts = data as? [[String : Any]] else {
                completion([])
                return
            }
            
            var movies : [MovieList] = []
            for movieDetail in movieDetailDicts {
                if let movie = MovieList.init(movieListDict: movieDetail) {
                    movies.append(movie)
                }
            }
            completion(movies)
        }
    }
}

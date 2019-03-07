//
//  MovieListService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

class MovieListService {
    class func getMovieList(completion: @escaping([Movie])->()) {
        NetworkService.request(type: .movieList) { (success, data) in
            guard let movieListDicts = data as? [[String : Any]] else {
                completion([])
                return
            }
            
            var movies : [Movie] = []
            for movieList in movieListDicts {
                if let movie = Movie.init(movieListDict: movieList) {
                    movies.append(movie)
                }
            }
            completion(movies)
        }
    }
}

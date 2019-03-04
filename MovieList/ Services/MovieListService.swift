//
//  MovieListService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

class MovieListService {
    class func getMovieList(completion: @escaping([MovieList])->()) {
        NetworkService.request(type: .movieList, parameters: nil) { (success, data) in
            guard let movieListDicts = data as? [[String : Any]] else {
                completion([])
                return
            }
            
            var movies : [MovieList] = []
            for movie in movieListDicts {
                if let movie = MovieList.init(movieListDict: movie) {
                    movies.append(movie)
                }
            }
            completion(movies)
        }
    }
}

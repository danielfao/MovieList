//
//  MovieList.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

class MovieList {
    let id: Int
    let averageRate: Double
    let title: String
    let posterURL: String
    let genres: [String]
    let releaseDate: String
    
    init?(movieListDict: [String : Any]) {
        guard let id = movieListDict["id"] as? Int,
            let averageRate = movieListDict["vote_average"] as? Double,
            let title = movieListDict["title"] as? String,
            let posterURL = movieListDict["poster_url"] as? String,
            let genres = movieListDict["genres"] as? [String],
            let releaseDate = movieListDict["release_date"] as? String else {
                return nil
        }
        
        self.id = id
        self.averageRate = averageRate
        self.title = title
        self.posterURL = posterURL
        self.genres = genres
        self.releaseDate = releaseDate
    }
}

//
//  MovieList.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class MovieList {
    // MARK: - Variables
    let id: Int
    let averageRate: Double
    let title: String
    let posterURL: String
    private (set) var image: UIImage?
    let genres: [String]
    let releaseDate: String
    private var imageDownloadTask: URLSessionTask?
    
    // MARK: - Initialization
    init?(movieListDict: [String : Any]) {
        guard let id = movieListDict["id"] as? Int,
            let averageRate = movieListDict["vote_average"] as? Double,
            let title = movieListDict["title"] as? String,
            let posterURL = movieListDict["poster_url"] as? String,
            let genres = movieListDict["genres"] as? [String],
            let releaseDate = movieListDict["release_date"] as? String else {
                return nil
        }
        
        var genresArray: [String] = []
        for value in genres {
            genresArray.append(value)
        }
        
        self.id = id
        self.averageRate = averageRate
        self.title = title
        self.posterURL = posterURL
        self.genres = genresArray
        self.releaseDate = releaseDate
    }
    
    // MARK: - Image
    func downloadImage(completion: ((_ image: UIImage?) -> ())?) {
        guard let imageURL = URL(string: self.posterURL), self.image == nil, self.imageDownloadTask == nil else {
            completion?(nil)
            return
        }
        
        self.imageDownloadTask = NetworkService.downloadImage(url: imageURL, completion: { (image) in
            self.image = image
            completion?(image)
            self.imageDownloadTask = nil
        })
    }
}

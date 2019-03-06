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
    let posterUrl: URL?
    let genres: [String]
    let releaseDate: String
    private (set) var image: UIImage?
    private var imageDownloadTask: URLSessionTask?
    
    // MARK: - Initialization
    init?(movieListDict: [String : Any]) {
        guard let id = movieListDict[NetworkMovieListConstants.id] as? Int,
            let averageRate = movieListDict[NetworkMovieListConstants.averageRate] as? Double,
            let title = movieListDict[NetworkMovieListConstants.title] as? String,
            let genres = movieListDict[NetworkMovieListConstants.genres] as? [String],
            let releaseDate = movieListDict[NetworkMovieListConstants.releaseDate] as? String else {
                return nil
        }
        
        var genresArray: [String] = []
        for value in genres {
            genresArray.append(value)
        }
        
        if let imageURLString = movieListDict[NetworkMovieListConstants.posterUrl] as? String, let posterURL = URL(string: imageURLString) {
            self.posterUrl = posterURL
        } else {
            self.posterUrl = nil
        }
        
        self.id = id
        self.averageRate = averageRate
        self.title = title
        self.genres = genresArray
        self.releaseDate = releaseDate
    }
    
    // MARK: - Image
    func downloadImage(completion: ((_ image: UIImage?) -> ())?) {
        guard let imageURL = self.posterUrl, self.image == nil, self.imageDownloadTask == nil else {
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

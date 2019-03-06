//
//  MovieDetail.swift
//  MovieList
//
//  Created by Daniel Oliveira on 05/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class MovieDetail {
    // MARK: - Variables
    let backDropUrl: URL?
    let budget: Int
    let genres: [String]
    let homepage: URL?
    let originalLanguage: String
    let originalTitle: String
    let overview: String
    let posterUrl: URL?
    let releaseDate: String
    let revenue: Int
    let title: String
    let averageRate: Double
    private (set) var posterImage: UIImage?
    private (set) var backDropImage: UIImage?
    private var imageDownloadTask: URLSessionTask?
    
    // MARK: - Initialization
    init?(movieDetailDict: [String : Any]) {
        guard let budget = movieDetailDict[NetworkMovieDetailConstants.budget] as? Int,
            let genres = movieDetailDict[NetworkMovieDetailConstants.genres] as? [String],
            let originalLanguage = movieDetailDict[NetworkMovieDetailConstants.originalLanguage] as? String,
            let originalTitle = movieDetailDict[NetworkMovieDetailConstants.originalTitle] as? String,
            let overview = movieDetailDict[NetworkMovieDetailConstants.overview] as? String,
            let releaseDate = movieDetailDict[NetworkMovieDetailConstants.releaseDate] as? String,
            let revenue = movieDetailDict[NetworkMovieDetailConstants.revenue] as? Int,
            let title = movieDetailDict[NetworkMovieDetailConstants.title] as? String,
            let averageRate = movieDetailDict[NetworkMovieDetailConstants.averageRate] as? Double else {
            return nil
        }
        
        self.budget = budget
        self.originalLanguage = originalLanguage
        self.originalTitle = originalTitle
        self.overview = overview
        self.releaseDate = releaseDate
        self.revenue = revenue
        self.title = title
        self.averageRate = averageRate
        
        var genresArray: [String] = []
        for value in genres {
            genresArray.append(value)
        }
        self.genres = genresArray
        
        if let backDropUrlString = movieDetailDict[NetworkMovieDetailConstants.backDropUrl] as? String, let backDropImage = URL(string: backDropUrlString) {
            self.backDropUrl = backDropImage
        } else {
            self.backDropUrl = nil
        }
        if let homepageUrlString = movieDetailDict[NetworkMovieDetailConstants.homepage] as? String, let homepageUrl = URL(string: homepageUrlString) {
            self.homepage = homepageUrl
        } else {
            self.homepage = nil
        }
        if let posterUrlString = movieDetailDict[NetworkMovieDetailConstants.posterUrl] as? String, let posterImage = URL(string: posterUrlString) {
            self.posterUrl = posterImage
        } else {
            self.posterUrl = nil
        }
    }
    
    // MARK: - Image
    func downloadPosterImage(completion: ((_ image: UIImage?) -> ())?) {
        guard let imageUrl = self.posterUrl, self.posterImage == nil, self.imageDownloadTask == nil else {
            completion?(nil)
            return
        }
        
        self.imageDownloadTask = NetworkService.downloadImage(url: imageUrl, completion: { (image) in
            self.posterImage = image
            completion?(image)
            self.imageDownloadTask = nil
        })
    }
    
    func downloadBackDropImage(completion: ((_ image: UIImage?) -> ())?) {
        guard let imageUrl = self.backDropUrl, self.backDropImage == nil, self.imageDownloadTask == nil else {
            completion?(nil)
            return
        }
        
        self.imageDownloadTask = NetworkService.downloadImage(url: imageUrl, completion: { (image) in
            self.posterImage = image
            completion?(image)
            self.imageDownloadTask = nil
        })
    }
}

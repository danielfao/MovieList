//
//  Movie.swift
//  Movie
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit
import Kingfisher

class Movie {
    // MARK: - Variables
    let id: Int
    let averageRate: Double
    let title: String
    let posterUrl: URL?
    let genres: [String]
    let releaseDate: String
    private(set) var backDropUrl: URL?
    private(set) var budget: Int?
    private(set) var homepage: URL?
    private(set) var originalLanguage: String?
    private(set) var originalTitle: String?
    private(set) var overview: String?
    private(set) var revenue: Int?
    private(set) var posterImage: UIImage?
    private(set) var backDropImage: UIImage?
    private var imagePosterDownloadTask: URLSessionTask?
    private var imageBackdropDownloadTask: URLSessionTask?
    
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
        
        if let imageURLString = movieListDict[NetworkMovieListConstants.posterUrl] as? String, let posterUrl = URL(string: imageURLString) {
            self.posterUrl = posterUrl
        } else {
            self.posterUrl = nil
        }
        
        self.id = id
        self.averageRate = averageRate
        self.title = title
        self.genres = NSOrderedSet(array: genresArray).array as? [String] ?? []
        self.releaseDate = releaseDate
    }
    
    func update(dict: [String : Any]) {
        self.budget = dict[NetworkMovieDetailConstants.budget] as? Int ?? nil
        self.originalLanguage = dict[NetworkMovieDetailConstants.originalLanguage] as? String ?? nil
        self.originalTitle = dict[NetworkMovieDetailConstants.originalTitle] as? String ?? nil
        self.overview = dict[NetworkMovieDetailConstants.overview] as? String ?? nil
        self.revenue = dict[NetworkMovieDetailConstants.revenue] as? Int ?? nil
        
        if let backDropUrlString = dict[NetworkMovieDetailConstants.backDropUrl] as? String, let backDropUrl = URL(string: backDropUrlString) {
            self.backDropUrl = backDropUrl
        } else {
            self.backDropUrl = nil
        }
        if let homepageUrlString = dict[NetworkMovieDetailConstants.homepage] as? String, let homepageUrl = URL(string: homepageUrlString) {
            self.homepage = homepageUrl
        } else {
            self.homepage = nil
        }
    }
    
    // MARK: - Image
    func downloadPosterImage(completion: ((_ image: UIImage?) -> ())?) {
        guard let imageURL = self.posterUrl, self.posterImage == nil, self.imagePosterDownloadTask == nil else {
            completion?(nil)
            return
        }
        
        self.imagePosterDownloadTask = NetworkService.downloadImage(url: imageURL, completion: { (image) in
            self.posterImage = image
            completion?(image)
            self.imagePosterDownloadTask = nil
        })
    }
}

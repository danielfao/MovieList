//
//  MovieDetailViewController.swift
//  MovieList
//
//  Created by Daniel Oliveira on 05/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var backdropImageView: UIImageView! {
        didSet {
            self.backdropImageView.contentMode = .scaleAspectFill
            self.backdropImageView.alpha = 0.3
        }
    }
    @IBOutlet weak var posterImageView: UIImageView! {
        didSet {
            self.posterImageView.contentMode = .scaleAspectFit
            self.posterImageView.layer.shadowColor = UIColor.black.cgColor
            self.posterImageView.layer.shadowRadius = 5.0
            self.posterImageView.layer.shadowOpacity = 0.5
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
            self.titleLabel.tintColor = UIColor.darkGray3
        }
    }
    @IBOutlet weak var originalTitleLabel: UILabel! {
        didSet {
            self.originalTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .semibold)
            self.originalTitleLabel.tintColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var releaseDateLabel: UILabel! {
        didSet {
            self.releaseDateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.releaseDateLabel.tintColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var averageRateLabel: UILabel! {
        didSet {
            self.averageRateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.averageRateLabel.tintColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var overviewTitleLabel: UILabel! {
        didSet {
            self.overviewTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            self.overviewTitleLabel.tintColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var overviewTextLabel: UILabel! {
        didSet {
            self.overviewTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.overviewTextLabel.tintColor = UIColor.lightGray3
            self.overviewTextLabel.textAlignment = .justified
        }
    }
    @IBOutlet weak var genresTitleLabel: UILabel! {
        didSet {
            self.genresTitleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            self.genresTitleLabel.tintColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var genresTextLabel: UILabel! {
        didSet {
            self.genresTextLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.genresTextLabel.tintColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var budgetLabel: UILabel! {
        didSet {
            self.budgetLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.budgetLabel.tintColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var revenueLabel: UILabel! {
        didSet {
            self.revenueLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.revenueLabel.tintColor = UIColor.lightGray3
        }
    }
    @IBOutlet weak var homepageLabel: UILabel! {
        didSet {
            self.homepageLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.homepageLabel.tintColor = UIColor.lightGray3
        }
    }
    
    // MARK: - Variables
    var movie: Movie?
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        self.navigationItem.title = String(format: String.localize("navigation_movie_detail_title"), self.movie?.title ?? "")
        
        // Populating fields
        if let movie = self.movie {
            movie.downloadBackDropImage { (backdrop) in
                self.backdropImageView.image = backdrop
            }
            MovieDetailService.getMovieDetail(movie: movie) {
                self.posterImageView.image = movie.posterImage
                self.titleLabel.text = movie.title
                if let originalTitle = movie.originalTitle {
                    self.originalTitleLabel.text = String(format: String.localize("original_movie_title"), originalTitle)
                }
                self.releaseDateLabel.text = String(format: String.localize("release_date_text"), movie.releaseDate)
                let averageRate = String(movie.averageRate)
                self.averageRateLabel.text = String(format: String.localize("average_rate_text"), averageRate)
                self.overviewTextLabel.text = movie.overview
                self.genresTextLabel.text = "\(movie.genres.joined(separator: ", "))"
                if let budget = movie.budget {
                    if budget != 0 {
                        let budgetFormatted = currencyFormatter(value: budget)
                        self.budgetLabel.text = String(format: String.localize("budget_text"), budgetFormatted)
                    } else {
                        self.budgetLabel.text = String.localize("budget_not_provided")
                    }
                }
                if let revenue = movie.revenue {
                    if revenue != 0 {
                        let revenueFormatted = currencyFormatter(value: revenue)
                        self.revenueLabel.text = String(format: String.localize("revenue_text"), revenueFormatted)
                    } else {
                        self.revenueLabel.text = String.localize("revenue_not_provided")
                    }
                }
                if let homepage = movie.homepage {
                    self.homepageLabel.text = String(format: String.localize("website_text"), String(describing: homepage))
                } else {
                    self.homepageLabel.text = String.localize("web_site_not_provided")
                }
            }
        }
    }
}

func currencyFormatter(value: Any) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.locale = Locale(identifier: "en_US")
    
    guard let value = value as? NSNumber, let valueFormatted = formatter.string(from: value) else {
        return ""
    }
    return valueFormatted
}

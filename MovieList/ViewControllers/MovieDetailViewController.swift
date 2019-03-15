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
    @IBOutlet weak var loaderView: LoaderView!
    @IBOutlet weak var emptyStateView: EmptyStateView! {
        didSet {
            self.emptyStateView.isHidden = true
        }
    }
    @IBOutlet weak var contentView: UIView! {
        didSet {
            self.contentView.isHidden = true
        }
    }
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
            self.overviewTitleLabel.text = String.localize("overview_title")
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
            self.genresTitleLabel.text = String.localize("genres_title")
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
    private let dispatchGroup = DispatchGroup()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Navigation Bar
        self.navigationItem.title = String(format: String.localize("navigation_movie_detail_title"), self.movie?.title ?? "")
    
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(internetConnected), name: .InternetConnectionReachable, object: nil)
        
        self.loaderView.loaderIsEnabled(status: true)
        
        // Populating fields
        self.getMovieDetail()
        
        self.dispatchGroup.notify(queue: .main) {
            self.loaderView.loaderIsEnabled(status: false)
        }
    }
    
    // MARK: - Functions
    private func getMovieDetail() {
        if let movie = self.movie {
            self.dispatchGroup.enter()
            MovieDetailService.getMovieDetail(movie: movie) {
                if movie.originalTitle == nil {
                    self.showEmptyState()
                    self.emptyStateView.configureEmptyState(title: EmptyStateMessage.NoInternetConnection, message: EmptyStateMessage.NoInternetConnectionMessage, image: ImageConstants.EmptyStateAlert, messageShouldShow: true)
                } else {
                    self.hideEmptyState()
                    if let posterUrl = movie.posterUrl {
                        self.downloadPosterImage(url: posterUrl)
                    }
                    if let backdropUrl = movie.backDropUrl {
                        self.downloadBackdropImage(url: backdropUrl)
                    }
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
                            let budgetFormatted = self.valueCurrencyFormatter(value: budget)
                            self.budgetLabel.text = String(format: String.localize("budget_text"), budgetFormatted)
                        } else {
                            self.budgetLabel.text = String.localize("budget_not_provided")
                        }
                    }
                    if let revenue = movie.revenue {
                        if revenue != 0 {
                            let revenueFormatted = self.valueCurrencyFormatter(value: revenue)
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
                self.dispatchGroup.leave()
            }
        }
    }

    private func downloadBackdropImage(url: URL) {
        self.backdropImageView.kf.setImage(with: url)
    }
    
    private func downloadPosterImage(url: URL) {
        self.posterImageView.kf.setImage(with: url, placeholder: ImageConstants.EmptyStateImage)
    }
    
    // MARK: - Layout
    private func valueCurrencyFormatter(value: Any) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "en_US")
        
        guard let value = value as? NSNumber, let valueFormatted = formatter.string(from: value) else {
            return ""
        }
        return valueFormatted
    }
    
    private func showEmptyState() {
        self.emptyStateView.isHidden = false
        self.contentView.isHidden = true
    }
    
    private func hideEmptyState() {
        self.emptyStateView.isHidden = true
        self.contentView.isHidden = false
    }
    
    // MARK: - Listners
    @objc func internetConnected() {
        self.getMovieDetail()
    }
}

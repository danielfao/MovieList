//
//  MovieListTableViewCell.swift
//  MovieList
//
//  Created by Daniel Oliveira on 04/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var posterView: UIImageView! {
        didSet {
            self.posterView.contentMode = .scaleAspectFit
            self.posterView.layer.shadowColor = UIColor.black.cgColor
            self.posterView.layer.shadowRadius = 5.0
            self.posterView.layer.shadowOpacity = 0.5
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            self.titleLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
            self.titleLabel.textColor = UIColor.darkGray3
        }
    }
    @IBOutlet weak var genreLabel: UILabel! {
        didSet {
            self.genreLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.genreLabel.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var releaseDataLabel: UILabel! {
        didSet {
            self.releaseDataLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.releaseDataLabel.textColor = UIColor.darkGray
        }
    }
    @IBOutlet weak var averageRateLabel: UILabel! {
        didSet {
            self.averageRateLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            self.averageRateLabel.textColor = UIColor.darkGray
        }
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK: - Setup cell
    func setupCell(movies: Movie) {
        self.posterView.image = movies.posterImage
        self.titleLabel.text = movies.title
        self.releaseDataLabel.text = String(format: String.localize("release_date_text"), movies.releaseDate)
        
        let averageRateText = String(movies.averageRate)
        self.averageRateLabel.text = String(format: String.localize("average_rate_text"), averageRateText)
        
        self.genreLabel.text = "\(movies.genres.joined(separator: ", "))"
    }
    
}

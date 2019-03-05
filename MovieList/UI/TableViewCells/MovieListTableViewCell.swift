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
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDataLabel: UILabel!
    @IBOutlet weak var averageRateLabel: UILabel!
    @IBOutlet weak var separatorView: UIView!
    
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setupCell(movies: MovieList) {
        self.titleLabel.text = movies.title
        var genreText: String = ""
        for genre in movies.genres {
            genreText += genre + " "
        }
        self.genreLabel.text = "\(genreText)"
        self.releaseDataLabel.text = movies.releaseDate
        self.averageRateLabel.text = String(movies.averageRate)
    }
    
}

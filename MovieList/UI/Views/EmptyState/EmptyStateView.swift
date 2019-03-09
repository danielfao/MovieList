//
//  EmptyStateView.swift
//  MovieList
//
//  Created by Daniel Oliveira on 08/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

enum EmptyStateMessage: String {
    case NoInternetConnection = "no_internet_connection_title"
    case NoInternetConnectionMessage = "no_internet_connection_message"
}

class EmptyStateView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var emptyStateImage: UIImageView! {
        didSet {
            self.emptyStateImage.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var emptyStateTitle: UILabel! {
        didSet {
            self.emptyStateTitle.textColor = UIColor.darkGray3
            self.emptyStateTitle.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        }
    }
    @IBOutlet weak var emptyStateMessage: UILabel! {
        didSet {
            self.emptyStateMessage.isHidden = true
            self.emptyStateMessage.textColor = UIColor.darkGray3
            self.emptyStateMessage.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        }
    }
    
    // MARK: - Initialization Methods
    override func setupView() {
        super.setupView()
        
        self.backgroundColor = UIColor.white
    }
    
    func configureEmptyState(title: EmptyStateMessage, message: EmptyStateMessage? = nil, image: UIImage? = nil, messageShouldShow: Bool? = nil) {
        self.emptyStateTitle.text = String.localize(title.rawValue)
        
        if let messageShouldShow = messageShouldShow {
            if messageShouldShow {
                self.emptyStateMessage.isHidden = false
            }
        }
        
        if let message = message {
            self.emptyStateMessage.text = String.localize(message.rawValue)
        }
        self.emptyStateImage.image = image
    }
}

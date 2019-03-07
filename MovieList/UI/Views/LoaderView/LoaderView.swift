//
//  LoaderView.swift
//  MovieList
//
//  Created by Daniel Oliveira on 07/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class LoaderView: BaseView {
    // MARK: - IBOutlets
    @IBOutlet weak var containerLoaderView: UIView! {
        didSet {
            self.containerLoaderView.isHidden = true
            self.containerLoaderView.backgroundColor = UIColor.lightGray
            self.containerLoaderView.layer.cornerRadius = 8.0
        }
    }
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            self.activityIndicator.isHidden = true
        }
    }
    
    // MARK: - Functions
    func loaderIsEnabled(status: Bool) {
        if status {
            self.containerLoaderView.isHidden = false
            self.activityIndicator.isHidden = false
            self.activityIndicator.startAnimating()
        } else {
            self.containerLoaderView.isHidden = true
            self.activityIndicator.isHidden = true
            self.isHidden = true
            self.activityIndicator.stopAnimating()
        }
    }
}

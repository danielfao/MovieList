//
//  StringExtension.swift
//  MovieList
//
//  Created by Daniel Oliveira on 05/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

extension String {
    static func localize(_ key: String) -> String {
        return NSLocalizedString(key, comment: "")
    }
}

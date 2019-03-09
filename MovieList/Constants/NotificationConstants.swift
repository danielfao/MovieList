//
//  NotificationConstants.swift
//  MovieList
//
//  Created by Daniel Oliveira on 07/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation

extension Notification.Name {
    // Internet Notification
    static let InternetConnectionReachable = Notification.Name(rawValue: "InternetConnectionReachable")
    static let InternetConnectionNotReachable = Notification.Name(rawValue: "InternetConnectionNotReachable")
}

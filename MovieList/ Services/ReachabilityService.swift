//
//  ReachabilityService.swift
//  MovieList
//
//  Created by Daniel Oliveira on 07/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import Foundation
import Reachability

final class ReachabilityService {
    // MARK: - Variables
    private static let reachability = Reachability()!
    
    // MARK: - Life Cycle
    static func start() {
        self.reachability.whenReachable = { _ in
            ConsoleLogger.log("Internet reachable")
            NotificationCenter.default.post(name: .InternetConnectionReachable, object: nil, userInfo: nil)
        }
        self.reachability.whenUnreachable = { _ in
            ConsoleLogger.log("Internet not reachable")
            NotificationCenter.default.post(name: .InternetConnectionNotReachable, object: nil, userInfo: nil)
        }
        
        do {
            try reachability.startNotifier()
        } catch {
            ConsoleLogger.log("Unable to start notifier")
        }
    }
    
    // MARK: - Status
    static var connection: Reachability.Connection {
        return self.reachability.connection
    }
    
    static var isConnected: Bool {
        return self.connection == .wifi || self.connection == .cellular
    }
}

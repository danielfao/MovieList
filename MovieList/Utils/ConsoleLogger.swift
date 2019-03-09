//
//  ConsoleLogger.swift
//  MovieList
//
//  Created by Daniel Oliveira on 07/03/19.
//  Copyright © 2019 Daniel Oliveira. All rights reserved.
//

import UIKit

class ConsoleLogger {
    static func log(_ output: String) {
        #if DEBUG || PRINT_LOG
            print(output)
        #endif
    }
}

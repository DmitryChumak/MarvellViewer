//
//  TimeProvider.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class TimeProvider {
    
    static var currentTimeMillis: Double {
        return Date().timeIntervalSince1970
    }
}

//
//  UIStoryboard+Extension.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/25/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

extension UIStoryboard {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
}



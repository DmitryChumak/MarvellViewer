//
//  Storyboarded.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/25/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func instantiate() -> self {
        let fullName = self.reuseIdentifier
        let className = fullName.components(separatedBy: ".")[1]
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! self
    }
}

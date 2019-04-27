//
//  UICollectionViewCell+identifier.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

extension UICollectionViewCell {
    static var reuseIdentifier: String {
        return String(describing: self)
    }
    
    static func register(for collectionView: UICollectionView) {
        let nib = UINib.init(nibName: self.reuseIdentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: self.reuseIdentifier)
    }
}

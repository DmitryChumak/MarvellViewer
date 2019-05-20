//
//  UIViewController+Extension.swift
//  MarvellViewer
//
//  Created by Dmitry on 5/20/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func handleError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true)
    }
}


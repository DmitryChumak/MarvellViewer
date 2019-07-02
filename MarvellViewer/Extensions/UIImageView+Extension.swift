//
//  UIImageView+Extension.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/27/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

private var key: Void?

extension UIImageView {
    
    private var task:URLSessionTask? {
        get {
            return objc_getAssociatedObject(self, &key) as? URLSessionTask
        }
        set(newValue) {
            objc_setAssociatedObject(self,
                                     &key, newValue,
                                     .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func load(from url: URL) {
       task = URLSession.shared.dataTask(with: url) { data , _ , error in
            if let data = data {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.image = image
                    }
                }
            } else if let error = error {
                print(error)
            }
        }
        task?.resume()
    }
    func cancelLoading() {
        if task?.state == .running {
            task?.cancel()
        }
    }
    
}

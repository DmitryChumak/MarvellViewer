//
//  UIImage+Extension.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/26/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit


var taskKey: UInt8 = 0

extension UIImage {
    private var task: URLSessionTask? {
        get {
            guard let value = objc_getAssociatedObject(self, &taskKey) as? URLSessionTask else {
                return nil
            }
            return value
        }
        set(newValue) {
            objc_setAssociatedObject(self, &taskKey, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    func load(from url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> ()) -> URLSessionTask? {
        task = URLSession.shared.dataTask(with: url) { data , _ , error in
            if let data = data {
                if let image = UIImage(data: data) {
                    completionHandler(.success(image))
                }
            } else if let error = error {
                completionHandler(.failure(error))
            }
        }
        task?.resume()
        return task
    }
    
}



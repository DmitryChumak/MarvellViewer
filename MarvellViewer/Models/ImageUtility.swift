//
//  ImageUtility.swift
//  MarvellViewer
//
//  Created by Dmitry on 5/29/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

class ImageUtility {
    private var task: URLSessionTask?
    
    func load(from url: URL, completionHandler: @escaping (Result<UIImage, Error>) -> ()) {
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
    }
    
    func cancelLoading() {
        if task?.state == .running {
            task?.cancel()
        }
    }
}

//
//  NetworkManager.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation


protocol NetworkManager {
    typealias Handler = ((Result<Data, Error>) -> ())
    
    func loadData(from url: String, completionHandler: @escaping Handler)
}

extension URLSession: NetworkManager {
    
    private enum URLSessionError: Error {
        case unknown
    }
    
    func loadData(from urlString: String, completionHandler: @escaping Handler) {
        let url = URL(string: urlString)!
        let task = URLSession.shared.dataTask(with: url) { data, _ , error in
            if let data = data {
                completionHandler(.success(data))
            } else if let error = error {
                completionHandler(.failure(error))
            } else {
                completionHandler(.failure(URLSessionError.unknown))
            }
        }
        task.resume()
    }
}

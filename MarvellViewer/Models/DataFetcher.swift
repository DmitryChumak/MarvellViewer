//
//  DataFetcher.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation


protocol DataFetcher {
    func fetch(for offset: Int, completionHandler: @escaping (Result<[MarvelEntity], Error>) -> (Void))
}

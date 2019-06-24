//
//  MarvelCharacterFetcher.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class MarvelCharacterFetcher: DataFetcher {
    
    private var marvelManager: MarvelManager!
    
    init() {
        self.marvelManager = MarvelManager(networkClient: URLSession.shared)
    }
    
    
    func fetch(for offset: Int, completionHandler: @escaping (Result<[MarvelEntity], Error>) -> (Void)) {
        marvelManager.loadCharacters(from: offset, completionHandler: completionHandler)
    }
    
    
}

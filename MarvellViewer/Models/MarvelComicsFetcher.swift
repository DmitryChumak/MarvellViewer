//
//  MarvelComicsFetcher.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class MarvelComicsFetcher: DataFetcher {
    
    private let marvelManager: MarvelManager!
    private var marvelCharacter: MarvelCharacter!
    
    init(for character: MarvelCharacter) {
        marvelManager = MarvelManager(networkClient: URLSession.shared)
        self.marvelCharacter = character
    }
    
    func fetch(for offset: Int, completionHandler: @escaping (Result<[MarvelEntity], Error>) -> (Void)) {
        marvelManager.loadComics(for: marvelCharacter, from: offset, completionHandler: completionHandler)
    }
}

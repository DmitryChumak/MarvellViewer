//
//  MarvelManager.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class MarvelCharacterManager {
    private enum QuoteLoaderError: Error {
        case invalidData
    }
    private let networkClient: NetworkManager
    init(networkClient: NetworkManager) {
        self.networkClient = networkClient
    }
    
    func loadMarvelCollection(completionHandler: @escaping (Result<MarvelCharacterCollection, Error>) -> ()) {
        let ts = Int(TimeProvider.currentTimeMillis)
        let privateKey = MarvelAPIConfig.privateKey
        let publicKey = MarvelAPIConfig.publicKey
        let hash = MarvelAPIHashGenerator.generateHash(timestamp: ts, privateKey: privateKey, publicKey: publicKey)
        let url = "https://gateway.marvel.com:443/v1/public/characters?ts=\(ts)&apikey=\(publicKey)&hash=\(hash)"
        networkClient.loadData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    completionHandler(.success(try data.decoded()))
                } catch {
                    completionHandler(.failure(QuoteLoaderError.invalidData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
                
            }
            
        }
        
    }
    
}

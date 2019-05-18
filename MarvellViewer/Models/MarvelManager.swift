//
//  MarvelManager.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class MarvelManager {
    private enum MarvelManagerError: Error {
        case invalidData
    }
    private let networkClient: NetworkManager
    init(networkClient: NetworkManager) {
        self.networkClient = networkClient
    }
    
    func loadCharacters(from offset: Int, take count: Int, completionHandler: @escaping (Result<MarvelCharacterCollection, Error>) -> ()) {
        let url = "\(MarvelAPIConfig.baseURL)characters?offset=\(offset)&limit=\(count)&\(MarvelAPIConfig.secureParameters)"
        networkClient.loadData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    completionHandler(.success(try data.decoded()))
                } catch {
                    completionHandler(.failure(MarvelManagerError.invalidData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    func loadComics(for character: MarvelCharacter, completionHandler: @escaping (Result<MarvelComicsCollection,Error>) -> ()) {
        let characterId = character.id
        let url = "\(MarvelAPIConfig.baseURL)characters/\(characterId)/comics?\(MarvelAPIConfig.secureParameters)"
        networkClient.loadData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    completionHandler(.success(try data.decoded()))
                } catch {
                    completionHandler(.failure(MarvelManagerError.invalidData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
}

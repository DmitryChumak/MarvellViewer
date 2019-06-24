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
    
    
    func loadCharacters(from offset: Int,  completionHandler: @escaping (Result<[MarvelEntity], Error>) -> (Void)) {
        let url = "\(MarvelAPIConfig.baseURL)characters?offset=\(offset)&\(MarvelAPIConfig.secureParameters)"
        networkClient.loadData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let characters: MarvelCharacterCollection = try data.decoded()
                    completionHandler(.success(characters.marvelCharacters))
                } catch {
                    completionHandler(.failure(MarvelManagerError.invalidData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    func loadComics(for character: MarvelCharacter, from offset: Int, completionHandler: @escaping (Result<[MarvelEntity],Error>) -> (Void)) {
        let characterId = character.id
        let url = "\(MarvelAPIConfig.baseURL)characters/\(characterId)/comics?offset=\(offset)&\(MarvelAPIConfig.secureParameters)"
        networkClient.loadData(from: url) { result in
            switch result {
            case .success(let data):
                do {
                    let comics: MarvelComicsCollection = try data.decoded()
                    completionHandler(.success(comics.marvelComics))
                } catch {
                    completionHandler(.failure(MarvelManagerError.invalidData))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
    
    
    
    
}

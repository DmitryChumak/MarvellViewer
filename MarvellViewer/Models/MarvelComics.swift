//
//  MarvelComics.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/13/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation


struct MarvelComics: Decodable, MarvelEntity {
    var id: Int
    var title: String
    var description: String
    var imageURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case description
        case thumbnail
        
        
        enum ThumbnailCodingKeys: String, CodingKey {
            case path
            case ext = "extension"
        }
        
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(Int.self, forKey: CodingKeys.id)
        title = try container.decode(String.self, forKey: CodingKeys.title)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        let thumbnail = try container.nestedContainer(keyedBy: CodingKeys.ThumbnailCodingKeys.self, forKey: CodingKeys.thumbnail)
        let path = try thumbnail.decode(String.self, forKey: CodingKeys.ThumbnailCodingKeys.path)
        let ext = try thumbnail.decode(String.self, forKey: CodingKeys.ThumbnailCodingKeys.ext)
        imageURL = URL(string: "\(path).\(ext)")
        
    
    }
}

struct MarvelComicsCollection: Decodable {
    var marvelComics: [MarvelComics]
}

extension MarvelComicsCollection {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        let meta = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey("data"))
        let marvelComics = try meta.decode([MarvelComics].self, forKey: AnyCodingKey("results"))
        self.init(marvelComics: marvelComics)
    }
}

//
//  File.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

struct MarvelCharacter : Decodable {
    var id: Int
    var name: String
    var description: String
    var imageURL: URL?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
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
        name = try container.decode(String.self, forKey: CodingKeys.name)
        description = try container.decode(String.self, forKey: CodingKeys.description)
        name = try container.decode(String.self, forKey: CodingKeys.name)
        let thumbnail = try container.nestedContainer(keyedBy: CodingKeys.ThumbnailCodingKeys.self, forKey: CodingKeys.thumbnail)
        let path = try thumbnail.decode(String.self, forKey: CodingKeys.ThumbnailCodingKeys.path)
        let ext = try thumbnail.decode(String.self, forKey: CodingKeys.ThumbnailCodingKeys.ext)
        imageURL = URL(string: "\(path).\(ext)")
        
    }
}



struct MarvelCharacterCollection : Decodable {
    var marvelCharacters: [MarvelCharacter]
    
}


extension MarvelCharacterCollection {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: AnyCodingKey.self)
        let meta = try container.nestedContainer(keyedBy: AnyCodingKey.self, forKey: AnyCodingKey("data"))
        let marvelCharacters = try meta.decode([MarvelCharacter].self, forKey: AnyCodingKey("results"))
        self.init(marvelCharacters: marvelCharacters)
    }
}

struct AnyCodingKey: CodingKey {
    var stringValue: String
    var intValue: Int?
    
    init(_ string: String) {
        stringValue = string
    }
    
    init?(stringValue: String) {
        self.stringValue = stringValue
    }
    
    init?(intValue: Int) {
        self.intValue = intValue
        self.stringValue = String(intValue)
    }
}




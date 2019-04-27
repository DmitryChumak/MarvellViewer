//
//  MarvelAPIHashGenerator.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import CryptoSwift


class MarvelAPIHashGenerator {
    
    static func generateHash(timestamp: Int, privateKey: String, publicKey: String) -> String {
        let combinedHash = "\(timestamp)\(privateKey)\(publicKey)"
        return combinedHash.md5()
    }
    
}

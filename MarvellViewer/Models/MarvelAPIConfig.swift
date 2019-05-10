//
//  MarvelAPIConfig.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation

class MarvelAPIConfig {
    static var publicKey: String {
        return "919abf74c3b2a2aeb30d62842b927a47"
    }
    static var privateKey :String {
        return "081bf9a48de8918828b583081c0d04af23b44192"
    }
    
    static var baseURL: String {
        return "https://gateway.marvel.com:443/v1/public/"
    }
    
    static var hash: String {
        return MarvelAPIHashGenerator.generateHash(timestamp: Int(TimeProvider.currentTimeMillis), privateKey: self.privateKey, publicKey: self.publicKey)
    }
    static var secureParameters: String {
        return "ts=\(Int(TimeProvider.currentTimeMillis))&apikey=\(publicKey)&hash=\(self.hash)"
    }
}

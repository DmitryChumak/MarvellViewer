//
//  Data+Extension.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/24/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation


extension Data {
    func decoded<T: Decodable>() throws -> T {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: self)
    }
}

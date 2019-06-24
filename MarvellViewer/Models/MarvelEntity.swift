//
//  MarvelEntity.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/17/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

protocol MarvelEntity {
    var title: String { get }
    var imageURL: URL? { get }
}

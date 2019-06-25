//
//  Coordinator.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/25/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

protocol Coordinator {
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    
    func showDetails(for entity: MarvelEntity)
    func start()
}

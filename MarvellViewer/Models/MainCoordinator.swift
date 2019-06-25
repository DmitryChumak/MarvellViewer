//
//  MainCoordinator.swift
//  MarvellViewer
//
//  Created by Dmitry on 6/25/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: Coordinator {
    var childCoordinators = [Coordinator]()
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let vc = ViewController.instantiate() as ViewController
        vc.coordinator = self
        vc.dataFetcher = MarvelCharacterFetcher()
        navigationController.pushViewController(vc, animated: true)
    }
    
    func showDetails(for entity: MarvelEntity) {
        let vc = ViewController.instantiate() as ViewController
        vc.coordinator = self
        vc.dataFetcher = MarvelComicsFetcher(for: entity as! MarvelCharacter)
        navigationController.pushViewController(vc, animated: true)
    }
}

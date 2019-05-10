//
//  MarvelCharacterDetails.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/27/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class MarvelCharacterDetailsViewController: UIViewController {

    @IBOutlet private var marvelComicsLabel: UILabel!
    
    private var marvelCharacter: MarvelCharacter!
    private var marvelManager: MarvelManager!
    private var marvelComicsCollection: MarvelComicsCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        marvelManager = MarvelManager(networkClient: URLSession.shared)
        loadComicsCollection()
       
        
    }
    
    func loadComicsCollection() {
        marvelManager.loadComics(for: marvelCharacter) { [weak self] result in
            switch result {
            case .success(let res):
                self?.marvelComicsCollection = res
                var resStr = ""
                for marvelComics in (self?.marvelComicsCollection.marvelComics)! {
                    resStr += "\(marvelComics.description)\n"
                }
                DispatchQueue.main.async {
                    self?.marvelComicsLabel.text = resStr
                }
                
            case .failure(let error):
                self?.handleError(error: error)
            }
            
        }
    }
    
    func configure(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
    }
    

}

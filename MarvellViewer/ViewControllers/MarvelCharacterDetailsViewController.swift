//
//  MarvelCharacterDetails.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/27/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class MarvelCharacterDetailsViewController: UIViewController {

    @IBOutlet private var collectionView: UICollectionView!
    
    private var marvelCharacter: MarvelCharacter!
    private var marvelManager: MarvelManager!
    private var marvelComicsCollection: MarvelComicsCollection!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        marvelManager = MarvelManager(networkClient: URLSession.shared)
        MarvelComicsCollectionViewCell.register(for: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        loadComicsCollection()

        
    }
    
    func loadComicsCollection() {
        marvelManager.loadComics(for: marvelCharacter) { [weak self] result in
            switch result {
            case .success(let res):
                self?.marvelComicsCollection = res
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    func configure(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
    }
    

}


// MARK: - MarvelCharacterDetailsViewControllerDataSource


extension MarvelCharacterDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = marvelComicsCollection?.marvelComics.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelComicsCollectionViewCell.reuseIdentifier, for: indexPath) as! MarvelComicsCollectionViewCell
        cell.configure(with: marvelComicsCollection.marvelComics[indexPath.row])
        return cell
    }
    
    
}



// MARK: - MarvelCharacterDetailsViewControllerDataSource

extension MarvelCharacterDetailsViewController: UICollectionViewDelegate {
    
}

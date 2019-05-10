//
//  ViewController.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var marvelCollection: MarvelCharacterCollection!
    private var marvelManager: MarvelManager!
    
    override func viewDidLoad() {
        
        marvelManager = MarvelManager(networkClient: URLSession.shared)
        MarvelCharacterCollectionViewCell.register(for: collectionView)
        collectionView.delegate = self
        loadCharactersCollection()
        
    }
    
    private func loadCharactersCollection() {
        marvelManager.loadCharacters() { [weak self] result in
            switch result {
            case .success(let res):
                self?.marvelCollection = res
                DispatchQueue.main.async {
                    self?.collectionView.dataSource = self
                }
            case .failure(let error):
                self?.handleError(error: error)
                
            }
        }
    }

    
}







// MARK: - MarvelCharacterCollectionViewDelegate

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvelCollection.marvelCharacters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! MarvelCharacterCollectionViewCell
        cell.configure(with: marvelCollection.marvelCharacters[indexPath.row])
        return cell
    }
    
}

// MARK: - MarvelCharacterCollectionViewDataSource

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "MarvelCharacterDetails", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! MarvelCharacterDetailsViewController
        let character = marvelCollection.marvelCharacters[indexPath.row]
        vc.configure(marvelCharacter: character)
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
}

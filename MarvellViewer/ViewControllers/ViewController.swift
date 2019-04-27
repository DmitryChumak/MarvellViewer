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
    
    private var marvelCollection: MarvelCharacterCollection! = nil
    private var marvelManager: MarvelCharacterManager!
    
    override func viewDidLoad() {
        
        marvelManager = MarvelCharacterManager(networkClient: URLSession.shared)
        MarvelCharacterCollectionViewCell.register(for: collectionView)
        loadCollection()
        
    }
    
    private func loadCollection() {
        marvelManager.loadMarvelCollection() { [weak self] result in
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
    
    private func handleError(error: Error) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        self.present(alert, animated: true, completion: nil)
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
        <#code#>
    }
    
}

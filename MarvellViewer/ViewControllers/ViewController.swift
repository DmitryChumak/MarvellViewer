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
    private var isLoading: Bool = false
    
    override func viewDidLoad() {
        
        marvelManager = MarvelManager(networkClient: URLSession.shared)
        MarvelCharacterCollectionViewCell.register(for: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        loadCharactersCollection(from: 0)
        
    }
    
    private func loadCharactersCollection(from offset: Int) {
  
        marvelManager.loadCharacters(from: offset) { [weak self] result in
            switch result {
            case .success(let res):
                if self?.marvelCollection != nil {
                    self?.marvelCollection.marvelCharacters.append(contentsOf: res.marvelCharacters)
                } else {
                    self?.marvelCollection = res
                }
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                    self?.isLoading = false
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.handleError(error: error)
                }
            }
        }
    }
}



// MARK: - MarvelCharacterCollectionViewDataSource

extension ViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let count = marvelCollection?.marvelCharacters.count else { return 0 }
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! MarvelCharacterCollectionViewCell
        
       
        cell.configure(with: marvelCollection.marvelCharacters[indexPath.row])
        
        return cell
    }
    
    
    
}

// MARK: - MarvelCharacterCollectionViewDelegate

extension ViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
//        let storyboard = UIStoryboard(name: "MarvelCharacterDetails", bundle: nil)
//        let vc = storyboard.instantiateInitialViewController() as! MarvelCharacterDetailsViewController
//        let character = marvelCollection.marvelCharacters[indexPath.row]
//        vc.configure(marvelCharacter: character)
//        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && !isLoading {
            isLoading = true
            loadCharactersCollection(from: marvelCollection.marvelCharacters.count)
            
        }
    }
}

//
//  ViewController.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit
import CoreGraphics


class ViewController: UIViewController {
    
    @IBOutlet private var collectionView: UICollectionView!
    
    private var marvelCollection: MarvelCharacterCollection!
    private var marvelManager: MarvelManager!
    private var isLoading: Bool = false
    
    private var cellsPerRow:CGFloat = 2
    private let cellPadding:CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        marvelManager = MarvelManager(networkClient: URLSession.shared)
        MarvelCharacterCollectionViewCell.register(for: collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        loadDataForFirstPage()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        if UIDevice.current.userInterfaceIdiom == .pad {
            cellsPerRow = UIDevice.current.orientation.isLandscape ? 3 : 2
        } else {
            cellsPerRow = UIDevice.current.orientation.isLandscape ? 2 : 1
        }
        collectionView.collectionViewLayout.invalidateLayout()
    }
    
    private func loadDataToCollection(from offset: Int, loaderView: LoaderView) {
        marvelManager.loadCharacters(from: offset) { [weak self] result in
            switch result {
            case .success(let res):
                if self?.marvelCollection == nil {
                    self?.marvelCollection = res
                } else {
                    self?.marvelCollection.marvelCharacters.append(contentsOf: res.marvelCharacters)
                }
                DispatchQueue.main.async {
                    self?.collectionView.contentInset = .zero
                    loaderView.removeFromSuperview()
                    self?.collectionView.reloadData()
                    self?.isLoading = false
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.collectionView.contentInset = .zero
                    loaderView.removeFromSuperview()
                    self?.handleError(error: error)
                }
            }
        }
    }
    
    private func loadDataForFirstPage() {
        let loaderView = LoaderView(frame: CGRect(x: 0, y: 0, width: collectionView.bounds.width, height: 50))
        
        loaderView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(loaderView)
        loaderView.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor).isActive = true
        loaderView.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor).isActive = true
        loadDataToCollection(from: 0, loaderView: loaderView)
        
    }
    
    private func loadDataForNextPage(from offset: Int) {
        
        let loaderView = LoaderView(frame: CGRect(x: 0, y: collectionView.contentSize.height, width: collectionView.bounds.width, height: 50))
        collectionView.addSubview(loaderView)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: loaderView.frame.size.height, right: 0)
        loadDataToCollection(from: offset, loaderView: loaderView)
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
        
        let storyboard = UIStoryboard(name: "MarvelCharacterDetails", bundle: nil)
        let vc = storyboard.instantiateInitialViewController() as! MarvelCharacterDetailsViewController
        let character = marvelCollection.marvelCharacters[indexPath.row]
        vc.configure(marvelCharacter: character)
        self.navigationController?.pushViewController(vc, animated: true)
    
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && !isLoading {
            isLoading = true
            loadDataForNextPage(from: marvelCollection.marvelCharacters.count)
            
        }
    }
}



// MARK: - MarvelCharacterCollectionViewDelegateFlowLayout

extension ViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthMinusPadding = collectionView.bounds.width - (cellPadding + cellPadding * cellsPerRow)
        let width = widthMinusPadding / cellsPerRow
        return CGSize(width: width, height: width / 2.5)

    }
    
}

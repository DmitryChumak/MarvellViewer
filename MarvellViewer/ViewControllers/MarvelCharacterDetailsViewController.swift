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
    
    private var marvelCharacter: MarvelEntity!
    private var marvelComics: [MarvelComics] = Array()
    
    private var comicsFetcher: MarvelComicsFetcher!
    
    private var isLoading: Bool = false
    private var cellsPerRow:CGFloat = 2
    private let cellPadding:CGFloat = 5
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        comicsFetcher = MarvelComicsFetcher(for: marvelCharacter as! MarvelCharacter)
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
        comicsFetcher.fetch(for: offset) { [weak self] result in
            switch result {
            case .success(let res):
                self?.marvelComics.append(contentsOf: res as! [MarvelComics])
                
                DispatchQueue.main.async {
                    self?.isLoading = false
                    self?.collectionView.contentInset = .zero
                    loaderView.removeFromSuperview()
                    self?.collectionView.reloadData()
                    
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    self?.collectionView.contentInset = .zero
                    loaderView.removeFromSuperview()
                    self?.handleError(error: error)
                    self?.isLoading = false
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
    
    
   
    
    func configure(marvelCharacter: MarvelCharacter) {
        self.marvelCharacter = marvelCharacter
    }
    

}


// MARK: - MarvelCharacterDetailsViewControllerDataSource


extension MarvelCharacterDetailsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return marvelComics.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MarvelCharacterCollectionViewCell.reuseIdentifier, for: indexPath) as! MarvelCharacterCollectionViewCell
    
        cell.configure(with: marvelComics[indexPath.row] as MarvelEntity)
        return cell
    }
    
    
}



// MARK: - MarvelCharacterDetailsViewControllerDataSource

extension MarvelCharacterDetailsViewController: UICollectionViewDelegate {
    
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offsetY > contentHeight - scrollView.frame.size.height && !isLoading {
            let offset = marvelComics.count
            isLoading = true
            loadDataForNextPage(from: offset)
        }
    }
}


// MARK: - MarvelComicsCollectionViewDelegateFlowLayout

extension MarvelCharacterDetailsViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let widthMinusPadding = collectionView.bounds.width - (cellPadding + cellPadding * cellsPerRow)
        let width = widthMinusPadding / cellsPerRow
        return CGSize(width: width, height: width / 2.5)
        
    }
    
}

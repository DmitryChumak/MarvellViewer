//
//  HeroCollectionViewCell.swift
//  MarvellViewer
//
//  Created by Dmitry on 4/23/19.
//  Copyright © 2019 Dmitry. All rights reserved.
//

import UIKit

class MarvelCharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet private var marvelCharacterImage: UIImageView!
    @IBOutlet private var marvelCharacterNameLabel: UILabel!
    private var imageUtil: ImageUtility = ImageUtility()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageUtil.cancelLoading()
    }
    
    func configure(with entity: MarvelEntity) {
        
        imageUtil.load(from: entity.imageURL!) { [weak self] result in
            switch result {
            case .success(let image):
                
                DispatchQueue.main.async {
                    self?.marvelCharacterImage.image = image
                }
    
            case .failure(let error):
                print(error)
            }
        }
       
        marvelCharacterNameLabel.text = entity.title
        
        
    }
    
    
}

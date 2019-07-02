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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        marvelCharacterImage.cancelLoading()
    }
    
    
    func configure(with entity: MarvelEntity) {
        marvelCharacterImage.load(from: entity.imageURL!)
        marvelCharacterNameLabel.text = entity.title
    }
}

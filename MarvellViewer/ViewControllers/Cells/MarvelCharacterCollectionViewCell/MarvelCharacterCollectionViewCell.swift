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
    
    func configure(with marvelCharacter: MarvelCharacter) {
        
        let data = try! Data(contentsOf: marvelCharacter.imageURL!)
        marvelCharacterImage.image = UIImage(data: data)
        marvelCharacterNameLabel.text = marvelCharacter.name
        
        
    }
    
    
}

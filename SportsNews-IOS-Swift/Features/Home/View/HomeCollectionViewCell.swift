//
//  HomeCollectionViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 31/05/2025.
//

import UIKit

class HomeCollectionViewCell: UICollectionViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Rounded corners
        contentView.layer.cornerRadius = 16
        contentView.layer.masksToBounds = true

        image.layer.cornerRadius = 16
        image.clipsToBounds = true

        // Shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.15
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 4
        layer.masksToBounds = false
    }

    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var title: UILabel!
    
}

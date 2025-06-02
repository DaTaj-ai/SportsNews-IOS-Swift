//
//  TeamCollectionViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 31/05/2025.
//

import UIKit

class TeamCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var TeamImage: UIImageView!
    
    @IBOutlet weak var TeamName: UILabel!
    
    override func awakeFromNib() {
           super.awakeFromNib()
           TeamImage.layer.cornerRadius = TeamImage.frame.height / 2
           TeamImage.clipsToBounds = true
           TeamImage.contentMode = .scaleAspectFill
       }

       func configure(with team: Team) {
           TeamName.text = team.teamName
           if let logoUrlString = team.teamLogo, let url = URL(string: logoUrlString) {
               TeamImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
           } else {
               TeamImage.image = UIImage(named: "placeholder")
           }
       }

}

//
//  LeagueTableCell.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 01/06/2025.
//

import UIKit

class LeagueTableCell: UITableViewCell {
    
    @IBOutlet weak var LeagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupCellAppearance()
    }
    
    func configure(with title: String , image: String) {
        leagueName.text = title
        
        let placeholder = UIImage(named: "sports_placeholder")
         let url = URL(string: image)
            LeagueImage.kf.setImage(
                with: url,
                placeholder: placeholder,
                options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ]
            )
        
//             else {
//            LeagueImage.image = placeholder
//        }
    }
    
    private func setupCellAppearance() {
        // Cell container styling
        contentView.backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 12
        contentView.layer.masksToBounds = true
        
        // Add shadow
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 6
        layer.shadowOpacity = 0.1
        layer.masksToBounds = false
        
        // Image styling
        LeagueImage.layer.masksToBounds = true
        LeagueImage.contentMode = .scaleAspectFit
        LeagueImage.layer.borderWidth = 1
        LeagueImage.layer.borderColor = UIColor.blue.cgColor
        
        // Title styling
        leagueName.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        leagueName.textColor = .label
        leagueName.numberOfLines = 1
        leagueName.adjustsFontSizeToFitWidth = true
        leagueName.minimumScaleFactor = 0.8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        LeagueImage.layer.cornerRadius = 12
        
        layer.shadowPath = UIBezierPath(roundedRect: bounds, cornerRadius: contentView.layer.cornerRadius).cgPath
        
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Custom selection animation
        UIView.animate(withDuration: 0.2) {
            self.contentView.alpha = selected ? 0.7 : 1.0
        }
    }
}

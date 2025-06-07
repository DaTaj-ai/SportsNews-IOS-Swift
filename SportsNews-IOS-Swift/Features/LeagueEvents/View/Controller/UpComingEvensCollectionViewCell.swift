//
//  UpComingEvensCollectionViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 31/05/2025.
//

import UIKit
import Kingfisher
class UpComingEvensCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var backGround: UIImageView!
    @IBOutlet weak var logoTeam1: UIImageView!
    @IBOutlet weak var nameTeam1: UILabel!
    @IBOutlet weak var nameTeam2: UILabel!
    @IBOutlet weak var logoTeam2: UIImageView!
    @IBOutlet weak var matchDate: UILabel!
    @IBOutlet weak var matchTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupBackgroundCorners()
        self.contentView.layer.cornerRadius=16
        self.layer.cornerRadius=16
        
       // styleImageView(logoTeam1)
        //styleImageView(logoTeam2)
    }
    
    private func styleImageView(_ imageView: UIImageView) {
        imageView.layer.cornerRadius = imageView.frame.height / 2
        imageView.clipsToBounds = true
        imageView.layer.borderWidth = 1.5
        imageView.layer.borderColor = UIColor(named: "SecondaryColor")?.cgColor ?? UIColor.lightGray.cgColor
        imageView.contentMode = .scaleAspectFill
    }
    
    
    private func setupBackgroundCorners() {
        backGround.layer.cornerRadius = 16.0
        backGround.clipsToBounds = true
    }
    

    func configure(with event: LeaguesDetails) {
        nameTeam1.text = event.eventHomeTeam
        nameTeam2.text = event.eventAwayTeam
        matchDate.text = event.eventDate
        matchTime.text = event.eventTime
        
        if let logo1 = event.homeTeamLogo, let url1 = URL(string: logo1) {
            logoTeam1.kf.setImage(with: url1, placeholder: UIImage(named: "placeholder"))
        } else {
            logoTeam1.image = UIImage(named: "placeholder")
        }
        
        if let logo2 = event.awayTeamLogo, let url2 = URL(string: logo2) {
            logoTeam2.kf.setImage(with: url2, placeholder: UIImage(named: "placeholder"))
        } else {
            logoTeam2.image = UIImage(named: "placeholder")
        }
    }

    
    func showPlaceholder() {
        nameTeam1.text = "No Data"
        nameTeam2.text = "No Data"
        matchDate.text = "No Data"
        matchTime.text = "No Data"
        logoTeam1.image = UIImage(named: "placeholder")
        logoTeam2.image = UIImage(named: "placeholder")
        backGround.alpha = 0.5
    }
    
}

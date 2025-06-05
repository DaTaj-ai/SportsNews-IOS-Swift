//
//  LatestEventsCollectionViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 31/05/2025.
//

import UIKit

class LatestEventsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var MatchScore: UILabel!
    @IBOutlet weak var Time: UILabel!
    @IBOutlet weak var NameTeam2: UILabel!
    @IBOutlet weak var NameTeam1: UILabel!
    @IBOutlet weak var LogoTeam2: UIImageView!
    @IBOutlet weak var LogoTeam1: UIImageView!
    
    
    override func awakeFromNib() {
            super.awakeFromNib()
        self.contentView.layer.cornerRadius=16
        self.layer.cornerRadius=16
        
           // styleImageView(LogoTeam1)
           // styleImageView(LogoTeam2)
        }
        
        private func styleImageView(_ imageView: UIImageView) {
            imageView.layer.cornerRadius = imageView.frame.height / 2
            imageView.clipsToBounds = true
            imageView.layer.borderWidth = 1.5
            imageView.layer.borderColor = UIColor(named: "SecondaryColor")?.cgColor ?? UIColor.lightGray.cgColor
            imageView.contentMode = .scaleAspectFill
        }
        
        func configure(with event: LeaguesDetails) {
            NameTeam1.text = event.eventHomeTeam
            NameTeam2.text = event.eventAwayTeam
            Time.text = event.eventDate
            
            let finalResult = event.eventFinalResult!.isEmpty ? "—" : event.eventFinalResult
            MatchScore.text = finalResult
            
            if let logo1 = event.homeTeamLogo, let url1 = URL(string: logo1) {
                LogoTeam1.kf.setImage(with: url1, placeholder: UIImage(named: "placeholder"))
            } else {
                LogoTeam1.image = UIImage(named: "placeholder")
            }
            
            if let logo2 = event.awayTeamLogo, let url2 = URL(string: logo2) {
                LogoTeam2.kf.setImage(with: url2, placeholder: UIImage(named: "placeholder"))
            } else {
                LogoTeam2.image = UIImage(named: "placeholder")
            }
        }
}

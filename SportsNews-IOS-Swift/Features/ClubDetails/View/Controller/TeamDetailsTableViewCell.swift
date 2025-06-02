//
//  TeamDetailsTableViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 01/06/2025.
//

import UIKit

class TeamDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var playerNumber: UILabel!
    
    @IBOutlet weak var playerPosition: UILabel!
    @IBOutlet weak var playerName: UILabel!
    @IBOutlet weak var playerRating: UILabel!
    @IBOutlet weak var playerImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

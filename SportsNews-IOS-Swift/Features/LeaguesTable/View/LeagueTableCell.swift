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
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

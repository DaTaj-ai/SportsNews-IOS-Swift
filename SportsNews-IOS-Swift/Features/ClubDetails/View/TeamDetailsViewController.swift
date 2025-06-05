//
//  TeamDetailsTableViewCell.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 01/06/2025.
//
import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var teamDetailTableView: UITableView!
    @IBOutlet weak var coachName: UILabel!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogo: UIImageView!
    
    var playersList: [Player]?
    var coachesList: [TeamCoach]?
    var teamId: Int?
    var sport: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamDetailTableView.delegate = self
        teamDetailTableView.dataSource = self
        
        fetchTeamDetails()
    }
    
    func fetchTeamDetails() {
        guard let sport = sport, let teamId = teamId else { return }
        
        NetworkService.fetchPlayers(sportType: sport, teamKey: teamId) { [weak self] response in
            guard let self = self, let result = response?.result.first else { return }
            
            DispatchQueue.main.async {
                self.teamName.text = result.teamName
                
                if let logoUrl = URL(string: result.teamLogo.absoluteString) {
                    self.teamLogo.kf.setImage(with: logoUrl, placeholder: UIImage(named: "football"))
                } else {
                    self.teamLogo.image = UIImage(named: "football")
                }
                
                self.coachesList = result.coaches
                self.playersList = result.players
                self.teamDetailTableView.reloadData()
            }
        }
    }
    
    // MARK: - TableView
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return (coachesList?.isEmpty == false) ? coachesList!.count : 1
        } else {
            return (playersList?.isEmpty == false) ? playersList!.count : 1
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Coaches" : "Players"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "team_details", for: indexPath) as? TeamDetailsTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.section == 0 {
            // Coaches section
            if let coaches = coachesList, !coaches.isEmpty {
                let coach = coaches[indexPath.row]
                cell.playerName.text = coach.coachName
                cell.playerImage.image = UIImage(named: "avatar.jpg")
                cell.playerNumber.text = ""
                cell.playerPosition.text = ""
                cell.playerRating.text = ""
            } else {
                cell.playerName.text = "No coaches available"
                cell.playerImage.image = UIImage(named: "placeholder.jpg")
                cell.playerNumber.text = ""
                cell.playerPosition.text = ""
                cell.playerRating.text = ""
            }
        } else {
            // Players section
            if let players = playersList, !players.isEmpty {
                let player = players[indexPath.row]
                cell.playerName.text = player.playerName
                
                if let url = player.playerImage {
                    cell.playerImage.kf.setImage(with: url, placeholder: UIImage(named: "avatar.jpg"))
                } else {
                    cell.playerImage.image = UIImage(named: "avatar.jpg")
                }

                cell.playerNumber.text = player.playerNumber
                cell.playerPosition.text = player.playerType.rawValue
                cell.playerRating.text = player.playerRating
            } else {
                cell.playerName.text = "No players available"
                cell.playerImage.image = UIImage(named: "avatar.jpg")
                cell.playerNumber.text = ""
                cell.playerPosition.text = ""
                cell.playerRating.text = ""
            }
        }
        
        return cell
    }
}

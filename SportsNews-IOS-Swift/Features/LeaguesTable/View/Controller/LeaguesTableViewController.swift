//
//  LeaguesTableViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 29/05/2025.
//
// static func fetchSports(sportType: String, completionHandler: @escaping (LeaguesResponse?) -> Void)
//

import UIKit
import Kingfisher

protocol LeaguesTableViewControllerProtocal {
    func renderTableView(res:LeaguesResponse)
    //func navigateToDetails(with League: league)

}

class LeaguesTableViewController: UITableViewController ,LeaguesTableViewControllerProtocal {
    
    var presenter: LeaguesTablePresenter!
    func renderTableView(res: LeaguesResponse) {
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }}
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName:"LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        setupTableView()
        
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        presenter.getDataFromService()
    }
    private func setupTableView() {
        self.title = "Leagues"
        
        // Register cell
        let nib = UINib(nibName: "LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell") // Use consistent identifier
        
        // Enable self-sizing cells
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80 // Approximate initial height
        
        // Visual tweaks
        tableView.backgroundColor = .systemGroupedBackground
        tableView.separatorStyle = .singleLine
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.leaguesResponse?.result.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as? LeagueTableCell else {
            fatalError("Failed to dequeue LeagueTableCell")
        }
        
        let league = presenter.leaguesResponse?.result[indexPath.row]
        cell.configure(
            with: league?.leagueName ?? "Unknown League",
            image: league?.leagueLogo ?? ""
        )
        
        cell.LeagueImage.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tabed")
        NetworkManager.isInternetAvailable { isConnected in
            if isConnected {
                print("Internet connection is available")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "LeagueEventsView", bundle: nil)
                    
                    guard let leagueVC = storyboard.instantiateViewController(withIdentifier: "LeagueEventsCollectionViewController") as? LeagueEventsCollectionViewController else {
                        fatalError("LeagueEventsCollectionViewController not found in storyboard.")
                    }
                    if let leagueKey = self.presenter.leaguesResponse?.result[indexPath.row].leagueKey {
                        leagueVC.leagueKey = String(leagueKey)
                        print("yes")
                    }
                    else{
                        leagueVC.leagueKey = "210"
                    }
                    leagueVC.sportType = self.presenter.endPoint
                    leagueVC.favoriteLeague = FavoriteLeague(leagueName: self.presenter.leaguesResponse?.result[indexPath.row].leagueName ?? "No name", leagueImageUrl:self.presenter.leaguesResponse?.result[indexPath.row].leagueLogo ?? "No name" , endPoint: self.presenter.endPoint)
                    self.navigationController?.pushViewController(leagueVC, animated: true)
                }
            } else {
                DispatchQueue.main.async {
                    print("No internet connection")
                    NetworkManager.showNoInternetAlert(on: self)
                }
            }
        }
                
    }
}

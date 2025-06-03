//
//  FavoritesViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 30/05/2025.
//

import UIKit

protocol FavoritesViewControllerProtocal {
    func renderData()
    // navigation
}

class FavoritesViewController: UITableViewController, FavoritesViewControllerProtocal {
    
    var presenter: FavoritePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        presenter = FavoritePresenter(vc: self)
        presenter?.addFavoritesLeague()
        presenter?.getFavoritesLeague()
    }
    
    private func setupTableView() {
        self.title = "Favorites"
        
        // Register cell
        let nib = UINib(nibName: "LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "favoritecell")
        
        // TableView appearance
        tableView.separatorStyle = .none
        tableView.backgroundColor = .systemGroupedBackground
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        // Configure header
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 60))
        let headerLabel = UILabel()
        headerLabel.text = "Your Favorite Leagues"
        headerLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        headerLabel.textColor = .label
        headerLabel.textAlignment = .left
        headerLabel.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerLabel)
        
        NSLayoutConstraint.activate([
            headerLabel.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 16),
            headerLabel.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -16),
            headerLabel.centerYAnchor.constraint(equalTo: headerView.centerYAnchor)
        ])
        
        tableView.tableHeaderView = headerView
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.favoritesLeagueList.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80 // Slightly taller for better appearance
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath) as! LeagueTableCell
        
        cell.configure(with: presenter?.favoritesLeagueList[indexPath.row].leagueName ?? "", image: presenter?.favoritesLeagueList[indexPath.row].leagueImageUrl ?? "")
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let storyboard = UIStoryboard(name: "LeaguesTableView", bundle: nil)
        guard let eventsVC = storyboard.instantiateViewController(withIdentifier: "Leagues") as? LeagueEventsCollectionViewController else {
            print("ViewController with identifier 'Leagues' not found")
            return
        }
        
        self.navigationController?.pushViewController(eventsVC, animated: true)
    }
    
    func renderData() {
        tableView.reloadData()
    }
}

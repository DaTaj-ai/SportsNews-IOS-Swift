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

class FavoritesViewController: UITableViewController , FavoritesViewControllerProtocal {

    var presenter:FavoritePresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        presenter = FavoritePresenter(vc: self)
        presenter?.addFavoritesLeague()
        presenter?.getFavoritesLeague()
        
        let nib = UINib(nibName:"LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "favoritecell")
        
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return presenter?.favoritesLeagueList.count ?? 10
        
    }

    func renderData() {
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoritecell", for: indexPath)as! LeagueTableCell
        
        cell.leagueName?.text = presenter?.favoritesLeagueList[indexPath.row].leagueName
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        let url = URL(string: presenter?.favoritesLeagueList[indexPath.row].leagueImageUrl ?? "")
        cell.LeagueImage?.kf.setImage(with:url )
        
        cell.contentView.backgroundColor = .secondarySystemBackground
               return cell
           }
           
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tabed")
        
        let storyboard = UIStoryboard(name: "LeaguesTableView", bundle: nil)
           
           
           guard let favoritesVC = storyboard.instantiateViewController(withIdentifier: "favoritecell") as? LeagueEventsCollectionViewController else {
               print("ViewController with identifier 'Leagues' not found")
               return
           }
           
           
           self.navigationController?.pushViewController(favoritesVC, animated: true)
           

    }
    

}

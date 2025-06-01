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
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        let nib = UINib(nibName:"LeagueTableCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "leagueCell")
        
        
        tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        presenter.getDataFromService()
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
        return presenter.leaguesResponse?.result.count ?? 0
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "leagueCell", for: indexPath) as! LeagueTableCell
        
        cell.leagueName?.text = presenter.leaguesResponse?.result[indexPath.row].leagueName
        cell.textLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        
        let url = URL(string: presenter.leaguesResponse?.result[indexPath.row].leagueLogo ?? "")
        cell.LeagueImage?.kf.setImage(with:url )
        
        cell.contentView.backgroundColor = .secondarySystemBackground
        
        return cell
        
    }
           
    

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Tabed")
        
        let storyboard = UIStoryboard(name: "LeagueEventsView", bundle: nil)
           
           
           guard let leaguesVC = storyboard.instantiateViewController(withIdentifier: "eventsdetailsid") as? LeagueEventsCollectionViewController else {
               print("ViewController with identifier 'Leagues' not found")
               return
           }
           
           
           self.navigationController?.pushViewController(leaguesVC, animated: true)
           

    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

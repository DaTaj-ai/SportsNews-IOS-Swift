//
//  HomeViewController.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 27/05/2025.
//

import UIKit
import Kingfisher
private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController , HomeViewControllerProtocol {
    
    var sportsList: [SportsCategory] = []
    
    func renderTableView(res:[SportsCategory]) {
        
        DispatchQueue.main.async {
            self.sportsList = res
            self.collectionView.reloadData()
        }}
    

    var presenter:HomePresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "sportCell")
        
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        presenter = HomePresenter(vc: self)
        presenter.getDataFromService()
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return sportsList.count
    }
	
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! HomeCollectionViewCell
        
        let url = URL(string: sportsList[indexPath.row].strSport)
        cell.image.kf.setImage(with: url)
        cell.title.text = sportsList[indexPath.row].title
 
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */

}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        return CGSize(width:(collectionView.frame.width * 0.5)-10 , height:150)
//        //(collectionView.frame.width * 0.5)
//    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let size = UIScreen.main.bounds.width * 0.45
        return CGSize(width: size, height: 320)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Tabed")
        let storyboard = UIStoryboard(name: "LeaguesTableView", bundle: nil)
        let mySVC = storyboard.instantiateViewController(withIdentifier: "LeaguesScreen") as! LeaguesTableViewController
    
        mySVC.presenter = LeaguesTablePresenter(vc: mySVC, endPoint:sportsList[indexPath.row].endPoint )
        self.navigationController?.pushViewController(mySVC, animated: true)

    }
}

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
    private let headerTitle = "Sports"

    var sportsList: [SportsCategory] = []
    
    func renderTableView(res:[SportsCategory]) {
        
        DispatchQueue.main.async {
            self.sportsList = res
            self.collectionView.reloadData()
        }}
    

    var presenter:HomePresenter!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        if isMovingToParent || isBeingPresented {
            navigationController?.setNavigationBarHidden(true, animated: animated)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "HomeCollectionViewCell", bundle: nil)
        
        collectionView.register(nib, forCellWithReuseIdentifier: "sportCell")
        collectionView.register(
            HomeHeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: HomeHeaderView.reuseIdentifier
        )
        collectionView.collectionViewLayout = createCompositionalLayout()
                
        presenter = HomePresenter(vc: self)
        presenter.getDataFromService()
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsList.count
    }
	
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! HomeCollectionViewCell
        
        let url = URL(string: sportsList[indexPath.row].strSport)
        cell.image.kf.setImage(with: url)
        cell.title.text = sportsList[indexPath.row].title
 
        return cell
    }

}

extension HomeViewController : UICollectionViewDelegateFlowLayout{
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        NetworkManager.isInternetAvailable { isConnected in
            if isConnected {
                print("Internet connection is available")
                DispatchQueue.main.async {
                    let storyboard = UIStoryboard(name: "LeaguesTableView", bundle: nil)
                    let mySVC = storyboard.instantiateViewController(withIdentifier: "LeaguesScreen") as! LeaguesTableViewController
                
                    mySVC.presenter = LeaguesTablePresenter(vc: mySVC, endPoint:self.sportsList[indexPath.row].endPoint )
                    self.navigationController?.pushViewController(mySVC, animated: true)
                    
                }
            } else {
                DispatchQueue.main.async {
                    print("No internet connection")
                    NetworkManager.showNoInternetAlert(on: self)
                }
                
            }
        }
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        print("Collection view frame: \(collectionView.frame)")
        print("Collection view content size: \(collectionView.contentSize)")
    }
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in

            let itemSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.482),
                heightDimension: .fractionalHeight(1.0))
            
            let item = NSCollectionLayoutItem(layoutSize: itemSize)
            item.contentInsets = .zero
            
            let groupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(320))
            
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: groupSize,
                subitems: [item, item])
            
            group.interItemSpacing = .fixed(12) // Increased from 1 for better visibility
            
            let section = NSCollectionLayoutSection(group: group)
            section.interGroupSpacing = 12
            section.contentInsets = .init(top: 12, leading: 12, bottom: 10, trailing: 12)
            
            
            let headerSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(20))
            
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            
            section.boundarySupplementaryItems = [header]
            
            return section
        }
        
        return layout
    }
     
     override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
         guard kind == UICollectionView.elementKindSectionHeader else {
             return UICollectionReusableView()
         }
         
         let header = collectionView.dequeueReusableSupplementaryView(
             ofKind: kind,
             withReuseIdentifier: HomeHeaderView.reuseIdentifier,
             for: indexPath) as! HomeHeaderView
         
         header.titleLabel.text = headerTitle
         return header
     }
}

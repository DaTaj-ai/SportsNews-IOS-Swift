//
//  HomePresenter.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 31/05/2025.
//

import Foundation

class HomePresenter{
    var HomeViewController: HomeViewControllerProtocol
    let sportsList: [SportsCategory] = [
        SportsCategory(
            strSport: "https://i.pinimg.com/736x/28/ca/2f/28ca2f5993eca9f8d3a0f8dac92eb177.jpg", 
            title: "Football",
            endPoint: "football"
        ),
        SportsCategory(
            strSport: "https://i.pinimg.com/736x/61/4c/c4/614cc42a8f76e1063a9176a1657e9f1a.jpg",
            title: "Tennis",
            endPoint: "tennis"
        ),
        SportsCategory(
            strSport: "https://i.pinimg.com/736x/8a/10/ed/8a10edd858fbc4d9bd489d199dbe16f0.jpg",
            title: "Basketball",
            endPoint: "basketball"
        ),
        SportsCategory(
            strSport: "https://i.pinimg.com/736x/2d/f4/80/2df480e8b673cda2ce982c6325b4b596.jpg",
            title: "Cricket",
            endPoint: "cricket"
        )
    ]
    
    init(vc:HomeViewControllerProtocol){
        self.HomeViewController = vc
    }
    
    
    func getDataFromService(){
            self.HomeViewController.renderTableView(res:	sportsList )
    }
    
//    func didSelectLeague(at index: Int) {
//        let League = products[index]
//        tablelViewController?.navigateToDetails(with: league)
//    }
}

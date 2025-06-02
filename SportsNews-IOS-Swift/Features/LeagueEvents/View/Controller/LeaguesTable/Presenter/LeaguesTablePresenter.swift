//
//  LeaguesTablePresenter.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 31/05/2025.
//

import Foundation

class LeaguesTablePresenter{

    var tablelViewController: LeaguesTableViewControllerProtocal!
    var leaguesResponse: LeaguesResponse?
    var endPoint:String
    
    init(vc:LeaguesTableViewControllerProtocal,endPoint:String){
        self.tablelViewController = vc
        self.endPoint = endPoint
    }
    
    
    func getDataFromService(){
        NetworkService.fetchSports(sportType:endPoint ) {
            res in
            self.leaguesResponse = res
            self.tablelViewController.renderTableView(res: res!)
        }
    }
    
//    func didSelectProduct(at index: Int) {
//        let product = products[index]
//        tablelViewController?.navigateToDetails(with: product)
//    }
}



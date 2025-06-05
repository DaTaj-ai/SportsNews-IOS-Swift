//
//  FavoritePresenter.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 01/06/2025.
//

import Foundation


class FavoritePresenter{
    var vc:FavoritesViewControllerProtocal
    var favoritesLeagueList:[FavoriteLeague] = []
    
    init(vc:FavoritesViewControllerProtocal){
        self.vc = vc
    }
    func getFavoritesLeague(){
        self.favoritesLeagueList = LocalDataSouce.getFavoriteLeague()
        vc.renderData()
    }
    func deleteFavoritesLeague(leagueName: String){
        favoritesLeagueList.removeAll { $0.leagueName == leagueName }
        LocalDataSouce.deleteFromFavorites(leagueName: leagueName)
    }
    
}

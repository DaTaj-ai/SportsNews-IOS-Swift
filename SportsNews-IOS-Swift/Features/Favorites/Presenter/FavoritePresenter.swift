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
    func addFavoritesLeague(){
        LocalDataSouce.addToFavorites(favoriteLeague: FavoriteLeague(leagueName: "this is the name", leagueImageUrl: "how are you ", endPoint: "okay") )
        vc.renderData()
    }
    
}

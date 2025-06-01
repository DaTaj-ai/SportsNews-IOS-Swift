//
//  Favorite.swift
//  SportsNews-IOS-Swift
//
//  Created by mohamed Tajeldin on 01/06/2025.
//

import Foundation

class FavoriteLeague{
    var leagueName : String
    var leagueImageUrl : String
    var endPoint : String
    
    init(leagueName : String , leagueImageUrl : String , endPoint : String ){
        self.leagueImageUrl = leagueImageUrl
        self.leagueName = leagueName
        self.endPoint = endPoint
    }
}

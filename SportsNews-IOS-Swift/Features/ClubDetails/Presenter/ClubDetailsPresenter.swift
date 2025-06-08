//
//  ClubDitailsPresenter.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 31/05/2025.

import Foundation

protocol TeamDetailsView: AnyObject {
    func showTeamDetails(teamDetails: SingleTeam)
}


class ClubDetailsPresenter {
    private weak var view: TeamDetailsView?
    private let networkService: NetworkSProtocol.Type
    private let sport: String
    private let teamId: Int
    
    init(view: TeamDetailsView, networkManager: NetworkSProtocol.Type, sport: String, teamId: Int) {
        self.view = view
        self.networkService = networkManager
        self.sport = sport
        self.teamId = teamId
    }
    
    func getTeamDetails() {
        networkService.fetchPlayers(sportType: sport, teamKey: teamId) { [weak self] response in
            guard let team = response?.result.first else {
                print("Team details not found.")
                return
            }
            self?.view?.showTeamDetails(teamDetails: team)
        }
    }
}

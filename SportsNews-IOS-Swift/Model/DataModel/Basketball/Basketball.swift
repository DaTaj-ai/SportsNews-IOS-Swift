//
//  Basketball.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation

struct BasketBallDetails: Codable {
    let eventKey: Int
    let eventDate, eventTime, eventHomeTeam: String
    let homeTeamKey: Int
    let eventAwayTeam: String
    let awayTeamKey: Int
    let eventFinalResult: String
    let eventQuarter: String?
    let eventStatus, countryName, leagueName: String
    let leagueKey: Int
    let leagueRound: String?
    let leagueSeason, eventLive: String
    let eventHomeTeamLogo, eventAwayTeamLogo: String?
 

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventFinalResult = "event_final_result"
        case eventQuarter = "event_quarter"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
       
    }
}


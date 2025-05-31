//
//  Cricket.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation

struct CricketMatchDetails: Codable {
    let eventKey: Int
    let eventDateStart: String
    let eventDateStop: String
    let eventTime: String?
    let eventHomeTeam: String
    let homeTeamKey: Int?
    let eventAwayTeam: String
    let awayTeamKey: Int?
    let eventServiceHome: String?
    let eventServiceAway: String?
    let eventHomeFinalResult: String?
    let eventAwayFinalResult: String?
    let eventHomeRR: String?
    let eventAwayRR: String?
    let eventStatus: String?
    let eventStatusInfo: String?
    let countryName: String?
    let leagueName: String?
    let leagueKey: Int?
    let leagueRound: String?
    let leagueSeason: String?
    let eventLive: String?
    let eventType: String?
    let eventToss: String?
    let eventManOfMatch: String?
    let eventStadium: String?
    let eventHomeTeamLogo: String?
    let eventAwayTeamLogo: String?
   

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDateStart = "event_date_start"
        case eventDateStop = "event_date_stop"
        case eventTime = "event_time"
        case eventHomeTeam = "event_home_team"
        case homeTeamKey = "home_team_key"
        case eventAwayTeam = "event_away_team"
        case awayTeamKey = "away_team_key"
        case eventServiceHome = "event_service_home"
        case eventServiceAway = "event_service_away"
        case eventHomeFinalResult = "event_home_final_result"
        case eventAwayFinalResult = "event_away_final_result"
        case eventHomeRR = "event_home_rr"
        case eventAwayRR = "event_away_rr"
        case eventStatus = "event_status"
        case eventStatusInfo = "event_status_info"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case leagueRound = "league_round"
        case leagueSeason = "league_season"
        case eventLive = "event_live"
        case eventType = "event_type"
        case eventToss = "event_toss"
        case eventManOfMatch = "event_man_of_match"
        case eventStadium = "event_stadium"
        case eventHomeTeamLogo = "event_home_team_logo"
        case eventAwayTeamLogo = "event_away_team_logo"
       
    }
}

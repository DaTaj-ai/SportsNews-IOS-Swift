//
//  Tennis.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation


struct Tennis: Codable {
    let eventKey: Int
    let eventDate: String
    let eventTime: String
    let eventFirstPlayer: String
    let firstPlayerKey: Int
    let eventSecondPlayer: String
    let secondPlayerKey: Int
    let eventFinalResult: String?
    let eventGameResult: String?
    let eventStatus: String
    let countryName: String
    let leagueName: String
    let leagueKey: Int
    let eventFirstPlayerLogo: String?
    let eventSecondPlayerLogo: String?

    enum CodingKeys: String, CodingKey {
        case eventKey = "event_key"
        case eventDate = "event_date"
        case eventTime = "event_time"
        case eventFirstPlayer = "event_first_player"
        case firstPlayerKey = "first_player_key"
        case eventSecondPlayer = "event_second_player"
        case secondPlayerKey = "second_player_key"
        case eventFinalResult = "event_final_result"
        case eventGameResult = "event_game_result"
        case eventStatus = "event_status"
        case countryName = "country_name"
        case leagueName = "league_name"
        case leagueKey = "league_key"
        case eventFirstPlayerLogo = "event_first_player_logo"
        case eventSecondPlayerLogo = "event_second_player_logo"
    }
}

//
//  Team.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation
struct Team: Codable, Hashable {
    let teamKey: Int
    let teamName: String
    let teamLogo: String?
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(teamKey)
    }
    
    static func == (lhs: Team, rhs: Team) -> Bool {
        return lhs.teamKey == rhs.teamKey
    }
}


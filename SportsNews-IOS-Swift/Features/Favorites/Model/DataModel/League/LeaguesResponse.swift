//
//  LeaguesResponse.swift
//  SportsNews-IOS-Swift
//
//  Created by Abdo Allam  on 29/05/2025.
//

import Foundation
struct LeaguesResponse: Codable {
    let success: Int
    let result: [League]
}

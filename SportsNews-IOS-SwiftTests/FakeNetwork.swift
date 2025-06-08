//
//  FakeNetwork.swift
//  SportsNews-IOS-SwiftTests
//
//  Created by AbdoAllam on 31/05/2025.
//

import Foundation
@testable import SportsNews_IOS_Swift

class FakeNetwork {
    
    var shouldReturnData: Bool

    private let leaguesList: [League] = [
        League(
            leagueKey: 20,
            countryKey: 20,
            leagueName: "fakeData",
            countryName: "fakeData",
            leagueLogo: "fakeData",
            countryLogo: "fakeData"
        )
    ]

    init(shouldReturnData: Bool) {
        self.shouldReturnData = shouldReturnData
    }

    func fetchNetworkData(url: String, completion: @escaping ([League], Error?) -> Void) {
        if shouldReturnData {
            completion(leaguesList, nil)
        } else {
            let error = NSError(domain: "FakeNetwork", code: -1, userInfo: [
                NSLocalizedDescriptionKey: "Simulated network error"
            ])
            completion([], error)
        }
    }
}

//
//  FakeNetwork.swift
//  SportsNews-IOS-SwiftTests
//
//  Created by mohamed Tajeldin on 31/05/2025.
//

import Foundation
@testable import SportsNews_IOS_Swift


class FakeNetwork{
    
    var shouldReturnData:Bool
   
    let leaguesList:[League] = [League(leagueKey: 20, countryKey: 20, leagueName: "fakeData", countryName: "fakeData", leagueLogo: "fakeData", countryLogo: "fakeDAta")]
    
    init(shouldReturnData: Bool ) {
        self.shouldReturnData = shouldReturnData
    }
    
}


extension FakeNetwork{
    
    func fetchNetworkData(url: String, completion: @escaping ([League], Error?) -> Void) {
        
            if shouldReturnData {
                completion(leaguesList, nil)
            } else {
                completion([], NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Network error"]))
            }
        }
}

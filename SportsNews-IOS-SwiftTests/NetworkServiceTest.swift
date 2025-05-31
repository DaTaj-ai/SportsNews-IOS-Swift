//
//  NetworkServiceTest.swift
//  SportsNews-IOS-SwiftTests
//
//  Created by mohamed Tajeldin on 31/05/2025.
//


// static func fetchSports(sportType: String, completionHandler: @escaping (LeaguesResponse?) -> Void)


import XCTest

@testable import SportsNews_IOS_Swift

final class NetworkServiceTest: XCTestCase {

    var networkService:NetworkService?
    
    override func setUpWithError() throws {
        networkService = NetworkService()
    }

    override func tearDownWithError() throws {
    }
    
    
    func testFetchSports(){
        NetworkService.fetchSports(sportType: "FoodBall"){ leaguesResponse in
          
            let exp = self.expectation(description: "Fetch football leagues")

            if(leaguesResponse == nil ){
                XCTFail()
            }
            else {
                print(leaguesResponse?.result.count ?? 20 )
                XCTAssert(leaguesResponse?.result.count ?? -1 > 0 )
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 10)
    }

}

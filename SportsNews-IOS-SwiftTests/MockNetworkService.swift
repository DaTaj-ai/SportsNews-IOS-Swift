//
//  MockNetworkService.swift
//  SportsNews-IOS-SwiftTests
//
//  Created by mohamed Tajeldin on 31/05/2025.
//

import XCTest

final class MockNetworkService: XCTestCase {

    var fakeData = FakeNetwork(shouldReturnData: true)
    
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        
    }
    
    func testGetData()
    {
        let exp = self.expectation(description: "wating")

        fakeData.fetchNetworkData(url: ""){
            leagueData , error in
            
            if let error = error {
               XCTAssertNil(leagueData)
            }
            else{
                XCTAssertNotNil(leagueData)
            }
            exp.fulfill()
        }
        waitForExpectations(timeout: 5)
    }

}



//
//  MockNetworkService.swift
//  SportsNews-IOS-SwiftTests
//
//  Created AbdoAllam on 31/05/2025.
//

import XCTest
@testable import SportsNews_IOS_Swift

final class MockNetworkService: XCTestCase {

    var fakeData: FakeNetwork!

    override func setUpWithError() throws {
        fakeData = FakeNetwork(shouldReturnData: true)
    }

    override func tearDownWithError() throws {
        fakeData = nil
    }

    func testGetData_Success() {
        let exp = expectation(description: "Waiting for data")

        fakeData.fetchNetworkData(url: "") { leagueData, error in
            XCTAssertNil(error, "Expected no error for successful fetch")
            XCTAssertNotNil(leagueData, "Expected league data to be returned")
            XCTAssertEqual(leagueData.count, 1)
            XCTAssertEqual(leagueData.first?.leagueName, "fakeData")
            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
    }

    func testGetData_Failure() {
        let exp = expectation(description: "Waiting for error")

        fakeData = FakeNetwork(shouldReturnData: false)

        fakeData.fetchNetworkData(url: "") { leagueData, error in
            XCTAssertNotNil(error, "Expected an error when shouldReturnData is false")
            XCTAssertEqual(leagueData.count, 0)
            exp.fulfill()
        }

        waitForExpectations(timeout: 2)
    }
}

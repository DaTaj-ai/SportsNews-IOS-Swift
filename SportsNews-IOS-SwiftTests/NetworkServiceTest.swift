//
//  MockNetworkService.swift
//  SportsNews-IOS-SwiftTests
//
//  Created AbdoAllam on 31/05/2025.
//

import XCTest

@testable import SportsNews_IOS_Swift

final class NetworkServiceTest: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testFetchSportsReturnsLeagues() {
        let exp = expectation(description: "Fetch sports leagues")
        
        NetworkService.fetchSports(sportType: "football") { response in
            XCTAssertNotNil(response, "Response should not be nil")
            XCTAssertGreaterThan(response?.result.count ?? 0, 0, "Expected leagues in response")
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeaguesDetailsFootball() {
        let exp = expectation(description: "Fetch football league details")

        NetworkService.fetchLeaguesDetails(sportType: "football", leaguesKey: "207") { response in
            if let decoded = response as? LeaguesDetailsResponse {
                XCTAssertNotNil(decoded.result)
            } else {
                XCTFail("Failed to decode LeaguesDetailsResponse")
            }
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeaguesDetailsCricket() {
        let exp = expectation(description: "Fetch cricket league details")

        NetworkService.fetchLeaguesDetails(sportType: "cricket", leaguesKey: "97") { response in
            XCTAssertTrue(response is CricketResponse)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeaguesDetailsBasketball() {
        let exp = expectation(description: "Fetch basketball league details")

        NetworkService.fetchLeaguesDetails(sportType: "basketball", leaguesKey: "132") { response in
            XCTAssertTrue(response is BasketballResponse)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeaguesDetailsTennis() {
        let exp = expectation(description: "Fetch tennis league details")

        NetworkService.fetchLeaguesDetails(sportType: "tennis", leaguesKey: "245") { response in
            XCTAssertTrue(response is TennisResponse)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchLeaguesDetailsUnsupportedSport() {
        let exp = expectation(description: "Unsupported sportType should return nil")

        NetworkService.fetchLeaguesDetails(sportType: "rugby", leaguesKey: "123") { response in
            XCTAssertNil(response)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchPlayersValidTeam() {
        let exp = expectation(description: "Fetch team players")

        NetworkService.fetchPlayers(sportType: "football", teamKey: 96) { response in
            XCTAssertNotNil(response)
            XCTAssertGreaterThan(response?.result.count ?? 0, 0)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }

    func testFetchTeamsOfLeague() {
        let exp = expectation(description: "Fetch teams from league fixtures")

        NetworkService.fetchTeamsOfLeague(sportType: "football", leagueKey: "207") { teams in
            XCTAssertNotNil(teams)
            XCTAssertGreaterThan(teams?.count ?? 0, 0)
            exp.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
    func testFetchPlayersInvalidTeamKey() {
        NetworkService.fetchPlayers(sportType: "football", teamKey: 0) { response in
            XCTAssertNil(response)
        }
    }
   

}

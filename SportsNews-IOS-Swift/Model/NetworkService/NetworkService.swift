import Foundation

protocol NetworkSProtocol {
    static func fetchSports(sportType: String, completionHandler: @escaping (LeaguesResponse?) -> Void)
    static func fetchLeaguesDetails(sportType: String, leaguesKey: String, completionHandler: @escaping (Any?) -> Void)
    static func fetchPlayers(sportType: String, teamKey: Int, completionHandler: @escaping (TeamPlayersResponse?) -> Void)
}

class NetworkService: NetworkSProtocol {
    
    static let apiKey = "05caff321c59835dc90485da63b38714b1ee3049fbfd7428841422b18c6d84c4"
    static let baseURL = "https://apiv2.allsportsapi.com/"
    
    static func getDateString(offsetByYears years: Int) -> String {
        let calendar = Calendar.current
        let date = calendar.date(byAdding: .year, value: years, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: date)
    }
    
    static func fetchSports(sportType: String, completionHandler: @escaping (LeaguesResponse?) -> Void) {
        var components = URLComponents(string: "\(baseURL)\(sportType)/")!
        components.queryItems = [
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "met", value: "Leagues")
        ]
        
        guard let url = components.url else {
            print("❌ Invalid URL for fetchSports")
            completionHandler(nil)
            return
        }
        

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching sports: \(error)")
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                print("❌ No data returned for sports")
                completionHandler(nil)
                return
            }
            
            do {
                if let errorResponse = try? JSONDecoder().decode(ErrorResponse.self, from: data) {
                    if !errorResponse.error.isEmpty {
                        print("❌ API Error: \(errorResponse.result.first?.msg ?? "Unknown error")")
                        completionHandler(nil)
                        return
                    }
                }
                
                let decoded = try JSONDecoder().decode(LeaguesResponse.self, from: data)
                print("✅ Sports decoded successfully: \(decoded.result.count) leagues")
                completionHandler(decoded)
            } catch {
                print("❌ Decoding error in fetchSports: \(error)")
                completionHandler(nil)
            }
        }.resume()
    }

    
    static func fetchLeaguesDetails(sportType: String, leaguesKey: String, completionHandler: @escaping (Any?) -> Void) {
        let fromDate = getDateString(offsetByYears: -1)
        let toDate = getDateString(offsetByYears: 1)
        
           
        var components = URLComponents(string: "\(baseURL)\(sportType)/")!
        components.queryItems = [
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "from", value: fromDate),
            URLQueryItem(name: "to", value: toDate),
            URLQueryItem(name: "leagueId", value: leaguesKey)
        ]
        
        guard let url = components.url else {
            print("❌ Invalid URL for fetchLeaguesDetails")
            completionHandler(nil)
            return
        }
        
        print("🌐 Fetching league details from: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching league details: \(error)")
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                print("❌ No data returned for league details")
                completionHandler(nil)
                return
            }
            
            do {
                switch sportType {
                case "football":
                    let decoded = try JSONDecoder().decode(LeaguesDetailsResponse.self, from: data)
                    print("✅ Football league details fetched: \(decoded.result?.count ?? 0) matches")
                    completionHandler(decoded)
                case "cricket":
                    let decoded = try JSONDecoder().decode(CricketResponse.self, from: data)
                    print("✅ Cricket league details fetched")
                    completionHandler(decoded)
                case "basketball":
                    let decoded = try JSONDecoder().decode(BasketballResponse.self, from: data)
                    print("✅ Basketball league details fetched")
                    completionHandler(decoded)
                case "tennis":
                    let decoded = try JSONDecoder().decode(TennisResponse.self, from: data)
                    print("✅ Tennis league details fetched")
                    completionHandler(decoded)
                default:
                    print("❌ Unsupported sportType: \(sportType)")
                    completionHandler(nil)
                }
            } catch {
                print("❌ Decoding error in fetchLeaguesDetails: \(error)")
                completionHandler(nil)
            }
        }.resume()
    }
    
    static func fetchPlayers(sportType: String, teamKey: Int, completionHandler: @escaping (TeamPlayersResponse?) -> Void) {
        var components = URLComponents(string: "\(baseURL)\(sportType)/")!
        components.queryItems = [
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "met", value: "Teams"),
            URLQueryItem(name: "teamId", value: "\(teamKey)")
        ]

        guard let url = components.url else {
            print("❌ Invalid URL for fetchPlayers")
            completionHandler(nil)
            return
        }

        print("🌐 Fetching players from: \(url)")

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching players: \(error)")
                completionHandler(nil)
                return
            }

            guard let data = data else {
                print("❌ No data returned for players")
                completionHandler(nil)
                return
            }

            do {
                let decoded = try JSONDecoder().decode(TeamPlayersResponse.self, from: data)
                print("✅ Players decoded: \(decoded.result.count) teams found")
                completionHandler(decoded)
            } catch {
                print("❌ Decoding error in fetchPlayers: \(error)")
                completionHandler(nil)
            }
        }.resume()
    }

    static func fetchTeamsOfLeague(sportType: String, leagueKey: String, completionHandler: @escaping ([Team]?) -> Void) {
        let fromDate = getDateString(offsetByYears: -1)
        let toDate = getDateString(offsetByYears: 0)
        
        var components = URLComponents(string: "\(baseURL)\(sportType)/")!
        components.queryItems = [
            URLQueryItem(name: "APIkey", value: apiKey),
            URLQueryItem(name: "met", value: "Fixtures"),
            URLQueryItem(name: "from", value: fromDate),
            URLQueryItem(name: "to", value: toDate),
            URLQueryItem(name: "leagueId", value: leagueKey)
        ]
        
        guard let url = components.url else {
            print("❌ Invalid URL for fetchTeamsOfLeague")
            completionHandler(nil)
            return
        }
        
        print("🌐 Fetching league fixtures from: \(url)")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("❌ Error fetching fixtures for teams: \(error)")
                completionHandler(nil)
                return
            }
            
            guard let data = data else {
                print("❌ No data returned for fixtures")
                completionHandler(nil)
                return
            }
        
            
            do {
                let decoded = try JSONDecoder().decode(LeaguesDetailsResponse.self, from: data)
                
                guard let fixtures = decoded.result, !fixtures.isEmpty else {
                    print("❌ No fixtures found in response")
                    completionHandler(nil)
                    return
                }
                
                var teamsSet = Set<Team>()
                
                for fixture in fixtures {
                    guard let homeKey = fixture.homeTeamKey,
                          let awayKey = fixture.awayTeamKey,
                          let homeName = fixture.eventHomeTeam,
                          let awayName = fixture.eventAwayTeam else {
                        // تخطي هذه المباراة لأن هناك قيم مفقودة
                        continue
                    }

                    let homeTeam = Team(teamKey: homeKey, teamName: homeName, teamLogo: fixture.homeTeamLogo)
                    let awayTeam = Team(teamKey: awayKey, teamName: awayName, teamLogo: fixture.awayTeamLogo)

                    teamsSet.insert(homeTeam)
                    teamsSet.insert(awayTeam)
                }

                
                let teams = Array(teamsSet)
                print("✅ Extracted \(teams.count) unique teams from fixtures")
                completionHandler(teams)
                
            } catch {
                print("❌ Decoding error in fetchTeamsOfLeague: \(error)")
                completionHandler(nil)
            }
        }.resume()
    }


}

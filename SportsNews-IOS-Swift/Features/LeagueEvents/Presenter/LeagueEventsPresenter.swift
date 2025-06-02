import Foundation

class LeagueDetailsPresenter {
    
    // MARK: - Properties
    weak var view: LeagueDetailsView?
    var upcomingEvents: [LeaguesDetails] = []
    var latestEvents: [LeaguesDetails] = []
    var teams: [Team] = []
    
    // MARK: - Data Loading
    func loadFixtures(sportType: String, leagueId: String) {
        NetworkService.fetchLeaguesDetails(
            sportType: sportType,
            leaguesKey: leagueId
        ) { [weak self] (response: Any?) in
            guard let self = self else { return }
            
            if let footballResponse = response as? LeaguesDetailsResponse,
               let fixtures = footballResponse.result {
                
                // هنا تضيف طباعة بيانات fixtures
                print("Fixtures count: \(fixtures.count)")
                fixtures.forEach { print($0.eventDate ?? "No date") }
                
                let (upcoming, latest) = self.processFixtures(fixtures)
                self.upcomingEvents = upcoming
                self.latestEvents = latest
                
                DispatchQueue.main.async {
                    self.view?.reloadUpcomingEvents()
                    self.view?.reloadLatestEvents()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.showError(message: "Failed to load fixtures")
                }
            }
        }
    }

    
    func loadTeams(sportType: String, leagueId: String) {
        NetworkService.fetchTeamsOfLeague(
            sportType: sportType,
            leagueKey: leagueId
        ) { [weak self] teams in
            guard let self = self else { return }
            
            if let teams = teams {
                self.teams = teams
                DispatchQueue.main.async {
                    self.view?.reloadTeams()
                }
            } else {
                DispatchQueue.main.async {
                    self.view?.showError(message: "Failed to load teams")
                }
            }
        }
    }
    
    // MARK: - Helper Methods
    private func processFixtures(_ fixtures: [LeaguesDetails]) -> (upcoming: [LeaguesDetails], latest: [LeaguesDetails]) {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        
        var upcoming: [LeaguesDetails] = []
        var latest: [LeaguesDetails] = []
        
        for fixture in fixtures {
            let dateString = fixture.eventDate
            guard let dateString = fixture.eventDate,
                  let fixtureDate = formatter.date(from: dateString) else {
                continue
            }


            if fixtureDate > currentDate {
                upcoming.append(fixture)
            } else {
                latest.append(fixture)
            }
        }

            
        // Sort upcoming events chronologically
        upcoming.sort {
            guard let d1 = formatter.date(from: $0.eventDate ?? ""),
                  let d2 = formatter.date(from: $1.eventDate ?? "") else { return false }
            return d1 < d2
        }
        
        // Sort latest events reverse chronologically
        latest.sort {
            guard let d1 = formatter.date(from: $0.eventDate ?? ""),
                  let d2 = formatter.date(from: $1.eventDate ?? "") else { return false }
            return d1 > d2
        }
        
        return (upcoming, latest)
    }
}

// MARK: - View Interface
protocol LeagueDetailsView: AnyObject {
    func reloadUpcomingEvents()
    func reloadLatestEvents()
    func reloadTeams()
    func showError(message: String)
}

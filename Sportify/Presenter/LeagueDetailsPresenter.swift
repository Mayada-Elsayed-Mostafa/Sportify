import Foundation

class LeagueDetailsPresenter {
    weak var vc: LeagueDetailsCollectionViewController?
    var upcomingFixtures: [Fixture]?
    var latestFixtures: [Fixture]?
    var teams: [Team]?
    private var isHeartFilled = false
    private var localSource: LeagueLocalSourceProtocol?
    
    init(vc: LeagueDetailsCollectionViewController?, localSource: LeagueLocalSourceProtocol) {
        self.vc = vc
        self.localSource = localSource
    }
    
    func getFixtures(endPoint: String, leagueId: Int) {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        // From 7 days ago
        let fromDate = Calendar.current.date(byAdding: .day, value: -30, to: currentDate)!
        // To 7 days in the future
        let toDate = Calendar.current.date(byAdding: .day, value: 7, to: currentDate)!
        
        let formattedFromDate = formatter.string(from: fromDate)
        let formattedToDate = formatter.string(from: toDate)
        
        let parameters: [String: Any] = [
            "met": "Fixtures",
            "APIkey": Constants.API_KEY,
            "from": formattedFromDate,
            "to": formattedToDate,
            "leagueId": leagueId
        ]
        
        
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: FixtureResponse?) in
            if let fixtures = response?.result {
                self.upcomingFixtures = fixtures.filter {
                    if let dateStr = $0.eventDate, let fixtureDate = formatter.date(from: dateStr) {
                        return fixtureDate >= currentDate
                    }
                    return false
                }.sorted {
                    guard let d1 = formatter.date(from: $0.eventDate ?? ""),
                          let d2 = formatter.date(from: $1.eventDate ?? "") else { return false }
                    return d1 < d2
                }
                
                self.latestFixtures = fixtures.filter {
                    if let dateStr = $0.eventDate, let fixtureDate = formatter.date(from: dateStr) {
                        return fixtureDate < currentDate
                    }
                    return false
                }.sorted {
                    guard let d1 = formatter.date(from: $0.eventDate ?? ""),
                          let d2 = formatter.date(from: $1.eventDate ?? "") else { return false }
                    return d1 > d2
                }
                
                
                DispatchQueue.main.async {
                    self.vc?.collectionView.reloadData()
                }
            } else {
                print("Failed to fetch fixtures")
            }
        }
    }

    func getTeams(endPoint: String, leagueId: Int) {
        let parameters: [String: Any] = [
            "met": "Teams",
            "APIkey": Constants.API_KEY,
            "leagueId": leagueId
        ]
        
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: TeamResponse?) in
            if let teams = response?.result {
                self.teams = teams
                print("Teams count fetched: \(teams.count)")
                DispatchQueue.main.async {
                    self.vc?.collectionView.reloadSections(IndexSet(integer: 2))
                }
            } else {
                print("Failed to fetch teams")
            }
        }
    }

    
    func getLatest(endPoint: String){
        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": Constants.API_KEY,
            "from": "2025-05-15",
            "to": "2025-05-18"
        ]
        
        SportsApiService.shared.get(endPoint: endPoint, parameters: parameters) { (response: FixtureResponse?) in
            if let fixtures = response?.result {
                debugPrint(fixtures)
            } else {
                print("Failed to fetch leagues")
            }
        }
    }
    
    func toggleHeart() -> Bool{
        isHeartFilled.toggle()
        return isHeartFilled
    }
    
    func saveLeagueToCoreData(league: League) -> Result<Void, Error> {
        return localSource?.insertLeague(league: league) ??  .failure(NSError(domain: "App", code: 0, userInfo: [NSLocalizedDescriptionKey: "Source is unavailable"]))
    }
}

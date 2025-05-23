import Foundation
@testable import Sportify

class FakeSportsApiService {
    var shouldReturnError: Bool

    init(shouldReturnError: Bool) {
        self.shouldReturnError = shouldReturnError
    }

    enum FakeError: Error {
        case responseError
    }

    func loadTeams(completionHandler: @escaping ([Team]?, Error?) -> Void) {
        if shouldReturnError {
            completionHandler(nil, FakeError.responseError)
        } else {
            let team1 = Team(strTeam: "team1", strTeamBadge: "strTeamBadge1", teamKey: 1)
            let team2 = Team(strTeam: "team2", strTeamBadge: "strTeamBadge2", teamKey: 2)
            completionHandler([team1, team2], nil)
        }
    }
}

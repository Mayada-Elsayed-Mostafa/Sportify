import XCTest
@testable import Sportify

final class SportifyTests: XCTestCase {

    var networkManager: SportsApiService!

    override func setUpWithError() throws {
        networkManager = SportsApiService()
    }

    override func tearDownWithError() throws {
        networkManager = nil
    }

    func testFetchLeagues() {
        let expectation = self.expectation(description: "Fetching leagues from API")

        let parameters: [String: Any] = [
            "met": "Leagues",
            "APIkey": "1a8e51d71f90f74c2d3240fb0e5e56ba7138dead785f3e8abcd03a3925888c23"
        ]

        networkManager.get(endPoint: "football", parameters: parameters) { (response: LeaguesResponse?) in
            XCTAssertNotNil(response, "Response should not be nil")
            XCTAssertEqual(response?.success, 1, "API should return success = 1")
            XCTAssertFalse(response?.result.isEmpty ?? true, "Leagues result should not be empty")

            if let firstLeague = response?.result.first {
                print("League name: \(firstLeague.leagueName ?? "N/A")")
            }

            expectation.fulfill()
        }

        waitForExpectations(timeout: 10)
    }
}

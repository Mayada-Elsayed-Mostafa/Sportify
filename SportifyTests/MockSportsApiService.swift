import XCTest
@testable import Sportify

final class MockSportsApiServiceTests: XCTestCase {
    
    var fakeService: FakeSportsApiService!
    
    func testLoadTeamsSuccess() {
        fakeService = FakeSportsApiService(shouldReturnError: false)
        
        let expectation = expectation(description: "Loading teams successfully")
        var receivedTeams: [Team]?
        var receivedError: Error?
        
        fakeService.loadTeams { teams, error in
            receivedTeams = teams
            receivedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        XCTAssertNil(receivedError)
        XCTAssertNotNil(receivedTeams)
        XCTAssertEqual(receivedTeams?.count, 2)
        XCTAssertEqual(receivedTeams?.first?.teamKey, 1)
    }

    func testLoadTeamsFailure() {
        fakeService = FakeSportsApiService(shouldReturnError: true)
        
        let expectation = expectation(description: "Loading teams with error")
        var receivedTeams: [Team]?
        var receivedError: Error?
        
        fakeService.loadTeams { teams, error in
            receivedTeams = teams
            receivedError = error
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0)
        XCTAssertNotNil(receivedError)
        XCTAssertNil(receivedTeams)
    }
}

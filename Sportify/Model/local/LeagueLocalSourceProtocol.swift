//
//  LeagueLocalSourceProtocol.swift
//  Sportify
//
//  Created by Macos on 17/05/2025.
//

import Foundation

protocol LeagueLocalSourceProtocol{
    func insertLeague(league: League) -> Result<Void, Error>
    func deleteLeague(league: League) -> Result<Void, Error>
    func getAllLeagues() -> Result<[League], Error>
}

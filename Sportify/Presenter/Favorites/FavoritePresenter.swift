//
//  FavoritePresenter.swift
//  Sportify
//
//  Created by Macos on 19/05/2025.
//

import Foundation


class FavoritePresenter {
    
    private var vc: FavoritesViewController?

    private var localSource: LeagueLocalSourceProtocol?
    
    init(vc: FavoritesViewController, localSource: LeagueLocalSourceProtocol) {
        self.vc = vc
        self.localSource = localSource
    }
    
    
    func getAllLeagues() -> Result<[League], Error>{
        
        return localSource?.getAllLeagues() ?? .failure(NSError(domain: "App", code: 0, userInfo: [NSLocalizedDescriptionKey: "Source is unavailable"]))
    }
}

//
//  GamesViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 23/10/2024.
//

import Foundation

protocol GamesViewModelling: ObservableObject {
    func mapGameInfo(game: Game) -> GameInfo
}

class GamesViewModel: GamesViewModelling {
    
    func mapGameInfo(game: Game) -> GameInfo {
        return GameInfo(courseName: game.course ?? "",
                        date: game.date,
                        id: game.id,
                        par: game.par,
                        scores: game.scores)
    }
}

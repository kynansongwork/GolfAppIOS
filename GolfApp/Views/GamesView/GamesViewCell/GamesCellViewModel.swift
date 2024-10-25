//
//  GamesCellViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 23/10/2024.
//

import Foundation

protocol GamesCellViewModelling: ObservableObject {
    
    func formatGameDate(_ date: Date?) -> String
    func totalScore(scores: Scores?) -> Int
    func calculateScoreToPar(par: Int32) -> String
    
}

class GamesCellViewModel: GamesCellViewModelling {
    
    @Published var totalScore = 0
    
    func totalScore(scores: Scores?) -> Int {
        guard let scores else { return 0 }
        
        totalScore = scores.scores.reduce(0) { $0 + $1.score }
        
        return totalScore
        
    }
    
    func calculateScoreToPar(par: Int32) -> String {
        if par - Int32(totalScore) > 0 {
            return "-\(par - Int32(totalScore))"
        } else {
            var scoreOverPar = String(par - Int32(totalScore))
            scoreOverPar.removeFirst()
            return "+\(scoreOverPar)"
        }
    }
    
    func formatGameDate(_ date: Date?) -> String {
        
        guard let date else { return "" }
        return date.getFormattedDate(format: .dateAndTime)
    }
}

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
    
}

class GamesCellViewModel: GamesCellViewModelling {
    
    func totalScore(scores: Scores?) -> Int {
        guard let scores else { return 0 }
        
        return scores.scores.reduce(0) { $0 + $1.score }
        
    }
    
    func formatGameDate(_ date: Date?) -> String {
        
        guard let date else { return "" }
        return date.getFormattedDate(format: .dateAndTime)
    }
}

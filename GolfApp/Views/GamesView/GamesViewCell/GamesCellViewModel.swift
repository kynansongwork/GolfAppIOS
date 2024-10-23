//
//  GamesCellViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 23/10/2024.
//

import Foundation

protocol GamesCellViewModelling: ObservableObject {
    
    func formatGameDate(_ date: Date?) -> String
    
}

class GamesCellViewModel: GamesCellViewModelling {
    
    func formatGameDate(_ date: Date?) -> String {
        
        guard let date else { return "" }
        return date.getFormattedDate(format: .dateAndTime)
    }
}

//
//  GameCardScoreViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 23/10/2024.
//

import Foundation
import Combine

protocol GameScoreModeling: ObservableObject {
    var scores: CurrentValueSubject<[Score], Never> { get }
    
    func updateScore(hole: Int, newScore: String?, newPar: String?)
    func getScore(for hole: Int) -> Score?
    func calculateTotalScore() -> Int
}

//Using Claude here for this.
class GameScoreModel: GameScoreModeling {
    
    let scores = CurrentValueSubject<[Score], Never>([])
    private var subscriptions = Set<AnyCancellable>()
    
    func updateScore(hole: Int, newScore: String?, newPar: String?) {
        var updatedScores = scores.value
        
        if let existingIndex = updatedScores.firstIndex(where: { $0.hole == hole }) {
            if let scoreInt = Int(newScore ?? "") {
                updatedScores[existingIndex].score = scoreInt
            }
            if let parInt = Int(newPar ?? "") {
                updatedScores[existingIndex].par = parInt
            }
        } else {
            let score = Score()
            score.hole = hole
            score.score = Int(newScore ?? "") ?? 0
            score.par = Int(newPar ?? "") ?? 0
            updatedScores.append(score)
        }
        
        scores.send(updatedScores)
    }
    
    func getScore(for hole: Int) -> Score? {
        return scores.value.first(where: { $0.hole == hole })
    }
    
    func calculateTotalScore() -> Int {
        scores.value.reduce(0) { $0 + $1.score }
    }
}

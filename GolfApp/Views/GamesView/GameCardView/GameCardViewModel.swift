//
//  GameCardViewModel.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import Combine
import Foundation
import CoreData

protocol GameCardViewModelling: ObservableObject {
    var courses: [CourseModel] { get set }
    var gameData: Game? { get }
    
    func fetchCourses()
    
    func saveData(courseName: String,
                  date: Date,
                  scores: Scores,
                  par: Int32)
    
    func updateData(game: Game,
                    courseName: String,
                    date: Date,
                    scores: Scores,
                    par: Int32)
    
    func deleteData(game: Game)
    
    func getTotalScore(scores: [Score]) -> Int
    
    func mapGameInfo(game: Game) -> GameInfo
}

class GameCardViewModel: GameCardViewModelling {
    
    let manager: DatabaseManager
    
    @Published var courses: [CourseModel] = []
    @Published var selectedCourse: CourseModel?
    
    let gameData: Game?

    let networking: Networking
    
    init(networking: Networking,
         gameData: Game?) {
        self.manager = DatabaseManager.sharedInstance
        self.gameData = gameData
        
        self.networking = networking
        
        self.fetchCourses()
    }
    
    func fetchCourses() {
        let data = self.networking.getMockData()
        
        if let data = data {
            courses.append(contentsOf: data)
        }
    }
    
    //TODO: Move database logic to manager.
    func saveData(courseName: String,
                  date: Date,
                  scores: Scores,
                  par: Int32) {
        
        manager.saveData(
            courseName: courseName,
            date: date,
            scores: scores,
            par: par
        )
    }
    
    //TODO: Assign to button
    func deleteData(game: Game) {
        manager.deleteData(game: game)
    }
    
    func updateData(game: Game,
                    courseName: String,
                    date: Date,
                    scores: Scores,
                    par: Int32) {
        
        guard let id = game.id else { return }
        
        manager.updateGame(id: id,
                           courseName:
                            courseName,
                           date: date,
                           scores: scores,
                           par: par)
    }
    
    func getTotalScore(scores: [Score]) -> Int {
        return scores.reduce(0) { $0 + $1.score }
    }
    
    func mapGameInfo(game: Game) -> GameInfo {
        return GameInfo(courseName: game.course ?? "",
                        date: game.date,
                        id: game.id,
                        par: game.par,
                        scores: game.scores)
    }
}

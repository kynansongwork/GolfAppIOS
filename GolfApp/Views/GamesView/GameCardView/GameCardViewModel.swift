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
    
    func deleteData(game: Game)
    
    func getTotalScore(scores: [Score]) -> Int
    
    func mapGameInfo(game: Game) -> GameInfo
}

class GameCardViewModel: GameCardViewModelling {
    
    let manager: DatabaseManager
    let context: NSManagedObjectContext
    
    @Published var courses: [CourseModel] = []
    @Published var selectedCourse: CourseModel?
    
    let gameData: Game?

    let networking: Networking
    
    init(manager: DatabaseManager,
         networking: Networking,
         context: NSManagedObjectContext,
         gameData: Game?) {
        self.manager = manager
        self.context = context
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
    
    func saveData(courseName: String,
                  date: Date,
                  scores: Scores,
                  par: Int32) {
        
        //TODO: Move this to database manager?
        let game = Game(context: self.context)
        game.id = UUID()
        game.course = courseName
        game.date = date
        game.scores = scores
        game.par = par
        
        do {
            try self.context.save()
        } catch {
            //TODO: Handle error
            print("Unable to save game: \(error.localizedDescription)")
        }
    }
    
    //TODO: Assign to button
    func deleteData(game: Game) {
        self.context.delete(game)
        
        do {
            try self.context.save()
        } catch {
            //TODO: Handle error
            print("Unable to save game: \(error.localizedDescription)")
        }
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

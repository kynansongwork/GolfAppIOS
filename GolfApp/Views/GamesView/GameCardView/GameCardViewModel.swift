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
    
    func fetchCourses()
    
    func saveData(courseName: String,
                  date: Date,
                  scores: Scores)
}

class GameCardViewModel: GameCardViewModelling {
    
    let manager: DatabaseManager
    let context: NSManagedObjectContext
    
    @Published var courses: [CourseModel] = []
    @Published var selectedCourse: CourseModel?

    let networking: Networking
    
    init(manager: DatabaseManager,
         context: NSManagedObjectContext) {
        self.manager = manager
        self.context = context
        self.networking = NetworkingManager(url: nil)
        
        self.fetchCourses()
    }
    
    func saveData(courseName: String,
                  date: Date,
                  scores: Scores) {
        let game = Game(context: self.context)
        game.id = UUID()
        game.course = courseName
        game.date = date
        game.scores = scores
        
        do {
            try self.context.save()
        } catch {
            //TODO: Handle error
            print("Unable to save game: \(error.localizedDescription)")
        }
    }
    
    func fetchCourses() {
        let data = self.networking.getMockData()
        
        if let data = data {
            courses.append(contentsOf: data)
        }
    }
}

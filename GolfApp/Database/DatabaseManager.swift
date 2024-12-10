//
//  DatabaseManager.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import CoreData
import Foundation

// Main data manager to handle the Games items
class DatabaseManager: NSObject, ObservableObject {
    
    static let sharedInstance = DatabaseManager()
    var context: NSManagedObjectContext {
            return container.viewContext
        }
    
    @Published var games: [Game] = []
    
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Games")
    let options = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
    ]
    
    override init() {
        super.init()
        container.loadPersistentStores { description, error in
            
            description.setOption(true as NSNumber, forKey: NSMigratePersistentStoresAutomaticallyOption)
            description.setOption(true as NSNumber, forKey: NSInferMappingModelAutomaticallyOption)
            
            if let error {
                print("CoreData load failure: \(error.localizedDescription)")
            }
        }
    }

    func saveData(courseName: String,
                  date: Date,
                  scores: Scores,
                  par: Int32) {
        
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
    
    func deleteData(game: Game) {
        self.context.delete(game)
        
        do {
            try self.context.save()
        } catch {
            //TODO: Handle error
            print("Unable to save game: \(error.localizedDescription)")
        }
    }
    
    func updateGame(id: UUID,
                    courseName: String? = nil,
                    date: Date? = nil,
                    scores: Scores? = nil,
                    par: Int32? = nil) {

        let fetchRequest: NSFetchRequest<Game> = Game.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id as CVarArg)
        
        do {
            let results = try context.fetch(fetchRequest)
            
            if let currentGame = results.first {

                if let courseName = courseName {
                    currentGame.course = courseName
                }
                
                if let date = date {
                    currentGame.date = date
                }
                
                if let scores = scores {
                    currentGame.scores = scores
                }
                
                if let par = par {
                    currentGame.par = par
                }
                
                try context.save()
            } else {
                print("No game found with the \(id)")
            }
        } catch {
            print("Error updating game: \(error.localizedDescription)")
        }
    }
}


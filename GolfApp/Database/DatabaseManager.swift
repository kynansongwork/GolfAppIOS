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
    
    @Published var games: [Game] = []
    
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Games")
    let options = [
        NSMigratePersistentStoresAutomaticallyOption: true,
        NSInferMappingModelAutomaticallyOption: true
    ]
    
    // Default init method. Load the Core Data container
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
}


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
    
    // Add the Core Data container with the model name
    let container: NSPersistentContainer = NSPersistentContainer(name: "Games")
    
    // Default init method. Load the Core Data container
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}


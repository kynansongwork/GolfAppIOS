//
//  GolfAppApp.swift
//  GolfApp
//
//  Created by Kynan Song on 02/10/2024.
//

import SwiftUI

@main
struct GolfAppApp: App {
    
    @StateObject private var manager = DatabaseManager.sharedInstance
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(manager)
                .environment(\.managedObjectContext, manager.context)
        }
    }
}

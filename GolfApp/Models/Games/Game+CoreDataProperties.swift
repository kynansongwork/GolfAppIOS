//
//  Game+CoreDataProperties.swift
//  GolfApp
//
//  Created by Kynan Song on 21/10/2024.
//

import CoreData


extension Game {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Game> {
        return NSFetchRequest<Game>(entityName: "Game")
    }

    @NSManaged public var course: String?
    @NSManaged public var date: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var scores: Scores?
    @NSManaged public var par: Int32

}

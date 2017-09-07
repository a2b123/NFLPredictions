//
//  Team+CoreDataClass.swift
//  
//
//  Created by Amar Bhatia on 8/31/17.
//
//

import Foundation
import CoreData

@objc(Team)
public class Team: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Team> {
        return NSFetchRequest<Team>(entityName: "Team")
    }
    
    @NSManaged public var name: String?
    @NSManaged public var id: Int64
    @NSManaged public var imageName: String?

}

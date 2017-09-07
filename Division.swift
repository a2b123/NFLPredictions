//
//  Division+CoreDataClass.swift
//  
//
//  Created by Amar Bhatia on 8/31/17.
//
//

import Foundation
import CoreData

@objc(Division)
public class Division: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<Division> {
        return NSFetchRequest<Division>(entityName: "Division")
    }
    
    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var teams: NSOrderedSet?
    
    
}

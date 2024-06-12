//
//  AustronautManagedObject+CoreDataProperties.swift
//  
//
//  Created by Serhii on 07.05.2024.
//
//

import Foundation
import CoreData


extension AustronautManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AustronautManagedObject> {
        return NSFetchRequest<AustronautManagedObject>(entityName: "AustronautManagedObject")
    }

    @NSManaged public var name: String?
    @NSManaged public var craft: String?
    @NSManaged public var personImageUrl: String?
    @NSManaged public var personBio: String?

}

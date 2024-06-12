//
//  DatabaseService.swift
//  PeopleInSpace
//
//  Created by Serhii on 07.05.2024.
//

import Foundation
import CoreData

class DatabaseService {
    
    static let shared = DatabaseService()
    
    lazy var dbContainer: NSPersistentContainer = {
    
    let container = NSPersistentContainer(name: "PeopleInSpace")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    lazy var context = dbContainer.viewContext
    
    func saveAustronauts(austronauts: [Austronaut]) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AustronautManagedObject")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try dbContainer.persistentStoreCoordinator.execute(deleteRequest, with: context)
        } catch let error as NSError {
            
        }
        // add new data
        for austronaut in austronauts {
            let dbAustronaut = AustronautManagedObject(context: context)
            dbAustronaut.name = austronaut.name
            dbAustronaut.personBio = austronaut.personBio
            dbAustronaut.personImageUrl = austronaut.personImageUrl
            dbAustronaut.craft = austronaut.craft
        }
        saveContext()
    }
    
    func saveContext() {
        let context = dbContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
            }
        }
    }
    
    func readAustronauts() -> [Austronaut] {
        var austronauts = [Austronaut]()
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "AustronautManagedObject")
        do {
            let dbAustronauts = try context.fetch(fetchRequest)
            for dbAustronaut in dbAustronauts {
                let dbAustronautValue = dbAustronaut as! AustronautManagedObject
                let austronaut = Austronaut(
                    name: dbAustronautValue.value(forKey: "name") as! String,
                    craft: dbAustronautValue.value(forKey: "craft") as! String,
                    personImageUrl: dbAustronautValue.value(forKey: "personImageUrl") as! String,
                    personBio: dbAustronautValue.value(forKey: "personBio") as! String
                )
                austronauts.append(austronaut)
            }
        } catch {
            
        }
        return austronauts
    }
    
}

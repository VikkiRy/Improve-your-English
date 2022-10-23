//
//  CoreDataManager.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 03/10/2022.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Improve_your_English")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("Unable to load persistent stores: \(error)")
            }
        }
        return container
    }()
    
    lazy var context: NSManagedObjectContext = persistentContainer.viewContext
    
    private init() {}
    
    func save() {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addPredicates<Entity>(for request: NSFetchRequest<Entity>, _ predicate: [NSPredicate]) -> NSFetchRequest<Entity> {
        predicate.forEach { predicate in
            request.predicate = predicate
        }
        
        return request
    }
}

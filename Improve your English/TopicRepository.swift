//
//  TopicRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import Foundation
import CoreData

struct TopicRepository {
    
    static func topics(context: NSManagedObjectContext) -> [Topic] {
        var topics: [Topic] = []
        
        do {
            topics = try context.fetch(Topic.fetchRequest())
        } catch {
            print(error)
        }
        return topics
    }
    
    static func save(context: NSManagedObjectContext) {
        do {
            try context.save()
        } catch {
            print(error)
        }
    }
}

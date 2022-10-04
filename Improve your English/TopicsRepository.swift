//
//  TopicRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import Foundation

class TopicRepository {
    static var container = CoreDataManager()
    
    static var topics: [Topic] = {
        var topics: [Topic] = []
        do {
            topics = try container.context.fetch(Topic.fetchRequest())
        } catch {
            print(error)
        }
        return topics
    }()
    
    static func words(for topic: Topic) -> [Word]? {
        if let words = topic.words {
            return words.allObjects as? [Word]
        }
        return nil
    }
}

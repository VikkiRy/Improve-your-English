//
//  DataSource.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/09/2022.
//

import Foundation
import CoreData

struct DefaultTopics {
    var context: NSManagedObjectContext
    
    init(context: () -> NSManagedObjectContext) {
        self.context = context()
    }
    
    func createDefaultTopics() {
        let topicsTitle = fetchTopicsTitle()
        
        for topic in defaultTopics {
            
            if topicsTitle.contains(topic.key) {
                continue
            }
            
            let newTopic = Topic(context: context)
            newTopic.title = topic.key
            
            topic.value.forEach { word in
                let newWord = Word(context: context)
                newWord.title = word
                newWord.topic = newTopic
            }
            
            do {
                try self.context.save()
            } catch {
                print(error)
            }
        }
    }
    
    private func fetchTopicsTitle() -> [String] {
        let topics = coreDataTopics()
        
        guard !topics.isEmpty else {
            return []
        }
        
        var topicsTitle: [String] = []
        
        topics.forEach { topic in
            if let topicTitle = topic.title {
                topicsTitle.append(topicTitle)
            }
        }
        return topicsTitle
    }
    
    private func coreDataTopics() -> [Topic] {
        do {
            let topics = try context.fetch(Topic.fetchRequest())
            return topics
        } catch {
            print(error)
        }
        return []
    }
}

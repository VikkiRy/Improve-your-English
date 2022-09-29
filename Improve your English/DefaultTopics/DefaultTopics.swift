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
        let topics = TopicRepository.topics(context: context)
        
        let topicsTitle = topics.map { topic in
            return topic.title!
        }
        
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
            
            TopicRepository.save(context: context)
        }
    }
}

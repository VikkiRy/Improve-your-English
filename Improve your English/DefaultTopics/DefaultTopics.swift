//
//  DataSource.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/09/2022.
//

import Foundation
import CoreData

struct DefaultTopics {
    var container = CoreDataManager()
    
    init() {
        let topics = TopicRepository.topics
        
        if topics.isEmpty {
            createDefaultTopics()
        }
    }
    
    func createDefaultTopics() {
        for topic in defaultTopics {
            let newTopic = Topic(context: container.context)
            newTopic.title = topic.key
                
            topic.value.forEach { word in
                let newWord = Word(context: container.context)
                newWord.title = word
                newWord.topic = newTopic
            }
            container.save()
        }
    }
}

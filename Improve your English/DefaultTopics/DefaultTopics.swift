//
//  DataSource.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/09/2022.
//

import Foundation
import CoreData

struct DefaultTopics {
    
    static func createDefaultTopics() {
        let topics = TopicRepository.shared.topics()
        
        if topics.isEmpty {
            defaultTopics.forEach { topic in
                let newTopic = TopicRepository.shared.createTopic(topicTitle: topic.key, isUserTopic: false)
                
                topic.value.forEach { word in
                    TopicRepository.shared.createWord(wordTitle: word, for: newTopic)
                }
            }
        }
    }
}

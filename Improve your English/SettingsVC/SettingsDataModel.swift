//
//  SettingsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 18/10/2022.
//

import Foundation

struct SettingsDataModel {
    var topics: [Topic] = []
    var selectedTopics: [Topic] = []
    
    init() {
        topics = allTopics()
        selectedTopics = userSelectedTopics()
    }
    
    private func allTopics() -> [Topic] {
        let topics = TopicRepository.shared.topics()
        
        return topics.sorted { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        }
    }
    
    private func userSelectedTopics() -> [Topic] {
        let topics = topics.filter { topic in
            topic.isSelected
        }
        
        return topics.sorted { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        }
    }
    
    mutating func appendTopic(topicTitle: String) {
        let _ = TopicRepository.shared.addTopic(topicTitle: topicTitle)
        self.topics = TopicRepository.shared.topics().sorted(by: { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        })
    }
}

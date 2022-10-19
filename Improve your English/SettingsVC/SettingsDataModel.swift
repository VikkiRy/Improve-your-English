//
//  SettingsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 18/10/2022.
//

import Foundation

struct SettingsDataModel {
    var topics: [Topic] = TopicRepository.shared.topics().sorted { firstTopic, secondTopic in
        firstTopic.title.lowercased() < secondTopic.title.lowercased()
    }
    
    init() { }
    
    mutating func appendTopic(topicTitle: String) {
        let _ = TopicRepository.shared.addTopic(topicTitle: topicTitle)
        topics = TopicRepository.shared.topics().sorted(by: { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        })
    }
}

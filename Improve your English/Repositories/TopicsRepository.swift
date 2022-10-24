//
//  TopicRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import Foundation

final class TopicRepository {
    static let shared = TopicRepository()
    private let dataManager = CoreDataManager.shared
    
    private init() {
        addDefaultTopics()
    }
    
    func topics() -> [Topic] {
        do {
            return try CoreDataManager.shared.context.fetch(Topic.fetchRequest())
        } catch {
            print(error)
        }
        
        return []
    }
    
    func addTopic(topicTitle: String, isUserTopic: Bool = true) -> Topic {
        let newTpoic = Topic(context: dataManager.context)
        newTpoic.title = topicTitle
        newTpoic.isUserTopic = isUserTopic
        
        dataManager.save()
        
        return newTpoic
    }
    
    func selectedTopics() -> [Topic] {
        let topics = topics()
        let selectedTopics = topics.filter { $0.isSelected }
        
        return selectedTopics
    }
    
    func unselectedTopics() -> [Topic] {
        let topics = topics()
        let unselectedTopics = topics.filter { $0.isSelected }
        
        return unselectedTopics
    }

    private func addDefaultTopics() {
        let topics = topics()
        
        guard topics.isEmpty else {
            return
        }
        
        let defaultTopics = [sports, foods, hobbys]
        
        defaultTopics.forEach { topic in
            let newTopic = addTopic(topicTitle: topic.title, isUserTopic: false)
                
            topic.words.forEach { word in
                WordsRepository.shared.addWord(engTitle: word.wordENG, rusTitle: word.wordRUS, for: newTopic)
            }
        }
    }
}

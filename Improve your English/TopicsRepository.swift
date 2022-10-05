//
//  TopicRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import Foundation

class TopicRepository {
    static let shared = TopicRepository()
    
    private let dataManager = CoreDataManager.shared
    
    private init() {}
    
    func topics() -> [Topic] {
        var topics: [Topic] = []
        do {
            topics = try CoreDataManager.shared.context.fetch(Topic.fetchRequest())
        } catch {
            print(error)
        }
        return topics
    }
    
    func words(for topic: Topic) -> [Word]? {
        if let words = topic.words {
            return words.allObjects as? [Word]
        }
        return nil
    }
    
    func createTopic(topicTitle: String, isUserTopic: Bool = true) -> Topic {
        let newTpoic = Topic(context: dataManager.context)
        newTpoic.title = topicTitle
        newTpoic.isUserTopic = true
        
        dataManager.save()
        
        return newTpoic
    }
    
    func createWord(wordTitle: String, for topic: Topic) {
        let newWord = Word(context: dataManager.context)
        newWord.title = wordTitle
        newWord.topic = topic
        
        dataManager.save()
    }
}
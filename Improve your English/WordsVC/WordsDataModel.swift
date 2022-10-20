//
//  WordsVCDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 17/10/2022.
//

import Foundation

struct WordsDataModel {
    let topic: Topic
    var topicWords: [Word] = []
    
    init(topic: Topic) {
        self.topic = topic
        updateTopicWords()
    }
    
    func isShouldPerformSegue() -> Bool {
        topic.isUserTopic
    }
    
    mutating func updateTopicWords() {
        if let allWords = topic.words,
           let words = allWords.allObjects as? [Word] {
            topicWords = words.sorted(by: { firstWord, secondWord in
                firstWord.engTitle.lowercased() < secondWord.engTitle.lowercased()
            })
        }
    }
}

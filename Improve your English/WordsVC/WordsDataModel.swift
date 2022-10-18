//
//  WordsVCDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 17/10/2022.
//

import Foundation

struct WordsDataModel {
    let topic: Topic
    var topicWords: [Word] {
        var result: [Word] = []
        
        if let topicWords = topic.words,
           let words = topicWords.allObjects as? [Word] {
            result = words.sorted(by: { firstWord, secondWord in
                firstWord.engTitle!.lowercased() < secondWord.engTitle!.lowercased()
            })
        }
        
        return result
    }
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    func isShouldPerformSegue() -> Bool {
        topic.isUserTopic
    }
}

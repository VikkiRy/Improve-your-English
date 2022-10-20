//
//  WordsRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 13/10/2022.
//

import Foundation

final class WordsRepository {
    static let shared = WordsRepository()
    
    private init() { }
    
    func addWord(engTitle: String, rusTitle: String, for topic: Topic) {
        let newWord = Word(context: CoreDataManager.shared.context)
        newWord.engTitle = engTitle
        newWord.rusTitle = rusTitle
        newWord.topic = topic
        
        CoreDataManager.shared.save()
    }

    func wordsForLearning() -> [Word] {
        let selectedTopics = TopicRepository.shared.selectedTopics()
        let topicsWords = words(from: selectedTopics)
        
        guard !topicsWords.isEmpty else {
            let topicsForLearning = TopicRepository.shared.topicsForLearning()
            
            if topicsForLearning.isEmpty {
                print("Поздравляем. Для подолжения вы модете добавить слова")
            } else {
                print("выбрать еще тему")
            }
            
            return []
        }
        
        let requiredWordsCount = UserDefaults.standard.value(forKey: UserSettingKeys.numberOfWords.rawValue) as! Int
        
        if topicsWords.count == requiredWordsCount || topicsWords.count < requiredWordsCount {
            return topicsWords
        } else {
            return randomWords(from: topicsWords, wordsCount: requiredWordsCount)
        }
    }
    
    private func words(from topics: [Topic]) -> [Word] {
        var words: [Word] = []
        
        topics.forEach { topic in
            if let topicWords = topic.words {
                let allWords = topicWords.allObjects as! [Word]
                words.append(contentsOf: allWords)
            }
        }
        
        return words
    }
    
    private func randomWords(from words: [Word], wordsCount: Int) -> [Word] {
        var randomWords: [Word] = []
        
        (1...wordsCount).forEach { _ in
            var randomWord = words.randomElement()!
            
            while randomWords.contains(randomWord) {
                randomWord = words.randomElement()!
            }
            
            randomWords.append(randomWord)
        }
        
        return randomWords
    }
}

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
    
    func words() -> [Word] {
        var words: [Word] = []
        
        let predicate = NSPredicate(format: "isTrainingCompleted == %@", false)
        let request = CoreDataManager.shared.addPredicates(for: Word.fetchRequest(), [predicate])
        
        do {
            words = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        return words
    }

    func learningWords(_ wordsCount: Int) -> [Word] {
        var topicsWords = selectedTopicsWords()
        
        guard !topicsWords.isEmpty else { return [] }
        
        let learningWords = LearningDataRepository.shared.learningWords()
        
        learningWords.forEach { word in
            if topicsWords.contains(word) {
                topicsWords.removeAll { topicWord in
                    topicWord == word
                }
            }
        }
        
        let requiredWordsCount = wordsCount
        
        if topicsWords.count == requiredWordsCount || topicsWords.count < requiredWordsCount {
            return topicsWords
        } else {
            return randomWords(from: topicsWords, wordsCount: requiredWordsCount)
        }
    }
    
    private func selectedTopicsWords() -> [Word] {
        var words: [Word] = []
        let selectedTopics = TopicRepository.shared.selectedTopics()
        
        for topic in selectedTopics {
            
            guard let topicWords = topic.words,
                  let allWords = topicWords.allObjects as? [Word],
                  !allWords.isEmpty else { continue }
            
            let learningWords = allWords.filter({ word in
                !word.isTrainingCompleted
            })
            
            words.append(contentsOf: learningWords)
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

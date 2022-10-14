//
//  WordsRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 13/10/2022.
//

import Foundation

final class WordsRepository {
    static let shared = WordsRepository()
    
    func addWord(engTitle: String, rusTitle: String, for topic: Topic) {
        let newWord = Word(context: CoreDataManager.shared.context)
        newWord.engTitle = engTitle
        newWord.rusTitle = rusTitle
        newWord.topic = topic
        
        CoreDataManager.shared.save()
    }
    
    func learningWords() -> [Word] {
        let requiredWordsCount = UserDefaults.standard.value(forKey: UserSettingKeys.numberOfWords.rawValue) as! Int
        let learningTopics = TopicRepository.shared.topicsForLearning()
        var topicsWords: [Word] = []
        
        learningTopics.forEach { topic in
            if let words = topic.words {
                let allWords = words.allObjects as! [Word]
                topicsWords.append(contentsOf: allWords)
            }
            //todo else if there are no words
        }
        
        guard topicsWords.count >= requiredWordsCount else {
            return []
            //todo return error?
        }
        
        switch topicsWords.count {
            
        case requiredWordsCount:
            topicsWords.forEach { word in
                changeLearningState(for: word)
            }
            return topicsWords
            
        default:
            let words = randomWords(from: topicsWords, wordsCount: requiredWordsCount)
            words.forEach { word in
                changeLearningState(for: word)
            }
            return words
        }
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
    
    //todo
    func changeLearningState(for word: Word) {
        switch word.isLearning {
        case nil:
            word.isLearning = true
        case true:
            word.isLearning = false
        default:
            word.isLearning = true
        }
        
        CoreDataManager.shared.save()
    }
    
}

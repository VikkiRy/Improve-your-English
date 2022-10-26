//
//  LearningWordsRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 20/10/2022.
//

import Foundation
import CoreData

enum DataError: Error {
    case shouldAddNewData
}

final class LearningDataRepository {
    static let shared = LearningDataRepository()
    
    private init() { }
    
    func fetchCurrentDayLearningData() -> [LearningData] {
        let currentDate = Date().currentDay as NSDate
        
        let request = LearningData.fetchRequest()
        let predicate = NSPredicate(format: "isLearned == %d AND createdAt >= %@", false, currentDate as CVarArg)
        request.predicate = predicate
        
        do {
            return try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
    
    func learningWords() -> [Word] {
        let request = LearningData.fetchRequest()
        let predicate = NSPredicate(format: "isLearned == %d", true)
        request.predicate = predicate
        
        var fetchedData: [LearningData] = []
        
        do {
            fetchedData = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        return fetchedData.map { $0.word }
    }
    
    func addCurrentDayData(_ wordsCount: Int = UserDefaults.standard.value(forKey: UserSettingKeys.numberOfWords.rawValue) as! Int) throws {
        let words = WordsRepository.shared.learningWords(wordsCount)
        
        guard !words.isEmpty else {
            throw DataError.shouldAddNewData
        }
        
        words.forEach { word in
            let newLearningData = LearningData(context: CoreDataManager.shared.context)
            newLearningData.word = word
            newLearningData.createdAt = Date().currentDay
        }

        CoreDataManager.shared.save()
    }
    
    func currentDayTrainingData() -> [LearningData] {
        let predicates = [NSPredicate(format: "isLearned == true")]
        let request = CoreDataManager.shared.addPredicates(for: LearningData.fetchRequest(), predicates)
        
        var fetchData: [LearningData] = []
        
        do {
            fetchData = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }

        let data = fetchData.filter { !$0.word.isTrainingCompleted }

        return Array(Set(data))
    }
}


//
//  LearningWordsRepository.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 20/10/2022.
//

import Foundation
import CoreData

final class LearningDataRepository {
    static let shared = LearningDataRepository()
    
    private init() { }
    
    func currentDayData() -> [LearningData] {
        var data = fetchCurrentDayData()
        
        if data.isEmpty {
            addCurrentDayData()
            data = fetchCurrentDayData()
        }
        
        return data
    }
    
    func currentDayTrainingData() -> [LearningData] {
        let currentDate = Date().currentDay as NSDate
            
        let request = LearningData.fetchRequest()
        request.predicate = NSPredicate(format: "createdAt == %@", currentDate)
        request.predicate = NSPredicate(format: "isLearned == true")
        
        var data: [LearningData] = []
        
        do {
            data = try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        return data
    }
    
    private func fetchCurrentDayData() -> [LearningData] {
        let currentDate = Date().currentDay as NSDate
            
        let request = LearningData.fetchRequest()
        request.predicate = NSPredicate(format: "createdAt == %@", currentDate)
        
        do {
            return try CoreDataManager.shared.context.fetch(request)
        } catch {
            print(error)
        }
        
        return []
    }
 
    private func addCurrentDayData() {
        let words = WordsRepository.shared.wordsForLearning()
        
        words.forEach { word in
            let newLearningData = LearningData(context: CoreDataManager.shared.context)
            newLearningData.word = word
            newLearningData.createdAt = Date().currentDay
        }

        CoreDataManager.shared.save()
    }
}


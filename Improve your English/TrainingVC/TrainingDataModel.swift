//
//  TrainingDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 22/10/2022.
//

import Foundation

struct TrainingDataModel {
    var trainingData: [LearningData] = LearningDataRepository.shared.currentDayTrainingData()
    var index: Int = 0
    var countOfFinishedTrainingWord: Int = 0
    var guessedWord: Word {
        trainingData[index].word
    }
    
    init(trainigData: [LearningData]) {
        self.trainingData = trainigData
    }
    
    func randomTitles() -> [String] {
        var titles: [String] = []
        
        trainingData.forEach { data in
            titles.append(data.word.engTitle)
        }
        
        titles.remove(at: index)
        titles.shuffle()
        
        return titles.dropLast(titles.count - 3)
    }
    
    func changeTrainingWordState() {
        trainingData[index].word.isTrainingCompleted = true
    }
    
    func isCorrectWord(userWord: String) -> Bool {
        return userWord.lowercased() == trainingData[index].word.engTitle.lowercased()
    }
    
    func saveResults() {
        if countOfFinishedTrainingWord > 0 {
            StatisticRepository.shared.addData(wordsCount: countOfFinishedTrainingWord)
        }
        
        CoreDataManager.shared.save()
    }
}

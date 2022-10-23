//
//  TrainingDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 22/10/2022.
//

import Foundation

struct TrainingDataModel {
    let trainingData: [LearningData] = LearningDataRepository.shared.currentDayTrainingData()
    var index: Int = 0
    var guessedWord: Word {
        trainingData[index].word
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
}

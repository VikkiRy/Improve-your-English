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
    
    func randomData() -> [LearningData] {
        var data = trainingData
        data.remove(at: index)
        data.shuffle()
        
        return data.dropLast(data.count - 3)
    }
}

//
//  MainVCDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import Foundation

struct MainVCDataModel {
    let isWordsExist = WordsRepository.shared.words().isEmpty
    
    var learningData: [LearningData] {
        LearningDataRepository.shared.fetchCurrentDayLearningData()
    }
    var trainingData: [LearningData] {
        LearningDataRepository.shared.currentDayTrainingData()
    }
}

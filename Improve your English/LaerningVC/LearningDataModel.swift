//
//  LearningDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 20/10/2022.
//

import Foundation

struct LearningDataModel {
    var data: [LearningData] = LearningDataRepository.shared.currentDayData()
    var learningWordPosition: Int = 0
    
    var currentWord: Word {
        data[learningWordPosition].word
    }
    
    func changeLearningState() {
        data.forEach { $0.isLearned = true }
        CoreDataManager.shared.save()
    }
}

//
//  MainVCDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import Foundation

struct MainVCDataModel {
    let trainingData = LearningDataRepository.shared.currentDayTrainingData()
}

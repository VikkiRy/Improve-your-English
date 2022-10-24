//
//  UserDefaultsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//

import Foundation

struct UserDefaultsDataModel {
    let topics: [Topic]
    
    init() {
        topics = TopicRepository.shared.topics()
    }
    
    func changeTopicSelectedState(at index: Int) {
        topics[index].isSelected = !topics[index].isSelected
    }
    
    func selectedTopics() -> [Topic] {
        topics.filter { $0.isSelected }
    }
    
    func saveUserSettings(wordsCount: Int) {
        CoreDataManager.shared.save()
        
        UserDefaults.standard.setValuesForKeys([
            UserSettingKeys.isShowMainVC.rawValue: true,
            UserSettingKeys.numberOfWords.rawValue: wordsCount
        ])
    }
}

//
//  UserDefaultsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//

import Foundation
import UIKit

struct UserDefaultsDataModel {
    let topics: [Topic]
    let topicsCount: Int
    
    init() {
        topics = TopicRepository.shared.topics()
        topicsCount = topics.count
    }
    
    func topicTitle(at index: Int) -> String {
        topics[index].title
    }
    
    func changeTopicSelectedState(at index: Int) {
        topics[index].isSelected = !topics[index].isSelected
    }
    
    func image(for cell: UserDefaultsTableViewCell, at index: Int) -> UIImage? {
        topics[index].isSelected ? UIImage.checkmark : nil
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
 

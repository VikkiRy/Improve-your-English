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
    
    init() {
        topics = TopicRepository.shared.topics()
    }
    
    func changeTopicSelectedState(at index: Int) {
        topics[index].isSelected = !topics[index].isSelected
    }
    
    func selectedTopics() -> [Topic] {
        topics.filter { $0.isSelected }
    }
}

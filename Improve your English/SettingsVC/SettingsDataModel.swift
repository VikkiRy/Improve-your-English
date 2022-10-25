//
//  SettingsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 18/10/2022.
//

import Foundation

struct SettingsDataModel {
    var topics: [Topic] = []
    var selectedTopics: [Topic] = []
    var wordsCount: Double {
        UserDefaults.standard.double(forKey: UserSettingKeys.numberOfWords.rawValue)
    }
    
    init() {
        topics = allTopics()
        selectedTopics = userSelectedTopics()
    }
    
    mutating func appendTopic(topicTitle: String) {
        let _ = TopicRepository.shared.addTopic(topicTitle: topicTitle)
        self.topics = TopicRepository.shared.topics().sorted(by: { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        })
    }
    
    mutating func changeTopicSelectedState(at index: Int) {
        topics[index].isSelected = !topics[index].isSelected
        CoreDataManager.shared.save()
        
        selectedTopics = userSelectedTopics()
    }
    
    private func allTopics() -> [Topic] {
        let topics = TopicRepository.shared.topics()
        
        return topics.sorted { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        }
    }
    
    private func userSelectedTopics() -> [Topic] {
        let topics = topics.filter { topic in
            topic.isSelected
        }
        
        return topics.sorted { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        }
    }
    
    func updateUserSettings(wordsCount: Double) {
        guard wordsCount != self.wordsCount else { return }
            
        if wordsCount > self.wordsCount {
            let difference = Int(abs(self.wordsCount - wordsCount))
            
            LearningDataRepository.shared.addCurrentDayData(difference)
        } else {
            var learningData = LearningDataRepository.shared.fetchCurrentDayLearningData()
            
            while learningData.count != Int(wordsCount) {
                learningData.remove(at: 0)
                CoreDataManager.shared.context.delete(learningData[0])
            }
        }
        
        CoreDataManager.shared.save()
        UserDefaults.standard.set(wordsCount, forKey: UserSettingKeys.numberOfWords.rawValue)
    }
    
    func getTopic(forSegmentAt index: Int, topicAt indexPathRow: Int) -> Topic {
        switch index {
        case 0:
            return topics[indexPathRow]
        default:
            return selectedTopics[indexPathRow]
        }
    }
    
    func getTopicCount(forSegmentAt index: Int) -> Int {
        switch index {
        case 0:
            return topics.count
        default:
            return selectedTopics.count
        }
    }
}

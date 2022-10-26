//
//  SettingsDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 18/10/2022.
//

import Foundation

class SettingsDataModel {
    var topics: [Topic] = []
    var selectedTopics: [Topic] = []
    var JSONData: DataJSON? {
        didSet {
            saveNewData()
        }
    }
    
    var wordsCount: Double {
        UserDefaults.standard.double(forKey: UserSettingKeys.numberOfWords.rawValue)
    }
    
    let queueForJSONLoad = DispatchQueue(label: "serialQueue")
    
    init() {
        topics = allTopics()
        selectedTopics = userSelectedTopics()
    }
    
    private func saveNewData() {
        guard let data = JSONData,
              let topics = data.topics else { return }
        
        topics.forEach { topic in
            guard let topicTitle = topic.name else { return }
            
            let newTpoic = Topic(context: CoreDataManager.shared.context)
            newTpoic.title = topicTitle
            newTpoic.isUserTopic = false
            
            guard let words = topic.words else { return }
            
            words.forEach { word in
                guard let engTitle = word.en,
                      let rusTitle = word.rus else { return }
                
                let newWord = Word(context: CoreDataManager.shared.context)
                newWord.engTitle = engTitle
                newWord.rusTitle = rusTitle
                newWord.topic = newTpoic
            }
            
            self.topics.append(newTpoic)
        }
        
        CoreDataManager.shared.save()
        postNotification()
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: Notification.Name("JSONDateSaved"), object: nil)
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
    
    func appendTopic(topicTitle: String) {
        let _ = TopicRepository.shared.addTopic(topicTitle: topicTitle)
        self.topics = TopicRepository.shared.topics().sorted(by: { firstTopic, secondTopic in
            firstTopic.title.lowercased() < secondTopic.title.lowercased()
        })
    }
    
    func changeTopicSelectedState(at index: Int) {
        topics[index].isSelected = !topics[index].isSelected
        CoreDataManager.shared.save()
        
        selectedTopics = userSelectedTopics()
    }
    
    func updateUserSettings(wordsCount: Double) {
        guard wordsCount != self.wordsCount else { return }
            
        if wordsCount > self.wordsCount {
            let difference = Int(abs(self.wordsCount - wordsCount))
            
            do {
                try LearningDataRepository.shared.addCurrentDayData(difference)
            } catch {
                print(error)
            }
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
    
    func loadTopicWords() {
        let url = URL(string: "http://134.209.242.156:8123/improve-your-english/topic")
        
        guard let url = url else { return }
        
        URLSession.shared.dataTask(with: url) { retchedData, response, error in
            guard let data = retchedData else { return }
           
            let decoder = JSONDecoder()
            
            do {
                self.JSONData = try decoder.decode(DataJSON.self, from: data)
            } catch {
                print(error)
            }
            
        }.resume()
    }
}

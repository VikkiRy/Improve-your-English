//
//  AddWordVCDataModel.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 17/10/2022.
//

import Foundation
import UIKit

struct AddWordDataModel {
    
    let topic: Topic
    
    init(topic: Topic) {
        self.topic = topic
    }
    
    func saveWord(wordEng: String, wordRus: String) {
        guard !wordEng.isEmpty, !wordRus.isEmpty else {
            if wordEng.isEmpty && wordRus.isEmpty {
                //todo alert
                print("Add eng and rus word")
            } else if wordEng.isEmpty {
                //todo alert
                print("Add eng word")
            } else if wordRus.isEmpty {
                //todo alert
                print("Add rus word")
            }
            
            return
        }
        
        WordsRepository.shared.addWord(engTitle: wordEng, rusTitle: wordRus, for: topic)
    }
    
}

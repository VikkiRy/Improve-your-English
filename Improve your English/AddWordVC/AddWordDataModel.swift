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
        WordsRepository.shared.addWord(engTitle: wordEng, rusTitle: wordRus, for: topic)
    }
    
}

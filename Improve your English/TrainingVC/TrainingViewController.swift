//
//  RepetitionViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 23/09/2022.
//

import UIKit
import CoreData

class TrainingViewController: UIViewController {
    
    @IBOutlet weak var wordRusLabel: UILabel!
    
    @IBOutlet var translationButtons: [UIButton]!
    
    var dataModel = TrainingDataModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func translationButtonsPressed(_ sender: UIButton) {
        DispatchQueue.main.async {
            if sender.tag == 1 {
                sender.tintColor = .systemGreen
                self.dataModel.trainingData[self.dataModel.index].word.isTrainingCompleted = true
            } else {
                sender.tintColor = .systemRed
            }
            
            self.dataModel.index += 1
            self.updateButtonsTag()
            
            DispatchQueue.main.async {
                sleep(1)
                self.updateUI()
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        CoreDataManager.shared.save()
    }
    
    private func updateUI() {
        translationButtons.forEach { button in
            if button.tintColor != .systemOrange {
                button.tintColor = .systemOrange
            }
        }
        
        translationButtons.shuffle()
        
        let guessedWordIndex = dataModel.index
        wordRusLabel.text = dataModel.trainingData[guessedWordIndex].word.rusTitle
        
        var config = translationButtons[0].configuration
        config?.title = dataModel.trainingData[guessedWordIndex].word.engTitle
        
        translationButtons[0].configuration = config
        translationButtons[0].tag = 1
        
        
        let data = dataModel.randomData()
        
        (1...3).forEach { index in
            config?.title = data[index - 1].word.engTitle
            translationButtons[index].configuration = config
        }
    }
    
    private func updateButtonsTag() {
        translationButtons.forEach { button in
            if button.tag == 1 {
                button.tag = 0
            }
        }
    }
}

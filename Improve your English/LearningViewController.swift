//
//  LearningViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//

import UIKit

class LearningViewController: UIViewController {
    
    @IBOutlet weak var wordEngLabel: UILabel!
    @IBOutlet weak var wordRusLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    
    var words: [Word]!
    var learningWordPosition: Int! {
        willSet {
            if words.count < newValue {
                print("вне нижнего диапазона")
                //todo сделать не достапной кнопку назад
            } else if newValue > words.count {
                print("Превышен диапазон")
                //todo уведомление о успешности и возврат в mainVC
            }
        }
        didSet {
            if words.count - 1 >= learningWordPosition {
                updateUI()
            }
            
            changeBackButtonState()
            changeNextButtonState()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        learningWordPosition = 0
        nextButton.configuration?.baseBackgroundColor = .systemGreen
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let word = words[learningWordPosition]
        WordsRepository.shared.changeLearningState(for: word)
        
        learningWordPosition += 1
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        let word = words[learningWordPosition]
        WordsRepository.shared.changeLearningState(for: word)
        
        learningWordPosition -= 1
    }
    
    
    private func updateUI() {
        let word = words[learningWordPosition]
        if let engTitle = word.engTitle, let rusTitle = word.rusTitle {
            wordEngLabel.text = engTitle
            wordRusLabel.text = rusTitle
        }
    }
    
    private func changeBackButtonState() {
        if learningWordPosition == 0 {
            backButton.isEnabled = false
        } else {
            backButton.isEnabled = true
        }
    }
    
    private func changeNextButtonState() {
        if learningWordPosition == words.count - 1 {
            nextButton.isEnabled = false
        } else {
            nextButton.isEnabled = true
        }
    }
}

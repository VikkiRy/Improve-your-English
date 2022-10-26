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
    @IBOutlet weak var translationButton1WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var translationButton2WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var translationButton3WidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var translationButton4WidthConstraint: NSLayoutConstraint!
    
    var dataModel: TrainingDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        sender.configuration = changeButtonConfig(for: sender)
        
        if sender.tag == 1 {
            dataModel.countOfFinishedTrainingWord += 1
            dataModel.changeTrainingWordState()
        }
        
        dataModel.index += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [self] in
            updateUI()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        dataModel.saveResults()
    }
    
    private func updateUI() {
        resetButtonsProperty()
        translationButtons.shuffle()
        
        if dataModel.index < dataModel.trainingData.count {
            setWrongButtonsConfiguration()
            
            let guessedWord = dataModel.guessedWord
            wordRusLabel.text = guessedWord.rusTitle
            
            setButtonConfiguration(for: guessedWord)
        } else {
            self.navigationController?.popViewController(animated: true)
        }
        
        if UIDevice.current.name == PhoneModels.iPod7.rawValue {
            updateConstraints()
            updateFont()
        }
    }
    
    private func updateFont() {
        let font = UIFont(name: "American Typewriter", size: CGFloat(18))
        
        translationButtons.forEach { button in
            button.titleLabel?.font = font
        }
    }
    
    private func updateConstraints() {
        translationButton1WidthConstraint.constant = CGFloat(130)
        translationButton2WidthConstraint.constant = CGFloat(130)
        translationButton3WidthConstraint.constant = CGFloat(130)
        translationButton4WidthConstraint.constant = CGFloat(130)

        self.view.updateConstraintsIfNeeded()
    }
    
    private func setButtonConfiguration(for guessedWord: Word) {
        guard var configuration =  buttonsStandartConfiguration() else {
            return
        }
        
        configuration.title = guessedWord.engTitle
        translationButtons[0].configuration = configuration
        translationButtons[0].tag = 1
    }
    
    private func setWrongButtonsConfiguration() {
        guard var configuration =  buttonsStandartConfiguration() else {
            return
        }
        
        let titles = dataModel.randomTitles()
        
        (1...3).forEach { index in
            configuration.title = titles[index - 1]
            translationButtons[index].configuration = configuration
        }
    }
    
    private func resetButtonsProperty() {
        translationButtons.forEach { button in
            button.tintColor = .systemGray5
            button.tag = 0
        }
    }
    
    private func buttonsStandartConfiguration() -> UIButton.Configuration? {
        guard var configuration = translationButtons[0].configuration else {
            return nil
        }
        
        configuration.baseBackgroundColor = .systemGray5
        configuration.attributedTitle?.font = UIFont(name: "American Typewriter", size: CGFloat(50))
        
        return configuration
    }
    
    private func changeButtonConfig(for button: UIButton) -> UIButton.Configuration? {
        guard var configuration = button.configuration else {
            return nil
        }
        
        if button.tag == 1 {
            configuration.baseBackgroundColor = .systemGreen
        } else {
            configuration.baseBackgroundColor = .systemRed
        }
        
        return configuration
    }
}

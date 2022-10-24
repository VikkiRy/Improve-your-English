//
//  TrainingViewControllerWithTextField.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 24/10/2022.
//

import UIKit

class TrainingViewControllerWithTextField: UIViewController {
    
    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    
    var dataModel: TrainingDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        CoreDataManager.shared.save()
    }
    
    private func updateUI() {
        textField.delegate = self
        textField.text = nil
        textField.returnKeyType = .done
        
        wordLabel.text = dataModel.guessedWord.rusTitle
    }
}

extension TrainingViewControllerWithTextField: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let userText = textField.text, !userText.isEmpty else {
            let alert = UIAlertController.oneActionAlert(title: nil, message: "Please, enter word", actionTitle: "Got it", preferredStyle: .alert)
            self.present(alert, animated: true)
            
            return false
        }
        
        textField.resignFirstResponder()
        
        let isCorrectWord = dataModel.isCorrectWord(userWord: userText)
        let title = isCorrectWord ? "Correctly!" : "It was a mistake"
        let actionTitle = isCorrectWord ? "Great" : "OK"
        
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        let okAction = UIAlertAction(title: actionTitle, style: .cancel) { [self] _ in
            if isCorrectWord {
                dataModel.changeTrainingWordState()
            }
            
            okActionCompletion()
        }
        
        alert.addAction(okAction)
        present(alert, animated: true)

        return true
    }
    
    private func okActionCompletion() {
        if dataModel.index == dataModel.trainingData.count - 1 {
            self.navigationController?.popViewController(animated: true)
            return
        }
        
        dataModel.index += 1
        updateUI()
    }
}

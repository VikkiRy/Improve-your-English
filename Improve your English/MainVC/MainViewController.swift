//
//  ViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/09/2022.
//

import UIKit
import CoreData

class MainViewController: UIViewController {
    
    @IBOutlet weak var learningButton: UIButton!
    @IBOutlet weak var trainingButton: UIButton!
    
    let dataModel = MainVCDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateButtonsCornersRadius()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case ViewControllerID.learning.rawValue:
            if let learningVC = segue.destination as? LearningViewController {
                learningVC.dataModel = LearningDataModel(learningData: dataModel.learningData)
            }
            
        case ViewControllerID.training.rawValue:
            if let trainingVC = segue.destination as? TrainingViewController {
                trainingVC.dataModel = TrainingDataModel(trainigData: dataModel.trainingData)
            }
            
        case ViewControllerID.trainingWithTextField.rawValue:
            if let trainingVC = segue.destination as? TrainingViewControllerWithTextField {
                trainingVC.dataModel = TrainingDataModel(trainigData: dataModel.trainingData)
            }
        default:
            return
        }
    }
    
    @IBAction func learningButtonPressed(_ sender: UIButton) {
        switch dataModel.learningData.isEmpty {
        case true:
            do {
                try LearningDataRepository.shared.addCurrentDayData()
                performSegue(withIdentifier: ViewControllerID.learning.rawValue, sender: self)
            } catch {
                showAddNewTopicAlert()
            }
        case false:
            performSegue(withIdentifier: ViewControllerID.learning.rawValue, sender: self)
        }
    }
    
    @IBAction func trainingButtonPressed(_ sender: UIButton) {
        switch dataModel.trainingData.isEmpty {
        case true:
            showLearnNewWordsAlert()
        case false:
            let trainingDataCount = dataModel.trainingData.count
            let id = trainingDataCount > 4 ? ViewControllerID.training.rawValue : ViewControllerID.trainingWithTextField.rawValue
            
            performSegue(withIdentifier: id, sender: self)
        }
    }
    //todo
    private func updateButtonsCornersRadius() {
        learningButton.layer.cornerRadius = 15
        trainingButton.layer.cornerRadius = 15
    }
    
    private func showAddNewTopicAlert() {
        let alert = UIAlertController.oneCancelActionAlert(title: nil,
                                                           message: "To continue, you can add new topics in the settings",
                                                           actionTitle: "Got it",
                                                           preferredStyle: .actionSheet)
        
        self.present(alert, animated: true)
    }
    
    private func showLearnNewWordsAlert() {
        let alert = UIAlertController.oneCancelActionAlert(title: "Not available yet",
                                                     message: "You need to learn new words",
                                                     actionTitle: "Got it",
                                                     preferredStyle: .alert)
        
        self.present(alert, animated: true)
    }
}




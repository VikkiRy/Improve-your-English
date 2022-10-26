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
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "learning":
            if let learningVC = segue.destination as? LearningViewController {
                learningVC.dataModel = LearningDataModel(learningData: dataModel.learningData)
            }
        case "training":
            if let trainingVC = segue.destination as? TrainingViewController {
                trainingVC.dataModel = TrainingDataModel(trainigData: dataModel.trainingData)
            }
        case "trainingWithTextField":
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
                performSegue(withIdentifier: "learning", sender: self)
            } catch {
                showAlert()
            }
        case false:
            performSegue(withIdentifier: "learning", sender: self)
        }
    }
    
    @IBAction func trainingButtonPressed(_ sender: UIButton) {
        switch dataModel.trainingData.isEmpty {
        case true:
            let alert = UIAlertController.oneActionAlert(title: "Not available yet", message: "You need to learn new words", actionTitle: "Got it", preferredStyle: .alert)
            
            self.present(alert, animated: true)
        case false:
            if dataModel.trainingData.count < 4 {
                performSegue(withIdentifier: "trainingWithTextField", sender: self)
            } else {
                performSegue(withIdentifier: "training", sender: self)
            }
        }
    }
    
    private func updateButtonsCornersRadius() {
        learningButton.layer.cornerRadius = 15
        trainingButton.layer.cornerRadius = 15
    }
    
    private func showAlert() {
        let alert = UIAlertController(title: nil, message: "To continue, you can add new topics in the settings", preferredStyle: .actionSheet)
        let gotItAction = UIAlertAction(title: "Got it", style: .cancel)
        alert.addAction(gotItAction)
        
        self.present(alert, animated: true)
    }
}




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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.set(false, forKey: UserSettingKeys.isShowMainVC.rawValue)
        updateCornersRadius()
    }
    
    @IBAction func trainingButtonPressed(_ sender: Any) {
        let data = LearningDataRepository.shared.currentDayTrainingData()
        
        switch data.isEmpty {
        case true:
            self.present(alert(), animated: true)
        case false:
            if data.count < 4 {
                performSegue(withIdentifier: "trainingWithTextFiel", sender: self)
            } else {
                performSegue(withIdentifier: "training", sender: self)
            }
        }
    }
    
    private func alert() -> UIAlertController {
        let alertTitle = "Not available yet"
        let message = "You need to learn new words"
        
        let alert = UIAlertController(title: alertTitle, message: message, preferredStyle: .alert)
        
        let gotItAction = UIAlertAction(title: "Got it", style: .cancel)
        alert.addAction(gotItAction)
        
        return alert
    }
    
    private func updateCornersRadius() {
        learningButton.layer.cornerRadius = 15
        trainingButton.layer.cornerRadius = 15
    }
}




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
        if data.isEmpty {
            let alert = UIAlertController(title: "Not available yet", message: "You need to learn new words", preferredStyle: .alert)
            let gotItAction = UIAlertAction(title: "Got it", style: .cancel)
            
            alert.addAction(gotItAction)
            self.present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "training", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "training" {
            if let trainingVC = segue.destination as? TrainingViewController {
                trainingVC.data = LearningDataRepository.shared.currentDayTrainingData()
            }
        }
    }
    
    private func updateCornersRadius() {
        learningButton.layer.cornerRadius = 15
        trainingButton.layer.cornerRadius = 15
    }
}




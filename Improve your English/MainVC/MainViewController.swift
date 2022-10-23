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
    let isWordsExist = WordsRepository.shared.words().isEmpty
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isWordsExist {
            //UserDefaults.standard.set(false, forKey: UserSettingKeys.isShowMainVC.rawValue)
            updateCornersRadius()
        } else {
            let alert = alert(title: "Congratulations!", message: "To continue, you can add new topics in the settings", actionTitle: "OK")
            self.present(alert, animated: true)
        }
    }
    
    @IBAction func trainingButtonPressed(_ sender: Any) {
        let data = LearningDataRepository.shared.currentDayTrainingData()
        
        switch data.isEmpty {
        case true:
            let alert = alert(title: "Not available yet", message: "You need to learn new words", actionTitle: "Got it")
            self.present(alert, animated: true)
        case false:
            if data.count < 4 {
                performSegue(withIdentifier: "trainingWithTextField", sender: self)
            } else {
                performSegue(withIdentifier: "training", sender: self)
            }
        }
    }
    
    private func alert(title: String?, message: String, actionTitle: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        
        return alert
    }
    
    private func updateCornersRadius() {
        learningButton.layer.cornerRadius = 15
        trainingButton.layer.cornerRadius = 15
    }
}




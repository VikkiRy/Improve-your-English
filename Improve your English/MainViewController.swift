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
    
    let learningWords = WordsRepository.shared.learningWords()
    
    var currentDay: String! {
        didSet {
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //UserDefaults.standard.set(false, forKey: UserSettingKeys.isShowMainVC.rawValue)
        setCurrentDate()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "learning":
            if let learningVC = segue.destination as? LearningViewController {
                learningVC.words = learningWords
            }
        case "repetition":
            if let trainingVC = segue.destination as? TrainingViewController {
                
            }
        default:
            break
        }
    }
    
    private func setCurrentDate() {
        let date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = .current
        dateFormatter.dateFormat = "dd.MM.yy"
        
        currentDay = dateFormatter.string(from: date)
    }
}




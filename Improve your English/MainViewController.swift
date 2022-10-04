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
    
    let defaultTopics = DefaultTopics()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "learning":
            if let learningVC = segue.destination as? LearningViewController {
                
            }
        case "repetition":
            if let trainingVC = segue.destination as? TrainingViewController {
                
            }
        default:
            break
        }
    }
}




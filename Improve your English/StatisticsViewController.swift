//
//  StatisticsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import UIKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var topLabelView: UIView!
    @IBOutlet weak var countOfWordsLabel: UILabel!
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    let countOfWords: Int = UserDefaults.standard.integer(forKey: UserSettingKeys.numberOfWords.rawValue)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func segmentedControlPressed(_ sender: Any) {
        
    }
    
    private func updateUI() {
        topLabelView.layer.cornerRadius = 15
        
        let font: UIFont
        if countOfWords < 99 {
            font = countOfWordsLabel.font.withSize(100)
        } else {
            font = countOfWordsLabel.font.withSize(50)
        }
        
        countOfWordsLabel.font = font
        countOfWordsLabel.text = String(countOfWords)
    }
}

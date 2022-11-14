//
//  StatisticsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import UIKit
import CloudKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func segmentedControlPressed(_ sender:  UISegmentedControl) {
        updateLabelText()
    }
    
    private func updateUI() {
        updateLabelText()
        topView.layer.cornerRadius = 15
    }
    
    private func updateLabelText() {
        var initialDate = Date()
        
        switch periodSegmentedControl.selectedSegmentIndex {
        case 0:
            initialDate = Date().startOfWeek
        case 1:
            initialDate = Date().startOfMonth
        case 2:
            initialDate = Date().startOfYear
        case 3:
            initialDate = StatisticRepository.shared.minimumDate()
        default:
            return
        }
        
        let wordsCount = StatisticRepository.shared.wordsCount(from: initialDate)
        wordsCountLabel.text = String(wordsCount)
    }
}

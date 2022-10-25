//
//  StatisticsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 21/10/2022.
//

import UIKit
import CloudKit

class StatisticsViewController: UIViewController {

    @IBOutlet weak var topLabelView: UIView!
    @IBOutlet weak var countOfWordsLabel: UILabel!
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func segmentedControlPressed(_ sender:  UISegmentedControl) {
        updateLabel()
    }
    
    private func updateUI() {
        topLabelView.layer.cornerRadius = 15
        updateLabel()
    }
    
    private func updateLabel() {
        var wordsCount = 0
        
        switch periodSegmentedControl.selectedSegmentIndex {
        case 0:
            wordsCount = StatisticRepository.shared.wordsCount(from: Date().startOfWeek)
        case 1:
            wordsCount = StatisticRepository.shared.wordsCount(from: Date().startOfMonth)
        case 2:
            wordsCount = StatisticRepository.shared.wordsCount(from: Date().startOfYear)
        case 3:
            let startDate = StatisticRepository.shared.minimumDate()
            wordsCount = StatisticRepository.shared.wordsCount(from: startDate)
        default:
            return
        }

        countOfWordsLabel.text = String(wordsCount)

        let font: UIFont
        if wordsCount < 99 {
            font = countOfWordsLabel.font.withSize(100)
        } else {
            font = countOfWordsLabel.font.withSize(50)
        }
        
        countOfWordsLabel.font = font
    }
}

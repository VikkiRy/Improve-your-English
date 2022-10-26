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
    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var countOfWordsLabel: UILabel!
    @IBOutlet weak var periodSegmentedControl: UISegmentedControl!
    @IBOutlet weak var topLabelViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var countOfWordsLabelBottomConstraint: NSLayoutConstraint!
    
    
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
        

        updateFonts()
        updateConstraints()
    }
    
    private func updateFonts() {
        switch UIDevice.current.name {
        case PhoneModels.iPod7.rawValue:
            topLabel.font = UIFont(name: "American Typewriter", size: CGFloat(25))
            countOfWordsLabel.font = UIFont(name: "American Typewriter", size: CGFloat(60))
        case PhoneModels.iPhoneSE.rawValue:
            countOfWordsLabelBottomConstraint.constant = CGFloat(30)
        default:
            return
        }
    }

    private func updateConstraints() {
        topLabelViewHeightConstraint.constant = CGFloat(100)
        countOfWordsLabelBottomConstraint.constant = CGFloat(40)

        self.view.updateConstraintsIfNeeded()
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
        
        if UIDevice.current.name == PhoneModels.iPod7.rawValue {
            font = countOfWordsLabel.font.withSize(60)
        } else if wordsCount < 99 {
            font = countOfWordsLabel.font.withSize(100)
        } else {
            font = countOfWordsLabel.font.withSize(50)
        }
        
        countOfWordsLabel.font = font
    }
}

//
//  LearningViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//

import UIKit

class LearningViewController: UIViewController {
    
    @IBOutlet weak var wordEngLabel: UILabel!
    @IBOutlet weak var wordRusLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var nextButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var backButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var imageViewHeightConstraint: NSLayoutConstraint!
    
    var dataModel: LearningDataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func nextButtonPressed(_ sender: Any) {
        let nextWordIndex = dataModel.learningWordPosition + 1
        if nextWordIndex == dataModel.data.count {
            dataModel.changeWordsLearningState()
            self.navigationController?.popViewController(animated: true)
        } else {
            dataModel.learningWordPosition = nextWordIndex
            updateUI()
        }
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        dataModel.learningWordPosition -= 1
        updateUI()
    }
    
    private func updateUI() {
        let word = dataModel.currentWord
        wordEngLabel.text = word.engTitle
        wordRusLabel.text = word.rusTitle
        
        updateNextButton()
        updateBackButton()
        
        if UIDevice.current.name == PhoneModels.iPod7.rawValue {
            updateConstraints()
        }
    }

    private func updateConstraints() {
        nextButtonHeightConstraint.constant = CGFloat(55)
        backButtonHeightConstraint.constant = CGFloat(55)
        imageViewHeightConstraint.constant = CGFloat(100)
    
        self.view.updateConstraintsIfNeeded()
    }
    private func updateBackButton() {
        switch dataModel.learningWordPosition {
        case 0:
            backButton.isEnabled = false
        default:
            backButton.isEnabled = true
        }
    }
    
    private func updateNextButton() {
        var configuration = nextButton.configuration!
        configuration.baseBackgroundColor = .systemGreen
        
        switch dataModel.learningWordPosition {
        case dataModel.data.count - 1:
            configuration.title = "Done"
            configuration.image = UIImage.init(systemName: "checkmark.circle")
        default:
            configuration.title = "Next"
            configuration.image = UIImage.init(systemName: "chevron.right")
        }
        
        nextButton.configuration = configuration
    }
}

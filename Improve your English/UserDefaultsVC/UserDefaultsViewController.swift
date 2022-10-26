//
//  FirstSettingsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var topText: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var topTextView: UIView!
    @IBOutlet weak var topTextViewHeightTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTextViewHeightBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var topTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomTextLabel: UILabel!
    @IBOutlet weak var bottomTextView: UIView!
    @IBOutlet weak var stackViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var stepperLeadingConstraint: NSLayoutConstraint!
    
    let dataModel = UserDefaultsDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordCountLabel.text = String(Int(sender.value))
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let selectedTopics = dataModel.selectedTopics()
        
        guard !selectedTopics.isEmpty else {
            let alert = UIAlertController.oneActionAlert(
                title: nil,
                message: "Please, select at least 1 topic for learning",
                actionTitle: "Got it",
                preferredStyle: .actionSheet)
            
            self.present(alert, animated: true)
            return
        }
        
        dataModel.saveUserSettings(wordsCount: Int(stepper.value))
    }
    
    private func updateUI() {
        сellRegister()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateTextViewsCornersRadius()
        
        if UIDevice.current.name == PhoneModels.iPod7.rawValue {
            updateFont()
            updateConstraints()
        }
    }
    
    private func updateConstraints() {
        topTextViewHeightConstraint.constant = CGFloat(55)
        topTextViewHeightBottomConstraint.constant = CGFloat(5)
        topTextViewHeightTopConstraint.constant = CGFloat(5)
        stackViewHeightConstraint.constant = CGFloat(70)
        numberLeadingConstraint.constant = CGFloat(2)
        stepperLeadingConstraint.constant = CGFloat(2)
        
        self.view.updateConstraintsIfNeeded()
    }
    
    private func updateFont() {
        let font = UIFont(name: "American Typewriter", size: CGFloat(18))
        
        topText.font = font
        bottomTextLabel.font = font
        wordCountLabel.font = UIFont(name: "American Typewriter", size: CGFloat(25))
    }
    
    private func сellRegister() {
        let nib = UINib(nibName: "UserDefaultsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userDefaults")
    }
    
    private func updateTextViewsCornersRadius() {
        topTextView.layer.cornerRadius = 15
        bottomTextView.layer.cornerRadius = 15
        tableView.layer.cornerRadius = 15
    }
}

extension UserDefaultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDefaults", for: indexPath) as! UserDefaultsTableViewCell
        
        cell.topicTitleLabel.text = dataModel.topics[indexPath.row].title
        
        return cell
    }
}

extension UserDefaultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserDefaultsTableViewCell else {
            return
        }
        
        dataModel.changeTopicSelectedState(at: indexPath.row)
        
        let image = dataModel.topics[indexPath.row].isSelected ? UIImage.checkmark : nil
        cell.checkmarkImageView.image = image
        cell.checkmarkImageView.tintColor = .systemGreen
    }
}

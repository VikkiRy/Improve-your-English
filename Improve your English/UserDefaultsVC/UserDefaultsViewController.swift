//
//  FirstSettingsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var doneButton: UIButton!
    
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
            showAlert()
            return
        }
        
        dataModel.saveUserSettings(wordsCount: Int(stepper.value))
    }
    
    private func updateUI() {
        сellRegister()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateViewConstraints()
        updateViewsCornersRadius()
    }
    
    private func сellRegister() {
        let nib = UINib(nibName: "UserDefaultsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: CellID.userDefaults.rawValue)
    }
    
    private func updateViewsCornersRadius() {
        let views = [topView, bottomView, tableView]
        
        views.forEach { view in
            if let view = view {
                view.layer.cornerRadius = 15
            }
        }
    }
    
    private func showAlert() {
        let alert = UIAlertController.oneCancelActionAlert(
            title: nil,
            message: "Please, select at least 1 topic for learning",
            actionTitle: "Got it",
            preferredStyle: .actionSheet)
        
        self.present(alert, animated: true)
    }
}

extension UserDefaultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellID.userDefaults.rawValue, for: indexPath) as! UserDefaultsTableViewCell
        
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

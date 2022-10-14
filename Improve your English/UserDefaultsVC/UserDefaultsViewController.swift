//
//  FirstSettingsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit
import CoreData

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
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
        let topics = dataModel.selectedTopics()
        
        guard !topics.isEmpty else {
            let message = "Please, select at least 1 topic for learning"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
            
            return
        }
        
        dataModel.saveUserSettings(wordsCount: Int(stepper.value))
    }
    
    private func updateUI() {
        let nib = UINib(nibName: "UserDefaultsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "userDefaults")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension UserDefaultsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.topicsCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDefaults", for: indexPath) as! UserDefaultsTableViewCell
        
        cell.topicTitleLabel.text = dataModel.topicTitle(at: indexPath.row)
        
        return cell
    }
}

extension UserDefaultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserDefaultsTableViewCell else {
            return
        }
        
        dataModel.changeTopicSelectedState(at: indexPath.row)
        
        cell.checkmarkImageView.image = dataModel.image(for: cell, at: indexPath.row)
    }
}

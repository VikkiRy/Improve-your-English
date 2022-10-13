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
    
    let topics = TopicRepository.shared.topics()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordCountLabel.text = String(Int(sender.value))
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        let selectedTopics = topics.filter { topic in
            topic.isSelected
        }
        
        guard !selectedTopics.isEmpty else {
            let message = "Please, select at least 1 topic to study"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
            
            return
        }
        
        CoreDataManager.shared.save()
                
        UserDefaults.standard.setValuesForKeys([
            UserSettingKeys.isShowMainVC.rawValue: true,
            UserSettingKeys.numberOfWords.rawValue: Int(stepper.value)
        ])
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
        return topics.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "userDefaults", for: indexPath) as! UserDefaultsTableViewCell
        
        cell.topicTitleLabel.text = topics[indexPath.row].title
        
        return cell
    }
}

extension UserDefaultsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? UserDefaultsTableViewCell else {
            return
        }
        
        changeSelectedState(forTopicAt: indexPath.row)
        changeImage(for: cell, at: indexPath.row)
    }
    
    private func changeSelectedState(forTopicAt index: Int) {
        topics[index].isSelected = !topics[index].isSelected
    }
    
    private func changeImage(for cell: UserDefaultsTableViewCell, at index: Int) {
        switch topics[index].isSelected {
        case true:
            cell.checkmarkImageView.image = .checkmark
        case false:
            cell.checkmarkImageView.image = .none
        }
    }
}

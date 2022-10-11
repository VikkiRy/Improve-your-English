//
//  FirstSettingsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit

class UserDefaultsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var doneButton: UIButton!
    
    let topics = TopicRepository.shared.topics()
    var selectedTopicsTitles: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordCountLabel.text = String(Int(sender.value))
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        UserDefaults.standard.set(true, forKey: UserSettingKeys.isShowMainVC.rawValue)
        UserDefaults.standard.set(selectedTopicsTitles, forKey: UserSettingKeys.selectedTopic.rawValue)
        UserDefaults.standard.set(Int(stepper.value), forKey: UserSettingKeys.numberOfWords.rawValue)
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
        guard let cell = tableView.cellForRow(at: indexPath) as? UserDefaultsTableViewCell,
              let topicTitle = cell.topicTitleLabel.text else {
            return
        }
        
        let image = cell.checkmarkImageView.image
        
        switch image  {
        case .none:
            cell.checkmarkImageView.image = .checkmark
            selectedTopicsTitles.append(topicTitle)
        default:
            cell.checkmarkImageView.image = .none
            selectedTopicsTitles.removeAll { text in
                text == topicTitle
            }
        }
    }
}

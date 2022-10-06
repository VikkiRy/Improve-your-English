//
//  FirstSettingsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 06/10/2022.
//

import UIKit

class FirstSettingsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    
    let topics = TopicRepository.shared.topics()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        updateUI()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordCountLabel.text = String(Int(sender.value))
    }
    
    private func updateUI() {
        let nib = UINib(nibName: "FirstSettingsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "firstSettingsCell")
        
        tableView.dataSource = self
    }
}

extension FirstSettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "firstSettingsCell", for: indexPath) as! FirstSettingsTableViewCell
        
        cell.topicTitleLabel.text = topics[indexPath.row].title
        
        return cell
    }
}

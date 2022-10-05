//
//  SettingsVC.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 23/09/2022.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var addTopicButton: UIButton!
    
    var topics: [Topic]!
    var selectedTopic: Topic?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        reloadData()
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordsCountLabel.text = String(Int(sender.value))
    }
    
    @IBAction func addTopicButtonPressed(_ sender: UIButton) {
        let alert = UIAlertController(title: nil, message: "Enter topic name", preferredStyle: .alert)
        
        alert.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let doneAction = UIAlertAction(title: "Done", style: .default) { action in
            if let text = alert.textFields?.first?.text {
                let _ = TopicRepository.shared.createTopic(topicTitle: text)
                self.reloadData()
            }
        }
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        self.present(alert, animated: true)
        
    }
    
    private func updateUI() {
        let nibCell = UINib(nibName: "TopicTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "topicCell")
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsVC" {
            if let wordsVC = segue.destination as? WordsViewController {
                if let topic = selectedTopic {
                    wordsVC.topic = topic
                }
            }
        }
    }
    
    private func reloadData() {
        topics = TopicRepository.shared.topics()
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicTableViewCell
        
        cell.topicTitleLabel.text = topics[indexPath.row].title
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedTopic = topics[indexPath.row]
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "wordsVC", sender: tableView)
    }
}

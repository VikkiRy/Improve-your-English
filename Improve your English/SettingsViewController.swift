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
    
    private var topics: [Topic]!
    
    private var context: NSManagedObjectContext = {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        return context
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topics = TopicRepository.topics(context: context)
        updateUI()
    }
    
    private func updateUI() {
        tableView.dataSource = self
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper) {
        wordsCountLabel.text = String(Int(sender.value))
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! CustomTableViewCell
        
        cell.topicTitleLabel.text = topics[indexPath.row].title
        
        return cell
    }
}

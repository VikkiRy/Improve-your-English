//
//  SettingsVC.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 23/09/2022.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var wordsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var topicsView: UIView!
    @IBOutlet weak var topicsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addTopicButton: UIButton!
    @IBOutlet weak var wordsSteckVuew: UIStackView!
    
    var dataModel = SettingsDataModel()
    var selectedRow: Int? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeSelectedTopics(with:)), name: NSNotification.Name(rawValue: "selectedTopicsChanged"), object: nil)
        updateUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        dataModel.updateUserSettings(wordsCount: stepper.value)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectedTopicsChanged"), object: nil)
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper!) {
        let stepperValue = Int(sender.value)
        
        wordsCountLabel.text = String(stepperValue)
    }
    
    @IBAction func setmentDidChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func addTopicButtonPressed(_ sender: UIButton) {
        showAlert()
    }
    
    private func showAlert() {
        let message = "Enter topic title"

        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addTextField()
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let doneAction = UIAlertAction(title: "Done", style: .default) { _ in
            self.doneActionCompletion(at: alert)
        }
        
        alert.addAction(cancelAction)
        alert.addAction(doneAction)
        
        self.present(alert, animated: true)
    }
    
    private func doneActionCompletion(at alert: UIAlertController) {
        guard let text = alert.textFields?.first?.text,
              !text.isEmpty else {
            return
        }
        
        dataModel.appendTopic(topicTitle: text)
        tableView.reloadData()
    }
    
    private func updateUI() {
        let nibCell = UINib(nibName: "TopicTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "topicCell")
        
        tableView.dataSource = self
        tableView.delegate = self
        
        updateInitialValues()
        updateViewsConrers()
    }
    
    private func updateViewsConrers() {
        topicsView.layer.cornerRadius = 10
        wordsView.layer.cornerRadius = 10
    }
    
    private func updateInitialValues() {
        let stepperValue = dataModel.wordsCount
        
        wordsCountLabel.text = String(Int(stepperValue))
        stepper.value = stepperValue
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsVC" {
            if let wordsVC = segue.destination as? WordsViewController {
                if let index = selectedRow {
                    wordsVC.dataModel = WordsDataModel(topic: dataModel.topics[index])
                }
            }
        }
    }
    
    @objc private func changeSelectedTopics(with notify: NSNotification) {
        dataModel.changeTopicSelectedState(at: notify.object as! Int)
        tableView.reloadData()
    }
}

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let selectedSegmentIndex = topicsSegmentedControl.selectedSegmentIndex
        return dataModel.getTopicCount(forSegmentAt: selectedSegmentIndex)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "topicCell", for: indexPath) as! TopicTableViewCell
        
        let selectedSegmentIndex = topicsSegmentedControl.selectedSegmentIndex
        let topic = dataModel.getTopic(forSegmentAt: selectedSegmentIndex, topicAt: indexPath.row)
        
        cell.topicTitleLabel.text = topic.title
        
        cell.checkmarkButton.tag = indexPath.row
        cell.checkmarkButton.setImage(UIImage.checkmark, for: .selected)
        cell.checkmarkButton.setImage(.remove, for: .normal)
        
        cell.checkmarkButton.isSelected = topic.isSelected
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        selectedRow = indexPath.row
        return indexPath
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "wordsVC", sender: tableView)
    }
}

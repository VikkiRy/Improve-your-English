//
//  SettingsVC.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 23/09/2022.
//

import UIKit
import CoreData

class SettingsViewController: UIViewController {

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var wordsView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var wordsCountLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var topicsView: UIView!
    @IBOutlet weak var topicsSegmentedControl: UISegmentedControl!
    @IBOutlet weak var addTopicButton: UIButton!
    @IBOutlet weak var wordsSteckVuew: UIStackView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var addNewTopicsButton: UIButton!
    @IBOutlet weak var topicsViewHeightConstraint: NSLayoutConstraint!
    
    
    var dataModel = SettingsDataModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        addObservers()
    }
   
    override func viewWillDisappear(_ animated: Bool) {
        dataModel.updateUserSettings(wordsCount: stepper.value)
        removeObservers()
        
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedIndexPath, animated: animated)
        }
    }
    
    @IBAction func stepperPressed(_ sender: UIStepper!) {
        let stepperValue = Int(sender.value)
        
        wordsCountLabel.text = String(stepperValue)
    }
    
    @IBAction func setmentDidChanged(_ sender: UISegmentedControl) {
        tableView.reloadData()
    }
    
    @IBAction func addCustomTopicButtonPressed(_ sender: Any) {
        showAlert()
    }
    
    @IBAction func addNewTopicsButtonPressed(_ sender: Any) {
        self.view.isUserInteractionEnabled = false
        self.view.alpha = CGFloat(0.3)
        activityIndicatorView.startAnimating()
        dataModel.loadTopicWords()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "wordsVC" {
            if let wordsVC = segue.destination as? WordsViewController {
                if let indexPath = tableView.indexPathForSelectedRow {
                    wordsVC.dataModel = WordsDataModel(topic: dataModel.topics[indexPath.row])
                }
            }
        }
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(changeSelectedTopics(with:)), name: NSNotification.Name(rawValue: "selectedTopicsShouldChanged"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTableView(with:)), name: NSNotification.Name(rawValue: "JSONDateSaved"), object: nil)
    }
    
    private func removeObservers() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "selectedTopicsShouldChanged"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "JSONDateSaved"), object: nil)
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
        
        addNewTopicsButton.isEnabled = UserDefaults.standard.bool(forKey: UserSettingKeys.addNewTopicsButtonIsEnabled.rawValue)
        
        updateFont()
        updateConstraints()
    }

    private func updateFont() {
        switch UIDevice.current.name {
        case PhoneModels.iPod7.rawValue:
            topLabel.font = UIFont(name: "American Typewriter", size: CGFloat(17))
        default:
            return
        }
    }
    
    private func updateConstraints() {
        switch UIDevice.current.name {
        case PhoneModels.iPod7.rawValue:
            topicsViewHeightConstraint.constant = CGFloat(170)
        case PhoneModels.iPhoneSE.rawValue:
            topicsViewHeightConstraint.constant = CGFloat(250)
        default:
            return
        }

        self.view.updateConstraintsIfNeeded()
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
    
    @objc private func changeSelectedTopics(with notify: NSNotification) {
        dataModel.changeTopicSelectedState(at: notify.object as! Int)
        tableView.reloadData()
    }
    
    @objc private func updateTableView(with notify: NSNotification) {
        UserDefaults.standard.set(false, forKey: UserSettingKeys.addNewTopicsButtonIsEnabled.rawValue)
        DispatchQueue.main.async {
            self.addNewTopicsButton.isEnabled = false
            self.tableView.reloadData()
            self.addNewTopicsButton.isEnabled = false
            self.activityIndicatorView.stopAnimating()
            self.view.alpha = CGFloat(1)
            self.view.isUserInteractionEnabled = true
        }
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
        cell.checkmarkButton.setImage(UIImage.init(systemName: "checkmark"), for: .selected)
        cell.checkmarkButton.setImage(UIImage.init(systemName: "xmark"), for: .normal)
        cell.checkmarkButton.isSelected = topic.isSelected
        
        return cell
    }
}

extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "wordsVC", sender: tableView)
    }
}

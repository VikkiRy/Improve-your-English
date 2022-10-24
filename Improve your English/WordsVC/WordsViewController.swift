//
//  WordsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import UIKit
import CoreData

class WordsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addWordButton: UIBarButtonItem!
    
    var dataModel: WordsDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
            selector: #selector(modalViewDismissed(_:)),
            name: Notification.Name("modalViewDismissed"),
            object: nil)
        
        updateUI()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWord" {
            if let addWordVC = segue.destination as? AddWordViewController {
                addWordVC.dataModel = AddWordDataModel(topic: dataModel.topic)
            }
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("modalViewDismissed"), object: nil)
    }
    
    @IBAction func addWordButtonPressed(_ sender: UIBarButtonItem) {
        switch dataModel.isShouldPerformSegue() {
        case true:
            performSegue(withIdentifier: "addWord", sender: self)
        case false:
            showAlert()
        }
    }
    
    @objc private func modalViewDismissed(_ notify: NSNotification) {
        if notify.object is AddWordViewController {
            dataModel.updateTopicWords()
            tableView.reloadData()
        }
    }
    
    private func showAlert() {
        let message = "Sorry, you can add words only to your own topics"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
    
    private func updateUI() {
        let nibCell = UINib(nibName: "WordTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "wordCell")
        
        tableView.dataSource = self
    }
}

extension WordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.topicWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        
        cell.wordLabel.text = dataModel.topicWords[indexPath.row].engTitle
        
        return cell
    }
}

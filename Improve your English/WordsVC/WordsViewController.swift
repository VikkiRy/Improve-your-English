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
    
    var topic: Topic!
    var topicWords: [Word]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        reloadData()
    }
    
    @IBAction func addWordButtonPressed(_ sender: UIBarButtonItem) {
        if topic.isUserTopic == false {
            let alert = UIAlertController(title: nil, message: "Sorry, you can add words only to your own topics", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: nil, message: "Enter new word", preferredStyle: .alert)
            
            alert.addTextField()
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            let doneAction = UIAlertAction(title: "Done", style: .default) { action in
                if let word = alert.textFields?.first?.text {
                    TopicRepository.shared.addWord(wordTitle: word, for: self.topic)
                    self.reloadData()
                }
            }
            
            alert.addAction(cancelAction)
            alert.addAction(doneAction)
            self.present(alert, animated: true)
        }
    }
    
    private func updateUI() {
        let nibCell = UINib(nibName: "WordTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "wordCell")
        
        tableView.dataSource = self
    }
    
    private func reloadData() {
        topicWords = TopicRepository.shared.words(for: topic)
        tableView.reloadData()
    }
}

extension WordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicWords.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        cell.wordLabel.text = topicWords[indexPath.row].title
        
        return cell
    }
}

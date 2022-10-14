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
    var topicWords: [Word]! {
        didSet {
            topicWords.sort { firstWord, secondWord in
                firstWord.engTitle! < secondWord.engTitle!
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
        reloadData()
    }
    
    @IBAction func addWordButtonPressed(_ sender: UIBarButtonItem) {
        switch topic.isUserTopic {
        case true:
           performSegue(withIdentifier: "addWord", sender: self)
        case false:
            let message = "Sorry, you can add words only to your own topics"
            let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addWord" {
            if let addWordVC = segue.destination as? AddWordViewController {
                addWordVC.topic = topic
            }
        } else {
            return
        }
    }
    
    private func updateUI() {
        let nibCell = UINib(nibName: "WordTableViewCell", bundle: nil)
        tableView.register(nibCell, forCellReuseIdentifier: "wordCell")
        
        tableView.dataSource = self
    }
    
    private func reloadData() {
        guard let words = topic.words else {
            return
        }
        
        topicWords = words.allObjects as? [Word]
        print("==========")
        print(topicWords)
        if !topicWords.isEmpty {
            tableView.reloadData()
        }
    }
}

extension WordsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topicWords.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "wordCell", for: indexPath) as! WordTableViewCell
        cell.wordLabel.text = topicWords[indexPath.row].engTitle
        
        return cell
    }
}

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
        let alert = UIAlertController(title: nil, message: "Sorry, you can add words only to your own topics", preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        let alertEng = UIAlertController(title: nil, message: "Enter new egnlish word", preferredStyle: .alert)
        let doneEngAction = UIAlertAction(title: "Done", style: .default) { action in
            if let wordEng = alertEng.textFields?.first?.text {
                UserDefaults.standard.set(wordEng, forKey: UserSettingKeys.wordEngTitle.rawValue)
            }
        }
        
        
        alertEng.addTextField()
        alertEng.addAction(cancelAction)
        alertEng.addAction(doneEngAction)
        
        let alertRus = UIAlertController(title: nil, message: "Enter new word translation", preferredStyle: .alert)
        let doneRusAction = UIAlertAction(title: "Done", style: .default) { action in
            if let wordEng = alertEng.textFields?.first?.text {
                UserDefaults.standard.set(wordEng, forKey: UserSettingKeys.wordRusTitle.rawValue)
            }
        }
        alertRus.addTextField()
        alertRus.addAction(cancelAction)
        alertRus.addAction(doneRusAction)

        
        if topic.isUserTopic {
            self.present(alertEng, animated: true)
            let wordEng = UserDefaults.standard.value(forKey: UserSettingKeys.wordEngTitle.rawValue) as! String
            
            self.present(alertRus, animated: true)
            
            
            let wordRus = UserDefaults.standard.value(forKey: UserSettingKeys.wordRusTitle.rawValue) as! String
            
            WordsRepository.shared.addWord(engTitle: wordEng, rusTitle: wordRus, for: self.topic)
            self.reloadData()
        } else {
            let okAction = UIAlertAction(title: "Ok", style: .default)
            
            alert.addAction(okAction)
            self.present(alert, animated: true)
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
        tableView.reloadData()
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

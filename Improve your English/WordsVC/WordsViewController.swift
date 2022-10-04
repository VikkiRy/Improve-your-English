//
//  WordsViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 29/09/2022.
//

import UIKit
import CoreData

class WordsViewController: UIViewController {
    
    @IBOutlet weak var tabelView: UITableView!
    var topic: Topic!
    var topicWords: [Word]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    private func updateUI() {
        tabelView.dataSource = self
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

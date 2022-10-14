//
//  AddWordViewController.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 14/10/2022.
//

import UIKit

class AddWordViewController: UIViewController {
    @IBOutlet weak var wordEngTextfield: UITextField!
    @IBOutlet weak var wordRusTextfield: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    var topic: Topic!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
   
    @IBAction func doneButtonPressed(_ sender: Any) {
        if let wordEng = getText(form: wordEngTextfield),
           let wordRus = getText(form: wordRusTextfield) {
            
            WordsRepository.shared.addWord(engTitle: wordEng, rusTitle: wordRus, for: topic)
        }
        else {
            //todo alert
            print("Add eng and rus word")
        }
        performSegue(withIdentifier: "baskToWordsVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "baskToWordsVC" {
            if let wordsVC = segue.destination as? WordsViewController {
                wordsVC.topic = topic
            }
        }
    }
    
    private func getText(form textField: UITextField) -> String? {
        guard let text = textField.text, !text.isEmpty else {
            return nil
        }
        
        return text
    }

   
    /*
     
     
     let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
     
     let alertEng = UIAlertController(title: nil, message: "Enter new egnlish word", preferredStyle: .alert)
     let doneEngAction = UIAlertAction(title: "Done", style: .default) { action in
         if let wordEng = alertEng.textFields?.first?.text {
             
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
         
     }
     */

}

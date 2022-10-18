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
    
    var dataModel: AddWordDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
   
    @IBAction func doneButtonPressed(_ sender: Any) {
        dataModel.saveWord(wordEng: wordEngTextfield.text!, wordRus: wordRusTextfield.text!)
        
        //todo don't dismiss vc after alert did show
        self.dismiss(animated: true) {
            NotificationCenter.default.post(name: Notification.Name("modalViewDismissed"), object: self)
        }
    }
    
    private func getText(form textField: UITextField) -> String? {
        guard let text = textField.text, !text.isEmpty else {
            return nil
        }
        
        return text
    }
}

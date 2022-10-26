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
    @IBOutlet weak var wordEngTextfieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordEngTextfieldBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var wordsRusTextFieldTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var buttonTopConstraint: NSLayoutConstraint!
    
    var dataModel: AddWordDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateConstraints()
    }

    private func updateConstraints() {
        switch UIDevice.current.name {
        case PhoneModels.iPod7.rawValue, PhoneModels.iPhoneSE.rawValue:
            wordEngTextfieldTopConstraint.constant = CGFloat(10)
            wordEngTextfieldBottomConstraint.constant = CGFloat(20)
            wordsRusTextFieldTopConstraint.constant = CGFloat(10)
            buttonTopConstraint.constant = CGFloat(15)
        case PhoneModels.iPhone8.rawValue, PhoneModels.iPhone8Plus.rawValue, PhoneModels.iPhone12mini.rawValue:
            wordEngTextfieldTopConstraint.constant = CGFloat(20)
            wordEngTextfieldBottomConstraint.constant = CGFloat(20)
            wordsRusTextFieldTopConstraint.constant = CGFloat(20)
            buttonTopConstraint.constant = CGFloat(20)
        default:
            return
        }

        self.view.updateConstraintsIfNeeded()
    }
   
    @IBAction func doneButtonPressed(_ sender: Any) {
        guard let wordEng = getText(form: wordEngTextfield),
              let wordRus = getText(form: wordEngTextfield) else {
            showAlert()
            return
        }
        
        dataModel.saveWord(wordEng: wordEng, wordRus: wordRus)
        
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
    
    private func showAlert() {
        let message = "Sorry, you must add the word and its translation"
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .cancel)
        
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}

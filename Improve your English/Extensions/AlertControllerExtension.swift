//
//  AlertControllerExtension.swift
//  Improve your English
//
//  Created by Viktoria Misiulia on 24/10/2022.
//

import Foundation
import UIKit

extension UIAlertController {
    static func oneCancelActionAlert(title: String?, message: String, actionTitle: String, preferredStyle: UIAlertController.Style) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let action = UIAlertAction(title: actionTitle, style: .cancel)
        alert.addAction(action)
        
        return alert
    }
}

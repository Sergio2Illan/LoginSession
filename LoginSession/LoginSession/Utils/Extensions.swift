//
//  Extensions.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import Foundation
import UIKit


extension UIViewController {
    func showAlert(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Acept", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//
//  HomeViewController.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import UIKit

class HomeViewController: UIViewController {

    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Actions
    
    @IBAction func signOut(_ sender: UIBarButtonItem) {
        FirebaseViewModel.shared.signOut { done in
            if done {
                UserDefaults.standard.removeObject(forKey: "session")
                self.dismiss(animated: true)
                
            }else {
                self.showAlert(title: "Error", message: "Whe have a problem to signOut the current user.")
            }
        }
    }
    
}

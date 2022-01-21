//
//  ViewController.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import UIKit

class ViewController: UIViewController {
    
    //MARK: - Properties

    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    
    //MARK: - LifeCicle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if (UserDefaults.standard.object(forKey: "session") != nil){
            self.next(identifier: "entrar")
        }
    }
    
    //MARK: - Actions
    
    @IBAction func signIn(_ sender: UIButton) {
        guard let emailTxt = emailTF.text else { return }
        guard let passTxt = passwordTF.text else { return }
        FirebaseViewModel.shared.login(email: emailTxt, pass: passTxt) { done in
            if done {
                UserDefaults.standard.set(true, forKey: "session")
                self.next(identifier: "entrar")
            }else {
                self.showAlert(title: "Error", message: "User is not registered.")
            }
        }
    }
    
    @IBAction func handleCreateUser(_ sender: UIButton) {
        guard let emailTxt = emailTF.text else { return }
        guard let passTxt = passwordTF.text else { return }
        FirebaseViewModel.shared.createUser(email: emailTxt, pass: passTxt) { done in
            if done {
                UserDefaults.standard.set(true, forKey: "session")
                self.next(identifier: "entrar")
            }else {
                self.showAlert(title: "Error", message: "Can not create a new user.")
            }
        }
    }
    
    
    //MARK: - Helpers
    
    private func next(identifier: String){
        performSegue(withIdentifier: identifier, sender: self)
    }
}


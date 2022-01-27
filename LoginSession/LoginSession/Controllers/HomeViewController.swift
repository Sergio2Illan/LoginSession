//
//  HomeViewController.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import UIKit
import Firebase

class Celda: UITableViewCell {

    
    @IBOutlet weak var por: UIImageView!
    @IBOutlet weak var titulo: UILabel!
    @IBOutlet weak var plataforma: UILabel!
    @IBOutlet weak var descrip: UITextView!
    
}


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var table: UITableView!
    
    //MARK: - lifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        FirebaseViewModel.shared.loadData { done in
            if done {
                self.table.reloadData()
            }
        }

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
    
    //MARK: - UITable Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FirebaseViewModel.shared.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! Celda
        let data = FirebaseViewModel.shared.data[indexPath.row]
        cell.titulo.text = data.title
        cell.descrip.text = data.des
        cell.plataforma.text = data.plataforma
        Storage.storage().reference(forURL: data.portada).getData(maxSize: 10 * 1024 * 1024) { data, err in
            if let error = err?.localizedDescription {
                self.showAlert(title: "ERROR", message: "\(error)")
            }else {
                DispatchQueue.main.async {
                    cell.por.image = UIImage(data: data!)
                    self.table.reloadData()
                }
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 350.0
    }
}

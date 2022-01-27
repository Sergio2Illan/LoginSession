//
//  FirebaseViewModel.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import Foundation
import Firebase


class FirebaseViewModel {
    
    //MARK: - properties
    
    public static let shared = FirebaseViewModel()
    var data: [FirebaseModel] = []
    
    //MARK: - signIn
    
    func login (email: String, pass: String, completion: @escaping (_ done: Bool) -> Void){
        Auth.auth().signIn(withEmail: email, password: pass) { user, err in
            if user != nil {
                print("Login")
                completion(true)
            } else{
                if let error = err?.localizedDescription {
                    print("Error: \(error)")
                    completion(false)
                }else {
                    print("Error App crashes")
                    completion(false)
                }
            }
        }
    }
    
    //MARK: - create user
    
    func createUser(email: String, pass: String, completion: @escaping (_ done: Bool) -> Void) {
        Auth.auth().createUser(withEmail: email, password: pass) { user, err in
            if user != nil {
                print("Create User")
                completion(true)
            } else{
                if let error = err?.localizedDescription {
                    print("Error: \(error)")
                    completion(false)
                }else {
                    print("Error App crashes")
                    completion(false)
                }
            }
        }
    }
    
    //MARK: - SignOut
    
    func signOut(completion: @escaping (_ done: Bool) -> ()){
        do {
            try Auth.auth().signOut()
            completion(true)
        } catch let error {
            print("Error: \(error)")
            completion(false)
        }
    }
    
    
    //MARK: - Save Data Base
    
    func save(title: String, description: String, platform: String, image: UIImage, completion: @escaping (_ done: Bool)-> Void){
        
        let storage = Storage.storage().reference()
        let nameImg = UUID()
        let directory = storage.child("imagenes/\(nameImg)")
        let metadata = StorageMetadata()
        metadata.contentType = "image/png"
        
        directory.putData(image.pngData()!, metadata: metadata) { data, err in
            if err == nil {
                let db = Firestore.firestore()
                let id = UUID().uuidString
                guard let idUser = Auth.auth().currentUser?.uid else { return }
                guard let email = Auth.auth().currentUser?.email else { return }
                let fields: [String:Any] = ["titulo":title,"descripcion":description,"plataforma":platform,"portada":String(describing: directory),"userId":idUser, "email":email]
                db.collection("juegos").document(id).setData(fields) { err in
                    if let error = err {
                        completion(false)
                    }else {
                        completion(true)
                    }
                }
            } else{
                if let error = err?.localizedDescription {
                    completion(false)
                    print("Error: ---> \(error)")
                }else {
                    completion(false)
                }
            }
            
        }
    }
    
    
    //MARK: - Load Data Base
    
    func loadData(completion: @escaping (_ done: Bool) -> Void){
        let db = Firestore.firestore()
        db.collection("juegos").addSnapshotListener { QuerySnapshot, error in
            if let error = error?.localizedDescription {
                print("Error---> Can not show data")
                completion(false)
            }else {
                self.data.removeAll()
                for document in QuerySnapshot!.documents {
                    let valor = document.data()
                    let id = document.documentID
                    let tit = valor["titulo"] as? String ?? "Anonymous"
                    let descrip = valor["descripcion"] as? String ?? "Anonymous"
                    let portada = valor["portada"] as? String ?? "Anonymous"
                    let plataforma = valor["plataforma"] as? String ?? "Anonymous"
                    DispatchQueue.main.async {
                        let register = FirebaseModel(id: id, title: tit, des: descrip, portada: portada, plataforma: plataforma)
                        self.data.append(register)
                        completion(true)
                    }
                }
                
            }
        }
    }
    
}

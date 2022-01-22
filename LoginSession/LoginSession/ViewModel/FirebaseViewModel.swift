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
    
}

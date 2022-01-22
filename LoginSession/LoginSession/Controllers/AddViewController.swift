//
//  AddViewController.swift
//  LoginSession
//
//  Created by Sergio Illan Illan on 21/1/22.
//

import UIKit
import Photos

class AddViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    
    //MARK: - Properties
    
    @IBOutlet weak var tit: UITextField!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var platforms: UIPickerView!
    
    let plat: [String] = ["PlayStation","Xbox","Nintendo","PC"]
    var defaultValue = "PlayStation"
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func handleLoadImage(_ sender: Any) {
        let pickerGalery = UIImagePickerController()
        pickerGalery.allowsEditing = true
        pickerGalery.sourceType = .photoLibrary
        pickerGalery.delegate = self
        present(pickerGalery, animated: true, completion: nil)
    }
    
    @IBAction func handleSave(_ sender: Any) {
        
    }
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    //MARK: - PickerView Delegate methods
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return plat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return plat[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        defaultValue = plat[row]
    }
    
    //MARK: - UIImagePickerController Delegate methods
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

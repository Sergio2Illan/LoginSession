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
    @IBOutlet weak var progress: UIActivityIndicatorView!
    @IBOutlet weak var platforms: UIPickerView!
    
    let plat: [String] = ["PlayStation","Xbox","Nintendo","PC"]
    var defaultValue = "PlayStation"
    
    var imagenSelected = UIImage()
    
    //MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
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
        self.progress.isHidden = false
        progress.startAnimating()
        guard let title = tit.text else { return }
        guard let description = desc.text else { return }
        FirebaseViewModel.shared.save(title: title, description: description, platform: defaultValue, image: imagenSelected) { done in
            if done {
                self.progress.stopAnimating()
                self.progress.isHidden = true
                self.tit.text = ""
                self.desc.text = ""
                self.image.image = UIImage(systemName: "photo")
            }else {
                self.progress.stopAnimating()
                self.progress.isHidden = true
                self.showAlert(title: "Error", message: "There is a problem saving the game in our data base, please try ir later.")
            }
        }
    }
    
    @IBAction func tappedCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.sourceType = .camera
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func setUI(){
        progress.isHidden = true
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
        imagenSelected = info[UIImagePickerController.InfoKey.editedImage] as! UIImage
        image.image = imagenSelected
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}

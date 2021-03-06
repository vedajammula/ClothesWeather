//
//  ViewController.swift
//  Weather
//
//  Created by veda jammula on 7/23/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import UIKit

class CreateClosetViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var hiddenMessage: UILabel!
    
    
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var textfield: UITextField!
    
    // MARK: - Properties
    var receivedImage : UIImage?
    var selectedPriority : String?
    var priorityTypes = ["", "Shirt", "Sweater" , "Jacket", "Shorts", "Leggings", "Jeans", "Dress", "Accessories", "Shoes"]
    
    
    
    
    

    // MARK: - View Life Cycle Methods
    override func viewDidLoad() {
        myImageView.layer.cornerRadius = 4
        myImageView.layer.masksToBounds = true
        super.viewDidLoad()
        createPickerView()
        dismissPickerView()
        setupView()
        
    }
    
 
    // MARK: - Methods
    
    func createPickerView() {
        
        let pickerView = UIPickerView()
        pickerView.delegate = self
        textfield.inputView = pickerView
        
    }
    
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textfield.inputAccessoryView = toolBar
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let fixedImageOrientation = fixOrientation(img: image)
            
            myImageView.image = fixedImageOrientation
            receivedImage = fixedImageOrientation
        
        } else {
            //error message
        }
        self.dismiss(animated: true, completion: nil)
    }
    private func fixOrientation(img: UIImage) -> UIImage {
        if (img.imageOrientation == UIImageOrientation.up) { return img }
        
        UIGraphicsBeginImageContextWithOptions(img.size, false, img.scale)
        let rect = CGRect(x: 0, y: 0, width: img.size.width, height: img.size.height)
        img.draw(in: rect)
        
        let normalizedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        return normalizedImage
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    // MARK: - IBActions
    
    @IBAction func takePhoto(_ sender: Any) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.camera
        image.allowsEditing = false
        self.present(image, animated: true, completion: nil)
    }
    @IBAction func importImage(_ sender: Any) {
        
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        self.present(image, animated: true)
    }
    @IBOutlet weak var roundedCorner: UIButton!
    
    @IBOutlet weak var importClothingCorner: UIButton!
    func setupView() {
        roundedCorner.layer.cornerRadius = 14
        roundedCorner.layer.masksToBounds = true
        importClothingCorner.layer.cornerRadius = 14
        importClothingCorner.layer.masksToBounds = true
        
    }
    @IBAction func addToCloset(_ sender: Any) {
        
        if receivedImage == nil {
            //TODO: use this class, UIAlertController, to send a message to the user
            hiddenMessage.alpha = 1
        } else if selectedPriority == nil {
            //TODO: use this class, UIAlertController, to send a message to the user
                hiddenMessage.alpha = 1
            
        } else {
            hiddenMessage.alpha = 0

            let newImage = CoreDataHelper.newImage()
            newImage.image = receivedImage!
            newImage.category = selectedPriority!

            CoreDataHelper.save()
            self.navigationController?.popViewController(animated: true)
            print("Pressed Add to Closet")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addToClosetSegue" {
            let destinationVC = segue.destination as! HomePageViewController
        }
    }
}
// MARK: - PickerView Delegate & DataSource Methods
extension CreateClosetViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return priorityTypes.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return priorityTypes[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedPriority = priorityTypes[row]
        textfield.text = selectedPriority
    }
}
// ===========
extension UIImage {
    var jpeg: Data? {
        return UIImageJPEGRepresentation(self, 1)   // QUALITY min = 0 / max = 1
    }
    var png: Data? {
        return UIImagePNGRepresentation(self)
    }
}

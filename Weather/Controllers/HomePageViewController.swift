//
//  HomePageViewController.swift
//  Weather
//
//  Created by veda jammula on 7/25/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//
import UIKit
import CoreData


class HomePageViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    // MARK: - Properties
    var imageObjects = [ImageWithAttributes]()
    
    var clothesForCategory = [ImageWithAttributes]() { // new datasource for collectionView
        didSet{
            collectionView.reloadData()
        }
    }
    
    var editModeOn: Bool = false
    var categoriesArray = ["Shirt", "Sweater" , "Shorts", "Jeans","Leggings","Jacket", "Dress", "Jewelry", "Shoes", "Other"]
    var picker = UIPickerView()
    
    func filterImagesFromSelectedCategory() {
        // filter  items in imageObjects and append them into the collectionview Array (clothes for category)
        guard textFieldPicker.text!.isEmpty == false else { return }
        
        let selectedCategory = picker.selectedRow(inComponent: 0)
        var filteredArray = [ImageWithAttributes]()
        for data in imageObjects {
            if data.category == categoriesArray[selectedCategory] {
                filteredArray.append(data)
            }
        }
        
        clothesForCategory = filteredArray
    }
  
    @objc func dismissKeyboard() {
        view.endEditing(true)
        
        let selectedCategory = picker.selectedRow(inComponent: 0)
        textFieldPicker.text = categoriesArray[selectedCategory]
        //user selected a category and pressed done
        self.filterImagesFromSelectedCategory()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissPickerView()
        picker.delegate = self
        picker.dataSource = self
        textFieldPicker.inputView = picker
    }
    func dismissPickerView() {
        let toolBar = UIToolbar()
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.dismissKeyboard))
        toolBar.setItems([doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        textFieldPicker.inputAccessoryView = toolBar
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return categoriesArray.count
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        textFieldPicker.text = categoriesArray[row]
        
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return categoriesArray[row]
    }

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var textFieldPicker: UITextField!
    @IBOutlet weak var collectionView: UICollectionView!

    
    // MARK: - View Life Cycle Methods

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        imageObjects = CoreDataHelper.retrieveImages()
        filterImagesFromSelectedCategory()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        self.dismissKeyboard()
    }
    //MARK: - Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //addButtonBarItem.isEnabled = !editing
        editModeOn = !editModeOn
        collectionView.reloadData()
    }
    
    // MARK: - IBActions
}


// MARK: - CollectionView Delegate & DataSource Methods
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clothesForCategory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.isEditing = self.editModeOn
        cell.imageView.image = clothesForCategory[indexPath.row].image
        // Cell imageview content mode down below
        cell.imageView.contentMode = .scaleAspectFill
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
   

}

extension HomePageViewController : ImageCollectionViewCellDelegate {
    func delete(indexPath: IndexPath) {
        CoreDataHelper.delete(freshImage: clothesForCategory[indexPath.item])
        clothesForCategory.remove(at: indexPath.row)
        print("Pressed delete")
        collectionView.reloadData()
        CoreDataHelper.save()
    
    }
    
}





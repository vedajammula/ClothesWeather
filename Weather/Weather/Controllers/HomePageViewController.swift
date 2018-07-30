//
//  HomePageViewController.swift
//  Weather
//
//  Created by veda jammula on 7/25/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//
import UIKit
import CoreData

class HomePageViewController: UIViewController {
    
    // MARK: - Properties
    var imageObjects = [ImageWithAttributes]() {
        didSet{
            collectionView.reloadData()
        }
    }

    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: - View Life Cycle Methods
   
    override func viewDidLoad() {
        
        imageObjects = CoreDataHelper.retrieveImages()

        super.viewDidLoad()
        // Fix CoreDataHelper
        // Follow notes app to retrieve and save data
        // Remove lines below

    }
    
    // MARK: - IBActions

//    func saveImage(imageName: String){
//        //create an instance of the FileManager
//        let fileManager = FileManager.default
//        //get the image path
//        let imagePath = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(imageName)
//        //get the image we took with camera
//        let image = imageView.image!
//        //get the PNG data for this image
//        let data = UIImagePNGRepresentation(image)
//        //store it in the document directory    fileManager.createFile(atPath: imagePath as String, contents: data, attributes: nil)
//    }
}

// MARK: - CollectionView Delegate & DataSource Methods
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(data: imageObjects[indexPath.row].image!)
        
        return cell
    }
   

}





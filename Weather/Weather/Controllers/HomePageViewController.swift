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

    var editModeOn: Bool = false
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBAction func unwindWithSegue(_ segue: UIStoryboardSegue) {
        
    }
    
    // MARK: - View Life Cycle Methods
   
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imageObjects = CoreDataHelper.retrieveImages()
        navigationItem.leftBarButtonItem = editButtonItem
        
    }
    //MARK: - Delete Items
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        //addButtonBarItem.isEnabled = !editing
        editModeOn = !editModeOn
        collectionView.reloadData()
//        if let indexPaths = collectionView?.indexPathsForVisibleItems {
//            for indexPath in indexPaths {
//                if let cell = collectionView?.cellForItem(at: indexPath) as! ImageCollectionViewCell? {
//                    cell.isEditing = editing
//                }
//            }
//        }
    }
    
    // MARK: - IBActions
}

// MARK: - CollectionView Delegate & DataSource Methods
extension HomePageViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageObjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.isEditing = self.editModeOn
        cell.imageView.image = UIImage(data: imageObjects[indexPath.row].image!)
        // Cell imageview content mode down below
        cell.imageView.contentMode = .scaleAspectFill
        cell.indexPath = indexPath
        cell.delegate = self
        return cell
    }
   

}

extension HomePageViewController : ImageCollectionViewCellDelegate {
    func delete(indexPath: IndexPath) {
        CoreDataHelper.delete(freshImage: imageObjects[indexPath.item])
        imageObjects.remove(at: indexPath.row)
        print("Pressed delete")
        collectionView.reloadData()
        CoreDataHelper.saveImage()
    
    }
    
//    func delete(cell: ImageCollectionViewCell) {
//        if let indexPath = collectionView?.indexPath(for: cell) {
//       //     photoCategories[indexPath.section].imageNames
//
//            collectionView?.deleteItems(at: [indexPath])
//        }
//    }
}





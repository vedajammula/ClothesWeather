//
//  CoreDataHelper.swift
//  Weather
//
//  Created by veda jammula on 7/26/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import UIKit
import CoreData

CoreDataHelper.doSomething()

let helper = CoreDataHelper()
helper.doSomething()

static func newImage() -> Image {
    let image = NSEntityDescription.insertNewObject(forEntityName: "ImageWithAttributes", into: context) as! ImageWithAttributes
    
    return note
}

struct CoreDataHelper {
    static let context: NSManagedObjectContext = {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            fatalError()
        }
        
        let persistentContainer = appDelegate.persistentContainer
        let context = persistentContainer.viewContext
        
        return context
    }()
    
    

//    func newImage() -> Image {
//        let image = NSEntityDescription.insertNewObject(forEntityName: "Image", into: context) as! Image
//
//        return image
//    }
//struct func saveImage() {
//    do {
//        try context.save()
//    } catch let error {
//        print("Could not save \(error.localizedDescription)")
//    }
//}
//
//struct func retrieveImages() -> [Image] {
//    do {
//        let fetchRequest = NSFetchRequest<Image>(entityName: "Image")
//        let results = try context.fetch(fetchRequest)
//
//        return results
//    } catch let error {
//        print("Could not fetch \(error.localizedDescription)")
//
//        return []
//    }
//}
}

//
//  ImageWithAttributes.swift
//  Weather
//
//  Created by veda jammula on 8/7/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import Foundation
import UIKit.UIImage

extension ImageWithAttributes {
    var image: UIImage {
        get {
            // get url from doc folder
            let fileManager = FileManager.default
            
            let documentUrl = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
            let imageUrl = documentUrl.appendingPathComponent(self.imagePath!)
            // get data from url
            let imageData = try! Data(contentsOf: imageUrl)
            let image = UIImage(data: imageData)!
            
            //get UIImage from data
            return image
        }
        set {
            //get new value
            let newImage = newValue
            // create a file name
            let filePath = String(Date().timeIntervalSince1970)
            //get document URL
            let fileManager = FileManager.default
            let documentUrl = fileManager.urls(for: FileManager.SearchPathDirectory.documentDirectory, in: FileManager.SearchPathDomainMask.userDomainMask).first!
            //append file name to doc URL
            let imagePath = documentUrl.appendingPathComponent("\(filePath).jpg")
            //change image to data
            let imageData = newImage.jpeg!
            // store data at URL
            try! imageData.write(to: imagePath, options: Data.WritingOptions.atomic)
            //update imagePath
            self.imagePath = imagePath.lastPathComponent
        }
        
    }
    
}




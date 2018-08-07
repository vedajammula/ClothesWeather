//
//  FinalOutfitViewController.swift
//  Weather
//
//  Created by veda jammula on 8/2/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import Foundation
import UIKit
import CoreData
import CoreLocation

class FinalOutfitViewController: UIViewController {
    var currentWeather: Weather?
    let temp = Weather.current?.temperature
    var locManager = CLLocationManager()
    var images = [ImageWithAttributes]()
    
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var jacketImageView: UIImageView!
    @IBOutlet weak var jewlreyImageView: UIImageView!
    @IBOutlet weak var otherImageView: UIImageView!
    @IBAction func refreshButton(_ sender: Any) {
        checkTemperature()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            if let location = currentLocation {
                weatherForLocation(location: location)
            }
        }
        images = CoreDataHelper.retrieveImages()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.checkTemperature()
    }
    func weatherForLocation(location: CLLocation) {
        Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
            if let weatherData = results {
               self.currentWeather = weatherData[0]
                DispatchQueue.main.async {
              //      self.tableView.reloadData()
                    print(self.currentWeather)
                }
            }
        })
    }
    
    func checkTemperature() {
        guard let temp = temp else { return }
        
        // top range
        if temp > 0.0 && temp < 70.0 {
            let top = CoreDataHelper.retrieveImages()
            let clothing = top.filter({$0.category == "Sweater" || $0.category == "Shirt"})
            if !clothing.isEmpty{
            let index = arc4random_uniform(UInt32(clothing.count))
            let imageData = clothing[Int(index)]
                let image = UIImage(data: imageData.image!)
                topImageView.image = image
            }
        
        }
      else if temp > 70.0 {
                let top = CoreDataHelper.retrieveImages()
                let shirt = top.filter({$0.category == "Shirt"})
                if !shirt.isEmpty{
                    let index = arc4random_uniform(UInt32(shirt.count))
                    let imageData = shirt[Int(index)]
                    let image = UIImage(data: imageData.image!)
                    topImageView.image = image
                }
            
        }
        
        if temp > 0.0 && temp < 80.0 {
            let bottom = CoreDataHelper.retrieveImages()
            let jeans = bottom.filter({$0.category == "Jeans" || $0.category == "Leggings"})
            if !jeans.isEmpty{
                let index = arc4random_uniform(UInt32(jeans.count))
                let imageData = jeans[Int(index)]
                let image = UIImage(data: imageData.image!)
                bottomImageView.image = image
            }

        }
        else if temp > 80.0 {
            let bottom = CoreDataHelper.retrieveImages()
           let shorts = bottom.filter({$0.category == "Shorts"})
            if !shorts.isEmpty{
                let index = arc4random_uniform(UInt32(shorts.count))
                let imageData = shorts[Int(index)]
                let image = UIImage(data: imageData.image!)
                bottomImageView.image = image
            }

        }
        if temp > 0.0{
            let feet = CoreDataHelper.retrieveImages()
            let shoes = feet.filter({$0.category == "Shoes"})
            if !shoes.isEmpty{
                let index = arc4random_uniform(UInt32(shoes.count))
                let imageData = shoes[Int(index)]
                let image = UIImage(data: imageData.image!)
                otherImageView.image = image
            }
        
    }
        if temp > 0.0 {
            let fashion = CoreDataHelper.retrieveImages()
            let jewlrey = fashion.filter({$0.category == "Jewlrey"})
            if !jewlrey.isEmpty{
                let index = arc4random_uniform(UInt32(jewlrey.count))
                let imageData = jewlrey[Int(index)]
                let image = UIImage(data: imageData.image!)
                jewlreyImageView.image = image
            }
    
    }
}
}

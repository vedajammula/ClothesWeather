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
    var temp : Double!
    var locManager = CLLocationManager()
    var images = [ImageWithAttributes]()
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var jacketImageView: UIImageView!
    @IBOutlet weak var jewelryImageView: UIImageView!
    @IBOutlet weak var otherImageView: UIImageView!
    @IBAction func refreshButton(_ sender: Any) {
        checkTemperature()
    }
    @IBAction func weatherScreen(_ sender: UIBarButtonItem) {
    }
    
    func setupView() {
        refreshButton.layer.cornerRadius = 14
        refreshButton.layer.masksToBounds = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        topImageView.layer.cornerRadius = 7.5
        topImageView.layer.masksToBounds = true
        
        bottomImageView.layer.cornerRadius = 7.5
        bottomImageView.layer.masksToBounds = true
        
        jacketImageView.layer.cornerRadius = 7.5
        jacketImageView.layer.masksToBounds = true
        
        jewelryImageView.layer.cornerRadius = 7.5
        jewelryImageView.layer.masksToBounds = true
        
        otherImageView.layer.cornerRadius = 7.5
        otherImageView.layer.masksToBounds = true
        
        setupView()
        locManager.requestWhenInUseAuthorization()
        var currentLocation: CLLocation!
        
        if( CLLocationManager.authorizationStatus() == .authorizedWhenInUse ||
            CLLocationManager.authorizationStatus() ==  .authorizedAlways){
            
            currentLocation = locManager.location
            if let location = currentLocation {
                weatherForLocation(location: location)
            }
        }
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
          images = CoreDataHelper.retrieveImages()
            self.checkTemperature()
    }
    func weatherForLocation(location: CLLocation) {
        Weather.forecast(withLocation: location.coordinate, completion: { (results: [Weather]?) in
            if let weatherData = results {
                self.currentWeather = weatherData[0]
                DispatchQueue.main.async {
                    //      self.tableView.reloadData()
                    print(self.currentWeather!)
                    Weather.setCurrentWeather(weather: self.currentWeather!)
                    self.checkTemperature()
                }
            }
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if Weather.current != nil{
        self.checkTemperature()
        }else{
              var currentLocation: CLLocation!
            currentLocation = locManager.location
            if let location = currentLocation {
                weatherForLocation(location: location)
            }
        }
        
    }
    
    func checkTemperature() {
        temp = Weather.current?.temperature
        guard let temp = temp else { return }
        
        // top range
        if temp > 0.0 && temp < 70.0 {
            let top = CoreDataHelper.retrieveImages()
            let clothing = top.filter({$0.category == "Sweater" || $0.category == "Shirt"})
            if !clothing.isEmpty{
                let index = arc4random_uniform(UInt32(clothing.count))
                let imageData = clothing[Int(index)]
                let image = imageData.image
                topImageView.image = image
            }
            
        }
        else if temp > 70.0 {
            let top = CoreDataHelper.retrieveImages()
            let shirt = top.filter({$0.category == "Shirt"})
            if !shirt.isEmpty{
                let index = arc4random_uniform(UInt32(shirt.count))
                let imageData = shirt[Int(index)]
                let image = imageData.image
                topImageView.image = image
            }
            
        }
        if temp > 0.0 && temp < 80.0 {
            let bottom = CoreDataHelper.retrieveImages()
            let jeans = bottom.filter({$0.category == "Jeans" || $0.category == "Leggings"})
            if !jeans.isEmpty{
                let index = arc4random_uniform(UInt32(jeans.count))
                let imageData = jeans[Int(index)]
                let image = imageData.image
                bottomImageView.image = image
            }
            
        }
        else if temp > 80.0 {
            let bottom = CoreDataHelper.retrieveImages()
            let shorts = bottom.filter({$0.category == "Shorts"})
            if !shorts.isEmpty{
                let index = arc4random_uniform(UInt32(shorts.count))
                let imageData = shorts[Int(index)]
                let image = imageData.image
                bottomImageView.image = image
            }
            
        }
        if temp > 0.0{
            let feet = CoreDataHelper.retrieveImages()
            let shoes = feet.filter({$0.category == "Shoes"})
            if !shoes.isEmpty{
                let index = arc4random_uniform(UInt32(shoes.count))
                let imageData = shoes[Int(index)]
                let image = imageData.image
                otherImageView.image = image
            }
            
        }
        if temp > 0.0 {
            let fashion = CoreDataHelper.retrieveImages()
            let jewelry = fashion.filter({$0.category == "Accessories"})
            if !jewelry.isEmpty{
                let index = arc4random_uniform(UInt32(jewelry.count))
                let imageData = jewelry[Int(index)]
                let image = imageData.image
                jewelryImageView.image = image
            }
            
        }
        if temp > 0.0 && temp < 75{
            let overall = CoreDataHelper.retrieveImages()
            let jacket = overall.filter({$0.category == "Jacket"})
            if !jacket.isEmpty{
                let index = arc4random_uniform(UInt32(jacket.count))
                let imageData = jacket[Int(index)]
                let image = imageData.image
                jacketImageView.image = image
            }
        }
    }
   
}


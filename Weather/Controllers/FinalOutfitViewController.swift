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
    
    @IBOutlet weak var jewlreyImageView: UIImageView!
    @IBOutlet weak var otherImageView: UIImageView!
    
    
    
    
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
        
        // sweather range
        if temp < 100.0 && temp > 40.0 {
            let top = CoreDataHelper.retrieveImages()
            let sweater = top.filter({$0.category == "Sweater"})
            if !sweater.isEmpty{
            let index = arc4random_uniform(UInt32(sweater.count))
            let imageData = sweater[Int(index)]
                let image = UIImage(data: imageData.image!)
                topImageView.image = image
            }
            
            else {
                //create alert view
            }
            //display sweater image
            //display jeans image
        }
 //       else if {}
    }
   
    
    
    
    
    
}


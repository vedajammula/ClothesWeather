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
        if temp < 40.0 && temp > 50.0 {
            
            //display sweater image
            //display jeans image
        }
    }
   
    
    
    
    
    
}


//
//  Weather.swift
//  Weather
//
//  Created by veda jammula on 7/24/18.
//  Copyright © 2018 Veda Jammula. All rights reserved.
//

import Foundation
import CoreLocation

struct Weather: Codable {
    let summary:String
    let icon:String
    let temperature:Double
    
    enum SerializationError:Error {
        case missing(String)
        case invalid(String, Any)
    }
    
    init(summary: String, temperature: Double, icon: String) {
        self.summary = summary
        self.temperature = temperature
        self.icon = icon
    }
    
    
    
    init(json:[String:Any]) throws {
        guard let summary = json["summary"] as? String else {throw SerializationError.missing("summary is missing")}
        
        guard let icon = json["icon"] as? String else {throw SerializationError.missing("icon is missing")}
        
        guard let temperature = json["temperatureMax"] as? Double else {throw SerializationError.missing("temp is missing")}
        
        self.summary = summary
        self.icon = icon
        self.temperature = temperature
        
    }
    
    
    static let basePath = "https://api.darksky.net/forecast/c44ba9b82e193e104b55de68718ae6bf/"
    
    static func forecast (withLocation location:CLLocationCoordinate2D, completion: @escaping ([Weather]?) -> ()) {
        
        let url = basePath + "\(location.latitude),\(location.longitude)"
        let request = URLRequest(url: URL(string: url)!)
        
        let task = URLSession.shared.dataTask(with: request) { (data:Data?, response:URLResponse?, error:Error?) in
            
            var forecastArray:[Weather] = []
            
            if let data = data {
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] {
                        if let dailyForecasts = json["daily"] as? [String:Any] {
                            if let dailyData = dailyForecasts["data"] as? [[String:Any]] {
                                for dataPoint in dailyData {
                                    if let weatherObject = try? Weather(json: dataPoint) {
                                        print(weatherObject)
                                        forecastArray.append(weatherObject)
                                    }
                                }
                            }
                        }
                        
                    }
                }catch {
                    print(error.localizedDescription)
                }
                
                completion(forecastArray)
            }
        }
        
        task.resume()
    }
    
    static func setCurrentWeather(weather: Weather){
       
        let weatherData = try! JSONEncoder().encode(weather)
        
        UserDefaults.standard.setValue(weatherData, forKey: "Weather")
    }
    static var current:  Weather?  {
        
        
        if UserDefaults.standard.value(forKey: "Weather") != nil {
            let weatherData = UserDefaults.standard.value(forKey: "Weather") as! Data
            let weather = try! JSONDecoder().decode(Weather.self, from: weatherData)
            return weather
        }
        else{
            return nil
        }
    }
    
}

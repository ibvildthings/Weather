//
//  API.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation
import MapKit


enum WeatherInfoType: String {
    case today = "conditions"
    case tenDays = "forecast10day"
    case dayHourly = "hourly"
}

class WeatherAPI {
    // api key obtained from Wunderground API
    private var API_KEY: String
    
    // user's current location
    private var location: CLLocationCoordinate2D
    
    init(location: CLLocationCoordinate2D, apiKey: String) {
        API_KEY = apiKey
        self.location = location
    }
    
    // download the data for a given weather type
    func getURL(for weatherType: WeatherInfoType) -> URL? {
    
        let urlString = "https://api.wunderground.com/api/\(API_KEY)/\(weatherType.rawValue)/q/\(location.latitude),\(location.longitude).json"
        print(urlString)
        
        guard let url = URL(string: urlString) else { return nil }        
        return url
    }
    
    
    // function to download and return JSON data for the given weather type
    func downloadData(for weatherType: WeatherInfoType, completion: @escaping (_ data: Data?) -> Void) {
        guard let url = getURL(for: weatherType) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            let downloadedData = data
            completion(downloadedData)
        }.resume()
    }
    
    
}



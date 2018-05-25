//
//  ConditionsVM.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation
import MapKit

//class to download data for today
class Today {
    
func downloadData(location: CLLocationCoordinate2D) {
    let weatherAPI: WeatherAPI = WeatherAPI(location: location, apiKey: API_KEY)
    
    weatherAPI.downloadData(for: .today) { (data) in
        do {
            let dayHourlyData = try JSONDecoder().decode(condition.self, from: data!)
            print(dayHourlyData)
        }
        catch {
            print(error)
        }
    }
} // end downloadData

} // end class

//
//  ForecastHourlyVM.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation
import MapKit

//class to download data for the next 10 days, hourly
class DayHourly {

func downloadData(location: CLLocationCoordinate2D) {
    let weatherAPI: WeatherAPI = WeatherAPI(location: location, apiKey: API_KEY)
    
    weatherAPI.downloadData(for: .dayHourly) { (data) in
        do {
            let dayHourlyData = try JSONDecoder().decode(containerHourly.self, from: data!)
            print(dayHourlyData)
        }
        catch {
            print(error)
            }
    }
} // end downloadData

} // end class

//
//  ForecastHourly.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

// This stuct is used to decode the downloaded JSON object

struct containerHourly: Decodable {
    var hours: [forecastHourly]
    //Coding keys
    enum CodingKeys: String, CodingKey {
        case hourly_forecast = "hourly_forecast"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        hours = try container.decode([forecastHourly].self, forKey: .hourly_forecast)
    }
}


struct forecastHourly: Decodable {
    var civil: String?
    var condition: String?
    var icon: String?
    var temperature: String?
    
    enum CodingKeys: String, CodingKey {
        case FCTTIME = "FCTTIME"
        case temp = "temp"
        case civil = "civil"
        case condition = "condition"
        case icon = "icon"
        case temperature = "english"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        condition = try container.decode(String.self, forKey: .condition)
        icon = try container.decode(String.self, forKey: .icon)
        
        let FCTTIME = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .FCTTIME)
        civil = try FCTTIME.decode(String.self, forKey: .civil)
        
        let temp = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .temp)
        temperature = try temp.decode(String.self, forKey: .temperature)
        
    }
}



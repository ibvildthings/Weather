//
//  ForecastDayModel.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//


struct container: Decodable {
    var days: [forecastDay]
    //Coding keys
    enum CodingKeys: String, CodingKey {
        case forecast = "forecast"
        case txt_forecast = "txt_forecast"
        case forecastday = "forecastday"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let forecast = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .forecast)
        let txt_forecast = try forecast.nestedContainer(keyedBy: CodingKeys.self, forKey: .txt_forecast)
        
        days = try txt_forecast.decode([forecastDay].self, forKey: .forecastday)
    }
}

struct forecastDay: Decodable {
    var period: Int?
    var icon: String?
    var title: String?
    var fcttext: String?
}





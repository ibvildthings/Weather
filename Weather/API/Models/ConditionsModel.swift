//
//  ConditionsModel.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

struct condition: Decodable {
    var location: String?
    var temperature: Double?
    var temperatureString: String? {
        return "\(temperature!) F"
    }
    
    var feelsLike: String?
    var feelsLikeString: String? {
        return "\(feelsLike!) F"
    }
    var weather: String?
    var icon: String?
    
    
    
    //Coding keys
    enum CodingKeys: String, CodingKey {
        case currentObservations = "current_observation"
        case displayLocation = "display_location"
        case location = "full"
        case temperature = "temp_f"
        case feelsLike = "feelslike_f"
        case weather = "weather"
        case icon = "icon"
    }
    
    // Decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let currentObservations = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .currentObservations)
        let displayLocation = try currentObservations.nestedContainer(keyedBy: CodingKeys.self, forKey: .displayLocation)
        location = try displayLocation.decode(String.self, forKey: .location)
        
        temperature = try currentObservations.decode(Double.self, forKey: .temperature)
        
        feelsLike = try currentObservations.decode(String.self, forKey: .feelsLike)
        
        weather = try currentObservations.decode(String.self, forKey: .weather)
        
        icon = try currentObservations.decode(String.self, forKey: .icon)
    }
}

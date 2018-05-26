//
//  Constants.swift
//  Weather
//
//  Created by Pritesh Desai on 5/24/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import Foundation

// api key obtained from Wunderground API
var API_KEY = "bccc076c8fef97e8"


// get url for icon
func getIconURL(for icon: String?) -> String {
    return "https://icons.wxug.com/i/c/i/\(icon!).gif"
}

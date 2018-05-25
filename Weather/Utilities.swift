//
//  Utilities.swift
//  Weather
//
//  Created by Pritesh Desai on 5/25/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit
//utility function to download images async
extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        print(imgURLString)
        guard let imageURL = URL(string: imgURLString!) else {
            self.image = UIImage()
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                print("Loading weather icon")
                self.image = UIImage(data: data!)
            }
        }
    }
    
}

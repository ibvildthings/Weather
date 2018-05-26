//
//  Utilities.swift
//  Weather
//
//  Created by Pritesh Desai on 5/25/18.
//  Copyright © 2018 Little Maxima LLC. All rights reserved.
//

import UIKit
// utility function to download images async
extension UIImageView {
    
    func setCustomImage(_ imgURLString: String?) {
        guard let imageURL = URL(string: imgURLString!) else {
            self.image = UIImage(named: "loading.png")
            return
        }
        DispatchQueue.global().async {
            let data = try? Data(contentsOf: imageURL)
            DispatchQueue.main.async {
                self.image = data != nil ? UIImage(data: data!) : UIImage(named: "loading.png")
            }
        }
    }
    
}

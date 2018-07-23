//
//  HeightSlider.swift
//  mealify
//
//  Created by Juey on 2018-07-22.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

@IBDesignable
class HeightSlider: UISlider {
    
    // customize a thumbimage
    @IBInspectable var thumbImage: UIImage? {
        didSet {
            setThumbImage(thumbImage, for: .normal)
        }
    }
    
    // customize a minimum track image
    @IBInspectable var minTrackImage: UIImage? {
        didSet {
            setMinimumTrackImage(minTrackImage, for: .normal)
        }
    }
    
    // customize a maximum track image
    @IBInspectable var maxTrackImage: UIImage? {
        didSet {
            setMaximumTrackImage(maxTrackImage, for: .normal)
        }
    }
    
}

//
//  MeasureConversion.swift
//  mealify
//
//  Created by vincent on 2018-07-25.
//  Team name: Meal Mules
//  Changes made: Added measure conversion object
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

//TODO:
class MeasureConversion {
    
    //Properties of the measure.
    var measureID: Int
    var foodID: Int
    var conversionFactorValue: Double
    
    
    //Init with all variales
    init(foodID: Int, measureID : Int, conversionFactorValue: Double){
        
        self.measureID = measureID
        self.foodID = foodID
        self.conversionFactorValue = conversionFactorValue
    }
    
    
}

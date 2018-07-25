//
//  File.swift
//  mealify
//
//  Created by vincent on 2018-07-25.
//  Team name: Meal Mules
//  Changes made: Added measure object
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


//TODO:
class Measure {
    
    //Properties of the measure.
    var measureID: Int
    var measureDescription: String
    
    
    //Init with all variales
    init(measureDescription: String, measureID : Int){
        
        self.measureID = measureID
        self.measureDescription = measureDescription
    }
    
    
}

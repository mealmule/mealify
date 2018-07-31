//
//  NutrientFile.swift
//  mealify
//
//  Created by vincent on 2018-07-28.
//  Team name: Meal Mules
//  Changes made: Added nutrients you should intake daily
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


class NutrientFile{
    
    //Variables
    var measureID: Int
    var measure: String
    var factor: Double
    
    
    //Initialize to this, technically this would never be called
    init(){
        self.factor = 1
        self.measureID = -1
        self.measure = ""
    }
    
    //Initialize to measure
    init (measureID: Int, measure: String, factor: Double){
        
        self.factor = factor
        self.measureID = measureID
        self.measure = measure
    }
    
}

//Comparable for sorting
extension Meal: Comparable {
    public static func <(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.foodID < rhs.foodID
    }
}

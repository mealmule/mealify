//
//  NutrientFile.swift
//  mealify
//
//  Created by vincent on 2018-07-28.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


class NutrientFile{
    
    var measureID: Int
    var measure: String
    var factor: Double
    
    
    init(){
        self.factor = 1
        self.measureID = -1
        self.measure = ""
    }
    
    init (measureID: Int, measure: String, factor: Double){
        
        self.factor = factor
        self.measureID = measureID
        self.measure = measure
    }
    
}

extension Meal: Comparable {
    public static func <(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.foodID < rhs.foodID
    }
}

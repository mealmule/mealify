//
//  NutrientMealInfo.swift
//  mealify
//
//  Created by vincent on 2018-07-15.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

class NutrientMealInfo {
    
    var foodID: Int
    var nutrientID: Int
    var nutrientSourceID: Int
    var nutrientValue: NSNumber
    
    init (foodID: Int, nutrientID: Int, nutrientSourceID: Int, nutrientValue: NSNumber){
        
        self.nutrientID = nutrientID
        self.nutrientSourceID = nutrientSourceID
        self.nutrientValue = nutrientValue
        self.foodID = foodID
  
        
    }
    
    
    
}

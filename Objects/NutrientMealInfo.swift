//
//  NutrientMealInfo.swift
//  mealify
//
//  Created by vincent on 2018-07-15.
//  Team name: Meal Mules
//  Changes made: Added nutrients meal class to communicate between meal and nutrient

//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

class NutrientMealInfo {
    
    //Properties to keep track of which nutrient goes with which food
    //And nutrient value as how many of that nutrient there is
    var foodID: Int
    var nutrientID: Int
    var nutrientSourceID: Int
    var nutrientValue: NSNumber
    
    //Init with all variables in parameter
    init (foodID: Int, nutrientID: Int, nutrientSourceID: Int, nutrientValue: NSNumber){
        
        self.nutrientID = nutrientID
        self.nutrientSourceID = nutrientSourceID
        self.nutrientValue = nutrientValue
        self.foodID = foodID
        
        
    }
    
    
    
}

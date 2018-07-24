//
//  Meal.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added name to get meal name
//                  Added calories, fats, proteins, and carbs
//                  Added nutrients array to keep track of nutrients
//                  Added equatable extention to compare this object
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//


import Foundation


//Class for the meal object
//Name of the meal
//Meal properties includes name, food ID, and nutrients array
//TODO:
class Meal {
    
    //Properties of the meals.
    let name: String
    let foodID: Int
    var nutrients = [NutrientMealInfo]()
    
    
    //Init with all variales
    init(name: String, foodID: Int){
        
        self.name = name
        self.foodID = foodID
        
    }
    
    
    
    //Init with name set to "Food" and everything else set to 0.
    init(){
        
        self.name = "Food"
        self.foodID = 0
        
    }
    
}


extension Meal: Equatable {
    public static func ==(lhs: Meal, rhs: Meal) -> Bool {
        return lhs.foodID == rhs.foodID
    }
}

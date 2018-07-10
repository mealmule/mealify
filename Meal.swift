//
//  Meal.swift
//  Home
//
//  Created by vdy on 2018-06-29.
//  Copyright © 2018 Meal Mules. All rights reserved.
//


import Foundation


//Class for the meal object
//Name of the meal
//TODO: Properties of the meal: Description, nutrients, calories, etc
class Meal {
    
    let name: String
    let calories: Int
    let fats: Int
    let proteins: Int
    let carbs: Int
    
    
    init(name: String, calories: Int, fats: Int, proteins: Int, carbs: Int){
        
        self.name = name
        self.calories = calories
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
        
    }
    
    init(name: String){
        
        self.name = name
        self.calories = 0
        self.fats = 0
        self.proteins = 0
        self.carbs = 0
        
    }
    
    init(){
        
        self.name = "Food"
        self.calories = 0
        self.fats = 0
        self.proteins = 0
        self.carbs = 0
        
    }
    
}

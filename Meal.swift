//
//  Meal.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added name to get meal name
//                  Added calories, fats, proteins, and carbs
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//


import Foundation


//Class for the meal object
//Name of the meal
//Meal properties includes name, calories, fats, proteins, and cars
//TODO:
class Meal {
    
    //Properties of the meals.
    let name: String
    let calories: Int
    let fats: Int
    let proteins: Int
    let carbs: Int
    
    //Init with all variales
    init(name: String, calories: Int, fats: Int, proteins: Int, carbs: Int){
        
        self.name = name
        self.calories = calories
        self.fats = fats
        self.proteins = proteins
        self.carbs = carbs
        
    }
    
    //Init with just name, everything else is set to 0
    init(name: String){
        
        self.name = name
        self.calories = 0
        self.fats = 0
        self.proteins = 0
        self.carbs = 0
        
    }
    
    //Init with name set to "Food" and everything else set to 0.
    init(){
        
        self.name = "Food"
        self.calories = 0
        self.fats = 0
        self.proteins = 0
        self.carbs = 0
        
    }
    
}

//TECHNICALLY WE DONT EVEN NEED THIS
//ILL REMOVE IT ON MONDAY
//
//  Numbers.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added numbers for the home page depending on what day it is
//                Added breakfast, lunch, and dinner arrays
//                added more nutrients, and removed some properties
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


//Create the number class with variables kCals, bCals, lCals, dCals
//kCals is the number of calories recommended for that day,
//bCals is the recommended breakfast calories for that day,
//lCals is the recommended lunch calories for that day,
//dCals is the recommended dinner calories for that day,
class Number {
    
    //Properties
    var kCals: Int
    var bCals: Int
    var lCals: Int
    var dCals: Int
    
    
    //All needed nutrients to display
    var proteins: Double
    var fats : Double
    var carbohydrates: Double
    var moisture: Double
    var iron: Double
    var magnesium: Double
    var vitaminD: Double
    var folate: Double
    
    //Arrays for breakfast, lunch and dinner
    var userMeals = [Meal]()
    
    init(kCals: Int, bCals: Int, lCals: Int, dCals: Int){
        
        self.kCals = kCals
        self.bCals = bCals
        self.lCals = lCals
        self.dCals = dCals
        
        self.proteins = 0
        self.fats = 0
        self.carbohydrates = 0
        self.iron = 0
        self.magnesium = 0
        self.vitaminD = 0
        self.folate = 0
        self.moisture = 0
        
    }
    
    init(proteins: Double, fats: Double, carbohydrates: Double, iron: Double, magnesium: Double, vitaminD: Double, folate: Double, moisuture: Double){
        
        self.kCals = 0
        self.bCals = 0
        self.lCals = 0
        self.dCals = 0
        
        self.proteins = proteins
        self.fats = fats
        self.carbohydrates = carbohydrates
        self.iron = iron
        self.magnesium = magnesium
        self.vitaminD = vitaminD
        self.folate = folate
        self.moisture = moisuture
        
    }
    
    
    
    init(){
        
        self.kCals = 0
        self.bCals = 0
        self.lCals = 0
        self.dCals = 0
        
        self.proteins = 0
        self.fats = 0
        self.carbohydrates = 0
        self.iron = 0
        self.magnesium = 0
        self.vitaminD = 0
        self.folate = 0
        self.moisture = 0
        
        
    }
    
}

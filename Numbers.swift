//
//  Numbers.swift
//  Home
//
//  Numbers displayed on the home page depending on which day it is
//  Created by vdy on 2018-06-29.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


//Create the number class with variables kCals, bCals, lCals, dCals
//kCals is the number of calories recommended for that day,
//bCals is the recommended breakfast calories for that day,
//lCals is the recommended lunch calories for that day,
//dCals is the recommended dinner calories for that day,
class Number {
    
    var kCals: Int
    var bCals: Int
    var lCals: Int
    var dCals: Int
    
    let date: DateN
    
    var breakfastMeals = [Meal]()
    var lunchMeals = [Meal]()
    var dinnerMeals = [Meal]()
    
    init(kCals: Int, bCals: Int, lCals: Int, dCals: Int){
        
        self.kCals = kCals
        self.bCals = bCals
        self.lCals = lCals
        self.dCals = dCals
        
        self.date = DateN()
        
    }
    
    init(kCals: Int, bCals: Int, lCals: Int, dCals: Int, year: Int, month: Int, day: Int){
        
        self.kCals = kCals
        self.bCals = bCals
        self.lCals = lCals
        self.dCals = dCals
        
        self.date = DateN(yy: year, mm: month, dd: day)
        
    }
    
    init(day_before: Bool){
        
        self.kCals = 0
        self.bCals = 0
        self.lCals = 0
        self.dCals = 0
        
        self.date = DateN(yesterday: day_before)
        
    }
    
    init(day_after: Bool){
        
        self.kCals = 0
        self.bCals = 0
        self.lCals = 0
        self.dCals = 0
        
        self.date = DateN(tomorrow: day_after)
        
    }
    
    init(){
        
        self.kCals = 0
        self.bCals = 0
        self.lCals = 0
        self.dCals = 0
        
        self.date = DateN()
        
        
    }
    
}

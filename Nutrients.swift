//
//  Nutrients.swift
//  mealify
//
//  Created by vincent on 2018-07-15.
//  Team name: Meal Mules
//  Changes made: Added nutrients class to keep track of all nutrients

//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


class Nutrients {
    
    var nutrientCode: Int
    var nutrientDecimals: Int
    var nutrientName: String
    var nutrientNameF: String
    var nutrientSymbol: String
    var nutrientUnit: String
    var tagName: String
    
    init (nutrientCode: Int, nutrientDecimals: Int, nutrientName: String, nutrientNameF: String, nutrientSymbol: String, nutrientUnit: String, tagName: String){
        
        self.nutrientCode = nutrientCode
        self.nutrientDecimals = nutrientDecimals
        self.nutrientName = nutrientName
        self.nutrientNameF = nutrientNameF
        self.nutrientSymbol = nutrientSymbol
        self.nutrientUnit = nutrientUnit
        self.tagName = tagName
        
    }
    
 
    
}

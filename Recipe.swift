//
//  Recipe.swift
//  mealify
//
//  Created by vincent on 2018-07-13.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

class Recipe {
    
    var recipeName: String
    var proteins: Float
    var vitaminA: Float
    var vitaminD: Float
    
    init (recipeName: String, proteins: Float, vitaminA: Float, vitaminD: Float){
        
        self.recipeName = recipeName
        self.proteins = proteins
        self.vitaminA = vitaminA
        self.vitaminD = vitaminD
        
    }
    
    init (){
        
        self.recipeName = "Recipe"
        self.proteins = 0.0
        self.vitaminA = 0.0
        self.vitaminD = 0.0
        
    }
    
    
    
}

//
//  UserDaily.swift
//  mealify
//
//  Created by vincent on 2018-07-27.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

class UserDaily{
    
    var gender: String
    var age: Float
    
    var proteinsDaily: Double = 0
    var fatsDaily: Double = 0
    var carbohydratesDaily: Double = 0
    var moistureDaily: Double = 0
    var ironDaily: Double = 0
    var magnesiumDaily: Double = 0
    var vitaminDDaily: Double = 0
    var folateDaily: Double = 0
  
    
    init (){
        
        self.gender = "male"
        self.age = 20
        
        self.proteinsDaily = 47
        self.fatsDaily = 40
        self.carbohydratesDaily = 130
        self.moistureDaily = 3000
        self.ironDaily = 10
        self.magnesiumDaily = 375
        self.vitaminDDaily = 600
        self.folateDaily = 400
        
    }
    
    init (gender: String, age: Float){
        
        self.gender = gender
        self.age = age
        
        
        if gender == "male"{
            
            if age <= 0.5 && age >= 0{
                
                self.proteinsDaily = 9.1
                self.fatsDaily = 31
                self.carbohydratesDaily = 60
                self.moistureDaily = 700
                self.ironDaily = 0.27
                self.magnesiumDaily = 30
                self.vitaminDDaily = 400
                self.folateDaily = 65
                
            }
            else if age > 0.5 && age <= 1{
                
                self.proteinsDaily = 11
                self.fatsDaily = 30
                self.carbohydratesDaily = 95
                self.moistureDaily = 800
                self.ironDaily = 11
                self.magnesiumDaily = 75
                self.vitaminDDaily = 400
                self.folateDaily = 80
                
            }
            else if age > 1 && age <= 3{
                
                self.proteinsDaily = 13
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 1300
                self.ironDaily = 7
                self.magnesiumDaily = 80
                self.vitaminDDaily = 600
                self.folateDaily = 150
                
            }
            else if age > 3 && age <= 8{
                
                self.proteinsDaily = 19
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 1700
                self.ironDaily = 10
                self.magnesiumDaily = 130
                self.vitaminDDaily = 600
                self.folateDaily = 200
                
            }
            else if age > 8 && age <= 13{
                
                self.proteinsDaily = 34
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2400
                self.ironDaily = 8
                self.magnesiumDaily = 240
                self.vitaminDDaily = 600
                self.folateDaily = 300
                
            }
            else if age > 13 && age <= 18{
                
                self.proteinsDaily = 52
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 3300
                self.ironDaily = 11
                self.magnesiumDaily = 410
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 18 && age <= 30{
                
                self.proteinsDaily = 56
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 3700
                self.ironDaily = 8
                self.magnesiumDaily = 400
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 30 && age <= 50{
                
                self.proteinsDaily = 56
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 3700
                self.ironDaily = 8
                self.magnesiumDaily = 420
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 50 && age <= 70{
                
                self.proteinsDaily = 56
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 3700
                self.ironDaily = 8
                self.magnesiumDaily = 420
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 70{
                
                self.proteinsDaily = 56
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 3700
                self.ironDaily = 8
                self.magnesiumDaily = 420
                self.vitaminDDaily = 800
                self.folateDaily = 400
                
            }
            
            
        }
        else{
            
            if age <= 0.5 && age >= 0{
                
                self.proteinsDaily = 9.1
                self.fatsDaily = 31
                self.carbohydratesDaily = 60
                self.moistureDaily = 700
                self.ironDaily = 0.27
                self.magnesiumDaily = 30
                self.vitaminDDaily = 400
                self.folateDaily = 65
                
            }
            else if age > 0.5 && age <= 1{
                
                self.proteinsDaily = 11
                self.fatsDaily = 30
                self.carbohydratesDaily = 95
                self.moistureDaily = 800
                self.ironDaily = 11
                self.magnesiumDaily = 75
                self.vitaminDDaily = 400
                self.folateDaily = 80
                
            }
            else if age > 1 && age <= 3{
                
                self.proteinsDaily = 13
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 1300
                self.ironDaily = 7
                self.magnesiumDaily = 80
                self.vitaminDDaily = 600
                self.folateDaily = 150
                
            }
            else if age > 3 && age <= 8{
                
                self.proteinsDaily = 19
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 1700
                self.ironDaily = 10
                self.magnesiumDaily = 130
                self.vitaminDDaily = 600
                self.folateDaily = 200
                
            }
            else if age > 8 && age <= 13{
                
                self.proteinsDaily = 34
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2100
                self.ironDaily = 8
                self.magnesiumDaily = 240
                self.vitaminDDaily = 600
                self.folateDaily = 300
                
            }
            else if age > 13 && age <= 18{
                
                self.proteinsDaily = 46
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2300
                self.ironDaily = 15
                self.magnesiumDaily = 360
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 18 && age <= 30{
                
                self.proteinsDaily = 46
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2700
                self.ironDaily = 18
                self.magnesiumDaily = 310
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 30 && age <= 50{
                
                self.proteinsDaily = 46
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2700
                self.ironDaily = 18
                self.magnesiumDaily = 320
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 50 && age <= 70{
                
                self.proteinsDaily = 46
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2700
                self.ironDaily = 8
                self.magnesiumDaily = 320
                self.vitaminDDaily = 600
                self.folateDaily = 400
                
            }
            else if age > 70{
                
                self.proteinsDaily = 46
                self.fatsDaily = 30
                self.carbohydratesDaily = 130
                self.moistureDaily = 2700
                self.ironDaily = 8
                self.magnesiumDaily = 320
                self.vitaminDDaily = 800
                self.folateDaily = 400
                
            }
            
        }
        
        self.proteinsDaily = 47
        self.fatsDaily = 40
        self.carbohydratesDaily = 130
        self.moistureDaily = 3000
        self.ironDaily = 10
        self.magnesiumDaily = 375
        self.vitaminDDaily = 600
        self.folateDaily = 400
        
    }
    
    
    
}

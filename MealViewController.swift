//
//  MealViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added Name, calories, proteins, fats, carbohydrates of the meal to display
//                Added segue to home page with updated numbers
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class MealViewController: UIViewController {
    
    //Properties
    var meal = Meal()
    var mealNutrients: String = ""
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var mealDescription: UITextView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        
        foodName.text = meal.name
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.7
        foodName.numberOfLines = 0
        
        for i in meal.nutrients{
            
            for k in nutrients{
                
                if i.nutrientID == k.nutrientCode{
                    let temp = Double(round(Double(truncating: i.nutrientValue) * 100) / 100)
                    mealNutrients += k.nutrientName + ": " + String("\(temp)") + k.nutrientUnit + "\n \n"
                }
                
            }
            
        }
        
        mealDescription.text = mealNutrients
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //Dest is the Home view. Change properties below
        //If the identifier goes back to view controller, then update the foods within that view controller
        if segue.identifier == "updateFoods"{
                
            //Check the days of the app, add meal to array depending on day and types of meal
            if day == 0{
                today.userMeals += [meal]
            } else if day == -1{
                yesterday.userMeals += [meal]
            } else if day == 1{
                tomorrow.userMeals += [meal]
            }
        }
            
         
    }
    
    
}

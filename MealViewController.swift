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
    var mealType: String = ""
    
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var foodCalories: UILabel!
    @IBOutlet weak var foodFats: UILabel!
    @IBOutlet weak var foodProteins: UILabel!
    @IBOutlet weak var foodCarbohydrates: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

        foodName.text = meal.name
       // foodCalories.text = "Calories: " + String(meal.calories)
        foodFats.text = "Fats: " + String(meal.fats)
        foodProteins.text = "Proteins: " + String(meal.proteins)
        foodCarbohydrates.text = "Carbohydrates: " + String(meal.carbs)
        
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
            print(mealType)
            //If the breakfast section was pressed before, then update the breakfast foods
            if mealType == "Breakfasts"{
                
                //Check the days of the app, add meal to array depending on day and types of meal
                if day == 0{
                    today.breakfastMeals += [meal]
                } else if day == -1{
                    yesterday.breakfastMeals += [meal]
                } else if day == 1{
                    tomorrow.breakfastMeals += [meal]
                }
            }
                //If the breakfast section was pressed before, then update the breakfast foods
            else if mealType == "Lunches"{
                
                //Check the days of the app, add meal to array depending on day and types of meal
                if day == 0{
                    today.lunchMeals += [meal]
                } else if day == -1{
                    yesterday.lunchMeals += [meal]
                } else if day == 1{
                    tomorrow.lunchMeals += [meal]
                }
            }
                //If the breakfast section was pressed before, then update the breakfast foods
            else if mealType == "Dinners"{
                
                //Check the days of the app, add meal to array depending on day and types of meal
                if day == 0{
                    today.dinnerMeals += [meal]
                } else if day == -1{
                    yesterday.dinnerMeals += [meal]
                } else if day == 1{
                    tomorrow.dinnerMeals += [meal]
                }
            }
            
        }
    }
 

}

//
//  TodayMealViewController.swift
//  mealify
//
//  Created by vincent on 2018-07-17.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class TodayMealViewController: UIViewController {

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
        if segue.identifier == "updateRemovedFoods"{
            
            //Check the days of the app, add meal to array depending on day and types of meal
  
            let itemToRemove = meal
            if let i = today.userMeals.index(of: itemToRemove) {
                today.userMeals.remove(at: i)
            }
       
        }
        
        
    }

}

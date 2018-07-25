//
//  TodayMealViewController.swift
//  mealify
//
//  Created by vincent on 2018-07-17.
//  Team name: Meal Mules
//  Changes made: Added table that contains all user eaten for given day foods
//                Added Search bar to search for any foods
//                Added segue to page where it displays the meal
//                Added database for meals
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


//This class is similar to mealviewcontroller, except it displays the food you've added
//Instead of the food you want to add
class TodayMealViewController: UIViewController {
    
    //Properties
    
    //Get number of meals user currently have for the day
    var numberOfDayMeals = 0
    
    //Create a meal to hold the meal selected in the meal table view controller
    var meal = Meal()
    
    //Create a string to display for the users
    //This string will be of all nutrients the meal has
    var mealNutrients: String = ""
    
    //Firebase reference
    var ref: DatabaseReference?
    
    
    //Variables for all nutrients
    //The variables are here so that we can keep track of each nutrient inside a variable
    //so that it will be easier to add these nutrients into firebase.
    var proteins: Double = 0
    var fats : Double = 0
    var carbohydrates: Double = 0
    var moisture: Double = 0
    var iron: Double = 0
    var magnesium: Double = 0
    var vitaminD: Double = 0
    var folate: Double = 0
    
    //Label for food name and meal nutrients
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var mealDescription: UITextView!
    
    
    //Rounding function that will round to 2 decimal places
    private func roundOff(toRound: Double) -> Double{
        return Double(round(toRound * 100) / 100)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Food name properties
        
        
        
        //Set the food title meal to meal name
        foodName.text = meal.name
        
        //Format it so that it will fit on the screen, even when meal has large amount of text
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.7
        foodName.numberOfLines = 0
        
        //Find all meal nutrients, and add them to the meal description string
        for i in meal.nutrients{
            
            //compare it to all the nutrients in the database
            for k in nutrients{
                
                //If there is a match, add it into the string
                if i.nutrientID == k.nutrientCode{
                    
                    //Round it up to 2 digits
                    let temp = Double(round(Double(truncating: i.nutrientValue) * 100) / 100)
                    mealNutrients += k.nutrientName + ": " + String("\(temp)") + k.nutrientUnit + "\n \n"
                    
                    //Keep track of whether it is proteins, fats, carbohydrates, moisture, iron, magnesium, vitaminD, or folate
                    //Then set those values to temp so that it can be added into the database
                    if k.nutrientCode == 203{
                        proteins = temp
                    }
                    else if k.nutrientCode == 204{
                        fats = temp
                    }
                    else if k.nutrientCode == 205{
                        carbohydrates = temp
                    }
                    else if k.nutrientCode == 255{
                        moisture = temp
                    }
                    else if k.nutrientCode == 303{
                        iron = temp
                    }
                    else if k.nutrientCode == 304{
                        magnesium = temp
                    }
                    else if k.nutrientCode == 324{
                        vitaminD = temp
                    }
                    else if k.nutrientCode == 806{
                        folate = temp
                    }
                }
                
                
                
            }
            
        }
        
        //Update meal description
        mealDescription.text = mealNutrients
        
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
            
            //Initialize ref to database reference
            ref = Database.database().reference()
            
            //Find user ID
            let userID = (Auth.auth().currentUser?.uid)!
            
            
            //Delete the meal from the database
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").child(String(meal.mealNumber)).removeValue {error,ref  in
                if error != nil{
                    print("error \(String(describing: error))")
                }
            }
            
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                let currentCarbohydrates = snapDictionary["carbohydrates"]! as! Double
                let currentProteins = snapDictionary["proteins"]! as! Double
                let currentFats = snapDictionary["fats"]! as! Double
                let currentMoisture = snapDictionary["moisture"]! as! Double
                let currentIron = snapDictionary["iron"]! as! Double
                let currentMagnesium = snapDictionary["magnesium"]! as! Double
                let currentVitaminD = snapDictionary["vitaminD"]! as! Double
                let currentFolate = snapDictionary["folate"]! as! Double
                self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": self.roundOff(toRound: currentProteins - self.proteins), "fats": self.roundOff(toRound: currentFats - self.fats), "carbohydrates": self.roundOff(toRound: currentCarbohydrates - self.carbohydrates), "moisture": self.roundOff(toRound: currentMoisture - self.moisture), "iron": self.roundOff(toRound: currentIron - self.iron), "magnesium": self.roundOff(toRound: currentMagnesium - self.magnesium), "vitaminD": self.roundOff(toRound: currentVitaminD - self.vitaminD), "folate": self.roundOff(toRound: currentFolate - self.folate)])
                //
            })
            
        }
        
        
    }
    
}

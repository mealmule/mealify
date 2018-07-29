//
//  MealViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added Name, calories, proteins, fats, carbohydrates of the meal to display
//                Added segue to home page with updated numbers
//                Added more nutrients to display
//                Added Firebase database to transfer user meals into database
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//
//-----TODO-----: Remove nutrients in each meal when adding to database, and instead, add nutrients into user nutrients
//                Add a meal property so that you can add more than one meal

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MealViewController: UIViewController {
    
    //Properties
    
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
    var factor: Double = 0.0
    
    var stringCount: String = ""
    
    
    //Label for food name and meal nutrients
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var mealDescription: UITextView!
    @IBOutlet weak var measureAmount: UILabel!
    
    //Rounding function that will round to 2 decimal places
    private func roundOff(toRound: Double) -> Double{
        return Double(round(toRound * 100) / 100)
    }
    
    //Todo:
    //*
    //*
    //*
    //Back button functionality.
    //Give functionality to the back button so whenever it is pressed, it will perform an action
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        //Is popped from the view controller (back button)
        if self.isMovingFromParentViewController {
            
            if self.title == "Recommended Meal"{
                //Hide navigation bar
                self.navigationController?.isNavigationBarHidden = true
            }

        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if self.title == "Recommended Meal"{
            self.navigationController?.isNavigationBarHidden = false
        }
        
        
        //Food name properties
        //Set the food title meal to meal name
        foodName.text = meal.name
        
        //Format it so that it will fit on the screen, even when meal has large amount of text
        foodName.adjustsFontSizeToFitWidth = true
        foodName.minimumScaleFactor = 0.7
        foodName.numberOfLines = 0
        
        measureAmount.adjustsFontSizeToFitWidth = true
        measureAmount.minimumScaleFactor = 0.7
        measureAmount.numberOfLines = 0
        
        measureAmount.text = meal.measure
        factor = meal.factor
        print("FACTOR: " + String(meal.factor))
        
        //Find all meal nutrients, and add them to the meal description string
        for i in meal.nutrients{
            
            //compare it to all the nutrients in the database
            for k in nutrients{
                
                //If there is a match, add it into the string
                if i.nutrientID == k.nutrientCode{
                    
                    //Round it up to 2 digits
                    let temp = Double(round(Double(truncating: i.nutrientValue) * factor * 100) / 100)
                    
                    if i.nutrientID == 806{
                        mealNutrients += k.nutrientName + ": " + String("\(temp)") + "µg" + "\n \n"
                    }
                    else{
                        mealNutrients += k.nutrientName + ": " + String("\(temp)") + k.nutrientUnit + "\n \n"
                    }
                    
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
        if segue.identifier == "updateFoods"{
            
            if self.title == "Recommended Meal"{
                self.navigationController?.isNavigationBarHidden = true
            }
            
            //Check the days of the app, add meal to array depending on day and types of meal
            
            //Initialize ref to database reference
            ref = Database.database().reference()
            
            //Find user ID
            let userID = (Auth.auth().currentUser?.uid)!
            
            
            //Add the new meal into the database with child values
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").child(String(numberOfDayMeals)).setValue(["foodID": meal.foodID, "name": meal.name, "mealNumber": numberOfDayMeals])
            
            
            //Add nutrients into user database
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                //Add all nutrient values into user database, checks if it has protein child first, if it doesn't then it means that the user
                //Doesn't have all the nutrient values
                if snapshot.hasChild("proteins") {
                    
                    
                    //Store all these values so that user can add them to the current nutrient values
                    //This way, the user can add nutrient values to current ones.
                    let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                    let currentCarbohydrates = snapDictionary["carbohydrates"]! as! Double
                    let currentProteins = snapDictionary["proteins"]! as! Double
                    let currentFats = snapDictionary["fats"]! as! Double
                    let currentMoisture = snapDictionary["moisture"]! as! Double
                    let currentIron = snapDictionary["iron"]! as! Double
                    let currentMagnesium = snapDictionary["magnesium"]! as! Double
                    let currentVitaminD = snapDictionary["vitaminD"]! as! Double
                    let currentFolate = snapDictionary["folate"]! as! Double
                    
                    //Update these values in the user database
                    self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": self.roundOff(toRound: currentProteins + self.proteins), "fats": self.roundOff(toRound: currentFats + self.fats), "carbohydrates": self.roundOff(toRound: currentCarbohydrates + self.carbohydrates), "moisture": self.roundOff(toRound:currentMoisture + self.moisture), "iron": self.roundOff(toRound:currentIron + self.iron), "magnesium": self.roundOff(toRound:currentMagnesium + self.magnesium), "vitaminD": self.roundOff(toRound:currentVitaminD + self.vitaminD), "folate": self.roundOff(toRound:currentFolate + self.folate)])
                    
                }
                    //Else create these values in the database.
                else{
                    self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": self.proteins, "fats":  self.fats, "carbohydrates":  self.carbohydrates, "moisture": self.moisture, "iron": self.iron, "magnesium":  self.magnesium, "vitaminD":   self.vitaminD, "folate":  self.folate])
                    //
                }
            })
        }
    }
}

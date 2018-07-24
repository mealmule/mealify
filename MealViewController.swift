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
        if segue.identifier == "updateFoods"{
            
            //Check the days of the app, add meal to array depending on day and types of meal
            
            //Don't need this part
            //today.userMeals += [meal]
            //let dest = segue.destination as! ViewController
            
            //Initialize ref to database reference
            ref = Database.database().reference()
            
            //Find user ID
            let userID = (Auth.auth().currentUser?.uid)!
            
            
            //Add the new meal into the database with child values
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").child(meal.name).setValue(["kCals": 0, "proteins": proteins, "fats": fats, "carbohydrates": carbohydrates, "moisture": moisture, "iron": iron, "magnesium": magnesium, "vitaminD": vitaminD, "folate": folate, "foodID": meal.foodID, "name": meal.name])
            
            
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
                    self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": currentProteins + self.proteins, "fats": currentFats + self.fats, "carbohydrates": currentCarbohydrates + self.carbohydrates, "moisture": currentMoisture + self.moisture, "iron": currentIron + self.iron, "magnesium": currentMagnesium + self.magnesium, "vitaminD": currentVitaminD + self.vitaminD, "folate": currentFolate + self.folate])
                    
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

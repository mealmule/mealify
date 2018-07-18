//
//  MealViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added Name, calories, proteins, fats, carbohydrates of the meal to display
//                Added segue to home page with updated numbers
//                Added more nutrients to display
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class MealViewController: UIViewController {
    
    //Properties
    var meal = Meal()
    var mealNutrients: String = ""
    var ref: DatabaseReference?
    
    var proteins: Double = 0
    var fats : Double = 0
    var carbohydrates: Double = 0
    var moisture: Double = 0
    var iron: Double = 0
    var magnesium: Double = 0
    var vitaminD: Double = 0
    var folate: Double = 0
    
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
            
            today.userMeals += [meal]
            
            let dest = segue.destination as! ViewController
            
            //TODO
            ref = Database.database().reference()
            let userID = (Auth.auth().currentUser?.uid)!
            
            
            //Add the new meal into the database
        self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").child(meal.name).setValue(["kCals": 0, "proteins": proteins, "fats": fats, "carbohydrates": carbohydrates, "moisture": moisture, "iron": iron, "magnesium": magnesium, "vitaminD": vitaminD, "folate": folate, "foodID": meal.foodID, "name": meal.name])
            
            self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                
                
                
                if snapshot.hasChild("proteins") {
                    
                    let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                    let currentCarbohydrates = snapDictionary["carbohydrates"]! as! Double
                    let currentProteins = snapDictionary["proteins"]! as! Double
                    let currentFats = snapDictionary["fats"]! as! Double
                    let currentMoisture = snapDictionary["moisture"]! as! Double
                    let currentIron = snapDictionary["iron"]! as! Double
                    let currentMagnesium = snapDictionary["magnesium"]! as! Double
                    let currentVitaminD = snapDictionary["vitaminD"]! as! Double
                    let currentFolate = snapDictionary["folate"]! as! Double
                    
                    self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": currentProteins + self.proteins, "fats": currentFats + self.fats, "carbohydrates": currentCarbohydrates + self.carbohydrates, "moisture": currentMoisture + self.moisture, "iron": currentIron + self.iron, "magnesium": currentMagnesium + self.magnesium, "vitaminD": currentVitaminD + self.vitaminD, "folate": currentFolate + self.folate])
                    //
                }
                else{
                    self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": self.proteins, "fats":  self.fats, "carbohydrates":  self.carbohydrates, "moisture": self.moisture, "iron": self.iron, "magnesium":  self.magnesium, "vitaminD":   self.vitaminD, "folate":  self.folate])
                    //
                }
            })
            
            
            
          
        }
            
         
    }
    
    
}

//
//  ExploreMealViewController.swift
//  mealify
//
//  Created by Juey on 2018-07-26.
//  Team name: Meal Mules
//  Changes made: Added ability to see user nutrients
//                Added abilitiy to see recommended meals
//  Known bugs: Meal recommend needs to be redone
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase



class ExploreMealViewController: UIViewController {

    
    //Labels
    @IBOutlet weak var userNutrients: UITextView!
    @IBOutlet weak var recMeal: UILabel!
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    //Firebase references
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    //Nurient differences, difference from your current intake and what you should intake
    var proteinsDiff: Double = 0
    var fatsDiff: Double = 0
    var carbohydratesDiff: Double = 0
    var moistureDiff: Double = 0
    var ironDiff: Double = 0
    var magnesiumDiff: Double = 0
    var vitaminDDiff: Double = 0
    var folateDiff: Double = 0
    
    //Get today's number and user info
    var today = Number()
    var userInfo = UserDaily(gender: "male", age: 19)
    
    //Percentage of accuracy needed to recommend meal
    let acc: Double = 0.4 + (Double(Double(arc4random()) / Double(UINT32_MAX)) * 0.30)
    
    //Button to click to recommend meal
    @IBAction func loadRecommended(_ sender: Any) {
        recMeal.text = "Loading..."
        recommend()
    }
    
    //TODO:
    //*
    //*
    //*
    //Loads all nutrients from database
    private func loadNutrients(){
    
        ref = Database.database().reference()
        
        //Get the userID, and remove all elements in today.userMeals
        let userID = (Auth.auth().currentUser?.uid)!
    
        //Retrieve all user info from the user on selected date and put them in today.userMeals()
        databaseHandle = ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).observe(.value, with: { (snapshot) in
    
            if snapshot.hasChild("proteins") {
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    //Get name and foodID from the node
                    let carbohydrates = allNames["carbohydrates"] as! Double
                    let fats = allNames["fats"] as! Double
                    let folate = allNames["folate"] as! Double
                    let iron = allNames["iron"] as! Double
                    let magnesium = allNames["magnesium"] as! Double
                    let moisture = allNames["moisture"] as! Double
                    let proteins = allNames["proteins"] as! Double
                    let vitaminD = allNames["vitaminD"] as! Double
                    
                    //store it in today
                    self.today.carbohydrates = carbohydrates
                    self.today.fats = fats
                    self.today.folate = folate
                    self.today.iron = iron
                    self.today.magnesium = magnesium
                    self.today.moisture = moisture
                    self.today.proteins = proteins
                    self.today.vitaminD = vitaminD
                    
                    
                    var str = "Carbohydrates: " + String(carbohydrates) + "g\n\n"
                    str += "Fats: " + String(fats) + "g\n\n"
                    str += "Folate: " + String(folate) + "mg\n\n"
                    str += "Iron: " + String(iron) + "mg\n\n"
                    str += "Magnesium: " + String(magnesium) + "mg\n\n"
                    str += "Moisture: " + String(moisture) + "g\n\n"
                    str += "Proteins: " + String(proteins) + "g\n\n"
                    str += "VitaminD: " + String(vitaminD) + "IU\n\n"
                    
                    self.userNutrients.text = str
                    
                }
            }
            else{
                self.self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).updateChildValues(["proteins": 0, "fats":  0, "carbohydrates":  0, "moisture": 0, "iron": 0, "magnesium":  0, "vitaminD":   0, "folate":  0])
                
            }
            
        
        })
    
    }
    
    //TODO: MORE EFFICIECNY
    //*
    //*
    //*
    //Returns the meal factor based on the meal amount
    private func factorMeal(foodID: Int) -> Double{
        
        var stringCount: String = ""
        var factor: Double = 0
        //Go through conversion to find the measure name and conversion factor value
        //After those are found, then you can multiply conversion factor value with nutrient value
        //And you can get the measure description to display
        for i in conversion{
            
            
            if foodID == i.foodID{
                
                
                //Get the measure description
                for j in measures{
                    
                    if i.measureID == j.measureID{
                        
                        //We want grams and ml units, not 1/6 pie (20 cm diamater) or something
                        //So we want the shortest string to have more probability of grams and ml units
                        //Stringcount is 0 so we put anything in here for now
                        if stringCount.count == 0{
                            
                            stringCount = j.measureDescription
                            
                            //Got the conversionFactorValue
                            factor = i.conversionFactorValue
                            
                        }
                            //else if it is not 0, then compare and get least length
                        else if j.measureDescription.count < stringCount.count{
                            
                            stringCount = j.measureDescription
                            
                            //Got the conversionFactorValue
                            factor = i.conversionFactorValue
                            
                        }
                            //else break
                        else{
                            break
                        }
                    }
                }
            }
        }
        
        return factor
        
    }
    
    //Absolute value of a double function
    private func absD(number: Double) -> Double{
        
        if number < 0{
            return -number
        }
        else{
            return number
        }
        
    }
    
    
    //TODO: MORE EFFICIENCY
    //*
    //*
    //*
    //Looks through all the meals and returns the one that has the best match
    private func recommendedMeal(nutrientID: Int, compareNumber: Double){
            
        //Variables needed to do this
        var checkDiff: Double
        var min: Double = 10000
        var firstCheck: Bool = true
        var recommendedMeal = Meal()
        
        var foodID: Int = -1
        
        
        //Look through all the meal's nutrients and find the one equal to protein
        for k in mealNutrients{
            
                
            //If there is a match, add it into the string
            if k.nutrientID == nutrientID{
                
                //Round it up to 2 digits
                //Find the least difference so you can recommend most accurate meal
                
                checkDiff = Double(round(Double(truncating: k.nutrientValue) * factorMeal(foodID: k.foodID) * 100) / 100)
                if firstCheck{
                    min = checkDiff
                    foodID = k.foodID
                    firstCheck = false
                }
                else if absD(number: checkDiff - compareNumber) < absD(number: min - compareNumber){
                    min = checkDiff
                    foodID = k.foodID
                }
                
                if nutrientID == 203{
                    
                    if min > userInfo.proteinsDaily * acc && min < userInfo.proteinsDaily / acc{
                        break
                    }
                    
                }
                else if nutrientID == 204{
                    
                    if min > userInfo.fatsDaily * acc && min < userInfo.fatsDaily / acc{
                        break
                    }
                    
                }
                else if nutrientID == 205{
                    
                    if min > userInfo.carbohydratesDaily * acc && min < userInfo.carbohydratesDaily / acc{
                        break
                    }
                    
                }
                else if nutrientID == 303{
                    
                    if min > userInfo.ironDaily * acc && min < userInfo.ironDaily / acc{
                        break
                    }
                    
                }
                else if nutrientID == 304{
                    
                    if min > userInfo.magnesiumDaily * acc && min < userInfo.magnesiumDaily / acc{
                        break
                    }
                    
                }
                else if nutrientID == 324{
                    
                    if min > userInfo.vitaminDDaily * acc && min < userInfo.vitaminDDaily / acc{
                        break
                    }
                    
                }
                
                
               
            }
        
        }
        
        
        //Look through all meals
        for i in allMeals{
            
            if i.foodID == foodID{
                recommendedMeal = i
                break
            }
            
        }
        
        //Give the user the meal
        recMeal.text = recommendedMeal.name
        
    }
    
    //TODO: Make this more efficient, also make it dependent on gender, age
    //*
    //*
    //*
    //Chooses a meal to recommend back to the user
    //Will not count moisture or folate
    //Will give meal closest to the most needed nutrient (close to daily needed input)
    private func recommend(){
        
        //compare it to all the nutrients in the database
        for k in nutrients{
            
            //Keep track of whether it is proteins, fats, carbohydrates, moisture, iron, magnesium, vitaminD, or folate
            //Then set those values to temp so that it can be added into the database
            if k.nutrientCode == 203{
                proteinsDiff = userInfo.proteinsDaily - today.proteins
            }
            else if k.nutrientCode == 204{
                fatsDiff = userInfo.fatsDaily - today.fats
            }
            else if k.nutrientCode == 205{
                carbohydratesDiff = userInfo.carbohydratesDaily - today.carbohydrates
            }
            else if k.nutrientCode == 255{
                moistureDiff = userInfo.moistureDaily - today.moisture
            }
            else if k.nutrientCode == 303{
                ironDiff = userInfo.ironDaily - today.iron
            }
            else if k.nutrientCode == 304{
                magnesiumDiff = userInfo.magnesiumDaily - today.magnesium
            }
            else if k.nutrientCode == 324{
                vitaminDDiff = userInfo.vitaminDDaily - today.vitaminD
            }
            else if k.nutrientCode == 806{
                folateDiff = userInfo.folateDaily - today.folate
            }
            
            
            
            
        }
        
        let temp = max(proteinsDiff, fatsDiff, carbohydratesDiff, ironDiff, magnesiumDiff, vitaminDDiff)
        
        print(temp)
        //Find the max of all of the differences, and choose the food that is close to the number temp
        //This would give a meal that is closely related to the nutrientDiff, and you may get what you need
        if temp <= 0{
            recMeal.text = "No more recommended foods for today!"
        }
        else if temp == proteinsDiff{
            recommendedMeal(nutrientID: 203, compareNumber: temp)
        }
        else if temp == fatsDiff{
            recommendedMeal(nutrientID: 204, compareNumber: temp)
        }
        
        else if temp == carbohydratesDiff{
            
            recommendedMeal(nutrientID: 205, compareNumber: temp)
        }
        
        else if temp == ironDiff{
            
            recommendedMeal(nutrientID: 303, compareNumber: temp)
        }
        
        else if temp == magnesiumDiff{
            
            recommendedMeal(nutrientID: 304, compareNumber: temp)
        }
        
        else if temp == vitaminDDiff{
            
            recommendedMeal(nutrientID: 324, compareNumber: temp)
        }
        
//        else if temp == moistureDiff{
//
//            recommendedMeal(nutrientID: 255, compareNumber: temp)
//        }
//
//        else if temp == folateDiff{
//
//            recommendedMeal(nutrientID: 806, compareNumber: temp)
//        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(acc)
        loadNutrients()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

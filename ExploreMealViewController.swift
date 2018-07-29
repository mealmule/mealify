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
    
    var recommendedMeal = Meal()
    var pSegue = true
    
    //Get today's number and user info
    var today = Number()
    var userInfo = UserDaily()
    
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
        
        //Retrieve all user info from the user on selected date and put them in today.userMeals()
        databaseHandle = ref?.child("nutrientHistory").child(userID).observe(.value, with: { (snapshot) in
            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                let age = Float(allNames["age"] as! String)
                let gender = allNames["gender"] as! String
                
                self.userInfo = UserDaily(gender: gender, age: age!)
                
            }
           
            
            
        })
    
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
    
    func binarySearch(arr: [Meal], searchItem: Int) -> Int {
        var lowerIndex = 0;
        var upperIndex = arr.count - 1
        
        
        
        
        while (true) {
            
            let currentIndex = (lowerIndex + upperIndex)/2
            
            if(arr[currentIndex].foodID == searchItem) {
                return currentIndex
                
            }
            else {
                if (arr[currentIndex].foodID > searchItem) {
                    upperIndex = currentIndex - 1
                }
                else {
                    lowerIndex = currentIndex + 1
                }
            }
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
        
        
        var foodID: Int = -1
        
        
        //Look through all the meal's nutrients and find the one equal to protein
        for k in mealNutrients{
            
                
            //If there is a match, add it into the string
            if k.nutrientID == nutrientID{
                
                let index = binarySearch(arr: allMeals, searchItem: k.foodID)
                
                //Round it up to 2 digits
                //Find the least difference so you can recommend most accurate meal
                
                checkDiff = Double(round(Double(truncating: k.nutrientValue) * allMeals[index].factor * 100) / 100)
                if firstCheck{
                    min = checkDiff
                    foodID = k.foodID
                    firstCheck = false
                }
                else if absD(number: checkDiff - compareNumber) < absD(number: min - compareNumber){
                    min = checkDiff
                    foodID = k.foodID
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
        
        let temp = max(proteinsDiff, fatsDiff, carbohydratesDiff, ironDiff, magnesiumDiff, vitaminDDiff, moistureDiff, folateDiff)
        
        print(temp)
        //Find the max of all of the differences, and choose the food that is close to the number temp
        //This would give a meal that is closely related to the nutrientDiff, and you may get what you need
        if temp <= 0{
            recMeal.text = "No more recommended foods for today!"
            pSegue = false
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
        
        else if temp == moistureDiff{

            recommendedMeal(nutrientID: 255, compareNumber: temp)
        }

        else if temp == folateDiff{

            recommendedMeal(nutrientID: 806, compareNumber: temp)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(acc)
        loadNutrients()
        
        loadFromDatabase()
        
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if !pSegue || recMeal.text == "" || recMeal.text == "No Meal to view!"  {
            recMeal.text = "No Meal to view!"
            return false
        }
        return true
    }
    
    //TODO:
    //*
    //*
    //*
    //This function retrieves data from the database so that you can it will give user all meals from that day
    //It will store the meals into today.userMeals, and will be used in other view controllers
    //today will be initialized every time this view controller is called, initializing today.userMeals to empty is not necessary
    private func loadFromDatabase(){
        
        //Get the userID, and remove all elements in today.userMeals
        let userID = (Auth.auth().currentUser?.uid)!
        
        //Retrieve all meals from the user on selected date and put them in today.userMeals()
        databaseHandle = ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").observe(.childAdded, with: { (snapshot) in
            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                //Get name and foodID from the node
                let userInterest = allNames["name"] as! String
                let foodID = allNames["foodID"] as! Int
                let mealNumber = allNames["mealNumber"] as! Int
                
                //Turn it into a meal
                let meal = Meal(name: userInterest, foodID: foodID, mealNumber: mealNumber)
                
                
                //Add meal into array
                self.today.userMeals += [meal]
                
            }
            
            
        })
        
        
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "mealDescription"{
            
            let dest = segue.destination as! MealViewController
            dest.meal = recommendedMeal
            
            dest.title = "Recommended Meal"
            
            dest.numberOfDayMeals = today.userMeals.count
            
        }
    }
 

}

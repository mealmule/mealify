//
//  ViewController3.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-27.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit
import Firebase

var allMeals = [Meal]()
var mealNutrients = [NutrientMealInfo]()
var nutrients = [Nutrients]()
var measures = [Measure]()
var conversion = [MeasureConversion]()



class ViewController3: UIViewController {

    
    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    
    @IBOutlet weak var statuslabel: UILabel!
    //@IBOutlet weak var statuslabel: UILabel!
    //@IBOutlet weak var statuslabel: UILabel!
    
    var today2 = Date()
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    var todayFormatted = ""
    var ref : DatabaseReference?
    var ref1: DatabaseReference!
    var ref2: DatabaseReference!
    var ref3: DatabaseReference!
    var ref4: DatabaseReference!
    var ref5: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    
    @IBAction func loginbutton(_ sender: UIButton) {
        if let email = emailtext.text, let pass = passwordtext.text{
            Auth.auth().signIn(withEmail: email, password: pass){
                (user,error) in
                if let u = user{
                    print("Log in successful")
                    let userID = Auth.auth().currentUser?.uid
                    
                    self.ref?.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.hasChild(self.todayFormatted) {
                            
                        } else {
                            self.ref?.child("nutrientHistory").child(userID!).child(self.todayFormatted).setValue(["kCals": 0, "proteins": 0, "fats": 0, "carbohydrates": 0, "moisture": 0, "iron": 0, "magnesium": 0, "vitaminD": 0, "folate": 0])
                            
                        }
                    })
                    self.performSegue(withIdentifier: "loggedin", sender: self)
                } else {
                    print(error)
                    print("Invalid email or password, please try again!")
                    self.statuslabel.text = "Invalid email or password, please try again!"
                    self.statuslabel.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
                }
            }
        }
        
    }
    
    func LoadMealsAndNutrients(){
        
        ref1 = Database.database(url: "https://mealify-7babd-2e44f.firebaseio.com/").reference()
        ref2 = Database.database(url: "https://mealify-7babd-78a83.firebaseio.com/").reference()
        ref3 = Database.database(url: "https://mealify-7babd-a6cd5.firebaseio.com/").reference()
        ref4 = Database.database(url: "https://mealify-7babd-b53b7.firebaseio.com/").reference()
        ref5 = Database.database(url: "https://mealify-7babd-cf680.firebaseio.com/").reference()
        
        if allMeals.count == 0{
            databaseHandle = ref1?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    
                    let userInterest = allNames["FoodDescription"] as! String
                    let foodID = allNames["FoodID"] as! Int
                    allMeals += [Meal(name: userInterest, foodID: foodID, mealNumber: -1)]
                    
                }
                
            })
        }
        
        if mealNutrients.count == 0{
            databaseHandle = ref2?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    let nutrientID = allNames["NutrientID"] as! Int
                    let foodID = allNames["FoodID"] as! Int
                    let nutrientSourceID = allNames["NutrientSourceID"] as! Int
                    let nutrientValue = allNames["NutrientValue"] as! NSNumber
                    
                    
                    mealNutrients += [NutrientMealInfo(foodID: foodID, nutrientID: nutrientID, nutrientSourceID: nutrientSourceID, nutrientValue: nutrientValue)]
                    //self.tableView.reloadData()
                }
                
            })
        }
        
        if nutrients.count < 8{
            databaseHandle = ref3?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    let nutrientCode = allNames["NutrientCode"] as! Int
                    let nutrientDecimals = allNames["NutrientDecimals"] as! Int
                    let nutrientName = allNames["NutrientName"] as! String
                    let nutrientNameF = allNames["NutrientNameF"] as! String
                    let nutrientSymbol = allNames["NutrientSymbol"] as! String
                    let nutrientUnit = allNames["NutrientUnit"] as! String
                    let tagName = allNames["Tagname"] as! String
                    
                    nutrients += [Nutrients(nutrientCode: nutrientCode, nutrientDecimals: nutrientDecimals, nutrientName: nutrientName, nutrientNameF: nutrientNameF, nutrientSymbol: nutrientSymbol, nutrientUnit: nutrientUnit, tagName: tagName)]
                }
                
            })
        }
        
        if measures.count == 0{
            databaseHandle = ref4?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    
                    let measureID = allNames["MeasureID"] as! Int
                    let measureDescription = allNames["MeasureDescription"] as! String
                    measures += [Measure(measureDescription: measureDescription, measureID: measureID)]
                    
                }
                
            })
        }
        
        if conversion.count == 0{
            databaseHandle = ref5?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    
                    let measureID = allNames["MeasureID"] as! Int
                    let foodID = allNames["FoodID"] as! Int
                    let conversionFactorValue = allNames["ConversionFactorValue"] as! Double
                    conversion += [MeasureConversion(foodID: foodID, measureID: measureID, conversionFactorValue: conversionFactorValue)]
                    
                }
                
            })
        }

        
        
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: today2)
        
        LoadMealsAndNutrients()
        
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

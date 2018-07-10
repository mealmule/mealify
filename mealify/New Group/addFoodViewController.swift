//
//  File: addFoodViewController.swift
//  mealify
//
//  Worked on by Justin Lew on 2018-06-30.
//  Copyright © 2018 mealmules. All rights reserved.


// ***************************************************
// ******************  Overview **********************
// ***************************************************
//  This view controller makes two API calls using Alamofire
//  The first API searches for the food when a user types in the text labelled "Food"
//  The first API would give us a unique identifier named 'ndbno' which would be used in the second API call
//  The second API call would give us the nutrients of the food typed in using the 'ndbno' identifier
//  We multiple the returned nutrients by a factor given by the user labelled 'amount' then the array is stored in the Firebase database


// **********************************************
// ****************   BUGS   ********************
// **********************************************
// 1. If a user types in a food that has already been added then the new input would overwritted the existing one
// 2. Imperfect search!!! When a user types in 'butter' then the search API would output 'peanut butter'. In a future version
//          it would be better to let the user choose among multiple search results and add accordingly to the database


import Foundation
import UIKit
import Alamofire
import SwiftyJSON
import Firebase
import FirebaseAuth
import FirebaseDatabase


class addFoodViewController: UIViewController {
    
    let url = "https://api.nal.usda.gov/ndb/V2/reports?ndbno=01009&ndbno=01009&ndbno=45202763&ndbno=35193&type=b&format=json&api_key=1VNMfmLRk3WaietetyGnJzWsQS4bXHgr2EktPZUo"
    let urlSearchFood = "https://api.nal.usda.gov/ndb/search/?format=json&q=butter&sort=n&max=25&offset=0&api_key=1VNMfmLRk3WaietetyGnJzWsQS4bXHgr2EktPZUo"
    

    @IBOutlet weak var addFoodName: UITextField!
    @IBOutlet weak var addAmount: UITextField!
    @IBOutlet weak var foodTableView: UITableView!
    @IBOutlet weak var dateHeader: UINavigationItem!
    
    // Initialize database reference
//    var ref : DatabaseReference?
    
    
    
    var today = Date()
    let dateFormatter = DateFormatter()
    var todayFormatted = ""
    var ref : DatabaseReference?
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        let userID = (Auth.auth().currentUser?.uid)!
        
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

        // Do any additional setup after loading the view.
//        print(dateFormatter.string(from: today))
        todayFormatted = dateFormatter.string(from: today)
        dateHeader.title = "Today: \(todayFormatted)"
        
        
//        ref?.child("nutrientHistory").child(userID).child(todayFormatted).child("butter").setValue([1,2,3,4])
//        ref?.child("nutrientHistory").child(userID).child(todayFormatted).child("butter").setValue([1,2,3,4])
        
        
            }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func getNutrients(_ sender: Any) {
        print(addFoodName.text!)
        let food = addFoodName.text!
        let foodURLFriendly = food.replacingOccurrences(of: " ", with: "+")
        let searchFoodUrl = "https://api.nal.usda.gov/ndb/search/?format=json&q=\(foodURLFriendly)&sort=n&max=5&offset=0&api_key=1VNMfmLRk3WaietetyGnJzWsQS4bXHgr2EktPZUo"
        if let amountPerHundredGrams = Double(addAmount.text!) {
            searchFoods(url: searchFoodUrl, parameters: ["": ""], amount: amountPerHundredGrams)
        } else {
            print("Error the amount is not of type DOUBLE")
        }
        
        // TODO: add food and it's nutrients to the database under that user
        
        
    }
    
    func searchFoods(url: String, parameters: [String: String], amount: Double) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success")
                
                let foods : JSON = JSON(response.result.value!)
                // the ndbno is the unique identifier for the searched food in the Food Composition database
                // it is then used to find the nutrients from the USDA Food Composition database
                print(foods["list"]["item"][0]["ndbno"])
                let ndbno = foods["list"]["item"][0]["ndbno"]
                let urlFoodReport = "https://api.nal.usda.gov/ndb/reports/?ndbno=\(ndbno)&type=b&format=json&api_key=1VNMfmLRk3WaietetyGnJzWsQS4bXHgr2EktPZUo"
                self.getFoodReport(url: urlFoodReport, parameters: ["": ""], amount: amount)
                
            } else {
                print("Error \(response.result.error)")
                
            }
        }
    }
    
    func getFoodReport(url: String, parameters: [String: String], amount: Double) {
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                print("Success")
                
                let foodReport : JSON = JSON(response.result.value!)
                
                let name = foodReport["report"]["food"]["name"]
                
                
                
                // finds kCals per 100g
                let kCals = foodReport["report"]["food"]["nutrients"][0]["value"]
                // finds protein per 100g
                let proteins = foodReport["report"]["food"]["nutrients"][1]["value"]
                // finds fats per 100g
                let fats = foodReport["report"]["food"]["nutrients"][2]["value"]
                // finds carbohydrates per 100g
                let carbohydrates = foodReport["report"]["food"]["nutrients"][3]["value"]
                
                var nutrientArray : [Double] = []
                //this converts JSON to string then to Double (if it is a valid Double!!)
                if let kCalsString = kCals.rawString() {
                    if let kCals = Double(kCalsString) {
                        nutrientArray.append(amount * kCals)
                    }
                }
                
                if let proteinsString = proteins.rawString() {
                    if let proteins = Double(proteinsString) {
                        nutrientArray.append(amount * proteins)
                    }
                }
                
                if let fatsString = fats.rawString() {
                    if let fats = Double(fatsString) {
                        nutrientArray.append(amount * fats)
                    }
                }
                
                if let carbohydratesString = carbohydrates.rawString() {
                    if let carbohydrates = Double(carbohydratesString) {
                        nutrientArray.append(amount * carbohydrates)
                    }
                }
                
                //find today's date
                
                self.todayFormatted = self.dateFormatter.string(from: self.today)
                
                
                
                //TODO: get currently logged in user's ID
                
                let userID = (Auth.auth().currentUser?.uid)!
                
                //TODO: add to the database for the user
                if let foodName = name.rawString() {
                    self.ref?.child("nutrientHistory").child(userID).child(self.todayFormatted).child(foodName).setValue(nutrientArray)
                    self.ref?.child("nutrientHistory").child(userID).child(self.todayFormatted).observeSingleEvent(of: .value, with: { (snapshot) in
                        let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                        let currentCalories = snapDictionary["carbohydrates"]! as! Double
                        let currentProteins = snapDictionary["proteins"]! as! Double
                        let currentFats = snapDictionary["fats"]! as! Double
                        let currentCarbohydrates = snapDictionary["carbohydrates"]! as! Double
                        print(currentCalories)
                        print(nutrientArray)
                        self.self.ref?.child("nutrientHistory").child(userID).child(self.todayFormatted).updateChildValues(["kCals": currentCalories + nutrientArray[0], "proteins": currentProteins + nutrientArray[1], "fats": currentFats + nutrientArray[2], "carbohydrates": currentCarbohydrates + nutrientArray[3]])
//
                    })
                }
                
//                ref?.child("nutrientHistory").child(user)
                
                

            } else {
                print("Error \(response.result.error)")
            }
        }
    }
    
    
    
    @IBAction func logoutPressed(_ sender: Any) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        }
        catch {
            print("error")
            
        }
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

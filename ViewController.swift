//
//  ViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added buttons for all tappable objects
//                Added functionality to yesterday, today, and tomorrow buttons
//                Added functionality to add breakfast, add lunch, add dinner buttons
//                Added firebase to retrieve all information from database
//                Deleted days, and breakfast, lunch, and dinner
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

import FirebaseDatabase


//Global variables

var today = Number()
var dateChosenGlo: String?

class ViewController: UIViewController {
    
    
    //Properties
    @IBOutlet weak var kcalsLeft: UILabel!
    @IBOutlet weak var mealRecommend: UILabel!

    @IBOutlet weak var dateLabel: UILabel!
    

    
    @IBOutlet weak var mealFoods: UILabel!
    
//    var today = Date()
    let dateFormatter = DateFormatter()
    var todayFormatted = ""

    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?

    

    
    
    
    //This function takes in an Int and outputs a String.
    //Turns the number of calories into a displayable string for the app
    private func recommendedCalories(calories: Int) -> String {
        
        let ret: String = "Recommend: " + String(calories) + " Kcals";
        return ret;

    }
    
    
    //Prints the numbers for the day
    //It will print Kcals, meal recommended calories

    private func printNumbers(kCalories: Int, bCalories: Int, lCalories: Int, dCalories: Int) {
        
        //Number of calories left in the day.
        //Center the text and set it to a number
        //Default number is 0
        kcalsLeft.textAlignment = .center;
        kcalsLeft.text = String(kCalories);
        
        //Number of calories recommended for today's meal in the day.
        //set it to a number
        //Default number is 0, units is Kcals
        mealRecommend.text = recommendedCalories(calories: bCalories);
        
        
    }
    
    
    
    
    
    //This function will set all the numbers to the current day's recommendations
    //Kcals left will be changed
    //meal recommendation calories will be changed

    private func getToday(){
        
        today.kCals = 50
        today.bCals = 810
        today.lCals = 803
        today.dCals = 1598
        
        
        
    }
    
    
    
    
    //This function will direct the user to today.
    //The new page will be the same as today except with different numbers
    //Different progress, and Kcals left/recommended.
    //The page will have the same numbers when the user leaves the page and comes back
    //The page does not have to be new, it can be the same page with different numbers
    //so every time this button is pressed, it will just display different numbers
    @IBOutlet weak var now: UIButton!
    
    @IBAction func dayNow(_ sender: Any) {
        
        printNumbers(kCalories: today.kCals, bCalories: today.bCals, lCalories: today.lCals, dCalories: today.dCals)
        printFoods()
    }
    

    

    
    //Print foods function will print the foods that the user added to meal
    //This is dependent on what day the user is currently displaying (today, tomorrow, yesterday)
    //And it will display different foods for all meal. lunch and dinner.
    //This will get an array, and checks the count.
    //If the count is 0 then print "none", else print all the foods in the array
    public func printFoods(){
        print("CALLED")
        //This section is for today's meal foods
        if today.userMeals.count == 0{
            mealFoods.text = "Foods: None"
        } else{
            
            var n: String = "Foods: "
            for i in today.userMeals {
                n += i.name + ", "
            }
            mealFoods.text = n
            
        }
        
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        //Firebase part
        ref = Database.database().reference()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: Date())
        
        //Change the label of the date on top of the view controller
        if dateChosenGlo == nil{
            //When just logged in
            dateChosenGlo = todayFormatted
            dateLabel.text = "Today"
        }
        else{
            //when selected day on calendar
            if dateChosenGlo == todayFormatted{
                dateLabel.text = "Today"
            }
            //When selected any other day on the calendar
            else{
                dateLabel.text = dateChosenGlo
            }
        }
        
        let userID = (Auth.auth().currentUser?.uid)!
        today.userMeals = []

        databaseHandle = ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).child("meals").observe(.childAdded, with: { (snapshot) in
            
  
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                let userInterest = allNames["name"] as! String
                let foodID = allNames["foodID"] as! Int
                var meal = Meal(name: userInterest, foodID: foodID)
                
                for i in mealNutrients{
                    
                    if i.foodID == meal.foodID{
                        meal.nutrients += [i]
                    }
                    
                }
                
                today.userMeals += [meal]
                print(today.userMeals.count)
            }
            //Load data numbers dependent on what day it is
            self.dayNow(self.now)
            
            
        })
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //Hides the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        ref = Database.database().reference()
        //get data for today, yesterday, and tomorrow
        getToday()

        
        
        

        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When button is clicked to direct to new view, that view depends on which button you tap (for same view)
    //This function passes data from current view to navigation bar to the actual next view.
    //Add meal button changes title to meals
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //Breakfast button is pressed
        if segue.identifier == "addMeals"{
            
            //connect to table view
            let dest = segue.destination as! MealTableViewController
            
            //Dest is the Meal table view. Change properties below
            dest.title = "Meals"
            
        }

        

        
        
        
    }
    
    
    
    
}


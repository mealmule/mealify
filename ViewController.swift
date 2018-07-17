//
//  ViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added buttons for all tappable objects
//                Added functionality to yesterday, today, and tomorrow buttons
//                Added functionality to add breakfast, add lunch, add dinner buttons
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

//-1 is yesterday
//0 is today
//1 is tomorrow

//Global variables
var day: Int = 0

var today = Number()
var yesterday = Number(day_before: true)
var tomorrow = Number(day_after: true)


class ViewController: UIViewController {
    
    
    //Properties
    @IBOutlet weak var kcalsLeft: UILabel!
    @IBOutlet weak var mealRecommend: UILabel!

    
    @IBOutlet weak var todayButton: UIButton!
    @IBOutlet weak var tomorrowButton: UIButton!
    @IBOutlet weak var yesterdayButton: UIButton!
    
    @IBOutlet weak var mealFoods: UILabel!

    
    var Recipes = [Recipe]()
    
    
    
    //This function takes in an Int and outputs a String.
    //Turns the number of calories into a displayable string for the app
    private func recommendedCalories(calories: Int) -> String {
        
        let ret: String = "Recommend: " + String(calories) + " Kcals";
        return ret;
        
    }
    
    
    //Prints the numbers for the day
    //It will print Kcals, breakfast recommended calories
    //lunch recommended calories, and dinner recommended calories
    private func printNumbers(kCalories: Int, bCalories: Int, lCalories: Int, dCalories: Int) {
        
        //Number of calories left in the day.
        //Center the text and set it to a number
        //Default number is 0
        kcalsLeft.textAlignment = .center;
        kcalsLeft.text = String(kCalories);
        
        //Number of calories recommended for today's breakfast in the day.
        //set it to a number
        //Default number is 0, units is Kcals
        mealRecommend.text = recommendedCalories(calories: bCalories);
        
        
    }
    
    
    
    
    
    //This function will set all the numbers to the current day's recommendations
    //Kcals left will be changed
    //Breakfast recommendation calories will be changed
    //Lunch recommendation calories will be changed
    //Dinner recommendation calories will be changed
    private func getToday(){
        
        today.kCals = 50
        today.bCals = 810
        today.lCals = 803
        today.dCals = 1598
        
        
        
    }
    
    //This function will set all the numbers to the yesterday's recommendations
    //Kcals left will be changed
    //Breakfast recommendation calories will be changed
    //Lunch recommendation calories will be changed
    //Dinner recommendation calories will be changed
    private func getYesterday(){
        
        yesterday.kCals = 4256
        yesterday.bCals = 216
        yesterday.lCals = 997
        yesterday.dCals = 216
        
        
        
    }
    
    //This function will set all the numbers to the tomorrow's recommendations
    //Kcals left will be changed
    //Breakfast recommendation calories will be changed
    //Lunch recommendation calories will be changed
    //Dinner recommendation calories will be changed
    private func getTomorrow(){
        
        tomorrow.kCals = 526
        tomorrow.bCals = 125
        tomorrow.lCals = 168
        tomorrow.dCals = 732
        
        
        
    }
    
    
    //This function will direct the user to today.
    //The new page will be the same as today except with different numbers
    //Different progress, and Kcals left/recommended.
    //The page will have the same numbers when the user leaves the page and comes back
    //The page does not have to be new, it can be the same page with different numbers
    //so every time this button is pressed, it will just display different numbers
    @IBOutlet weak var now: UIButton!
    
    @IBAction func dayNow(_ sender: Any) {
        
        todayButton.setTitleColor(.blue, for: .normal)
        yesterdayButton.setTitleColor(.gray, for: .normal)
        tomorrowButton.setTitleColor(.gray, for: .normal)
        
        
        day = 0
        printNumbers(kCalories: today.kCals, bCalories: today.bCals, lCalories: today.lCals, dCalories: today.dCals)
        printFoods()
    }
    
    //This function will direct the user to the day before today.
    //The new page will be the same as today except with different numbers
    //Different progress, and Kcals left/recommended.
    //The page will have the same numbers when the user leaves the page and comes back
    //The page does not have to be new, it can be the same page with different numbers
    //so every time this button is pressed, it will just display different numbers
    @IBOutlet weak var before: UIButton!
    
    @IBAction func dayBefore(_ sender: Any){
        
        todayButton.setTitleColor(.gray, for: .normal)
        yesterdayButton.setTitleColor(.blue, for: .normal)
        tomorrowButton.setTitleColor(.gray, for: .normal)
        
        day = -1
        printNumbers(kCalories: yesterday.kCals, bCalories: yesterday.bCals, lCalories: yesterday.lCals, dCalories: yesterday.dCals)
        printFoods()
    }
    
    //This function will direct the user to the day after today.
    //The new page will be the same as today except with different numbers
    //Different progress, and Kcals left/recommended.
    //The page will have the same numbers when the user leaves the page and comes back
    //The page does not have to be new, it can be the same page with different numbers
    //so every time this button is pressed, it will just display different numbers
    @IBOutlet weak var after: UIButton!
    
    @IBAction func dayAfter(_ sender: Any){
        
        todayButton.setTitleColor(.gray, for: .normal)
        yesterdayButton.setTitleColor(.gray, for: .normal)
        tomorrowButton.setTitleColor(.blue, for: .normal)
        
        day = 1
        printNumbers(kCalories: tomorrow.kCals, bCalories: tomorrow.bCals, lCalories: tomorrow.lCals, dCalories: tomorrow.dCals)
        printFoods()
    }
    
    //Print foods function will print the foods that the user added to either breakfast, lunch, or dinner
    //This is dependent on what day the user is currently displaying (today, tomorrow, yesterday)
    //And it will display different foods for all breakfast. lunch and dinner.
    //This will get an array, and checks the count.
    //If the count is 0 then print "none", else print all the foods in the array
    public func printFoods(){
        
        
        //Check to see if current day displayed is equal to today
        if day == 0{
            
            //This section is for today's breakfast foods
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
            
            //Check to see if current day displayed is equal to yesterday
        else if day == -1{
            
            //This section is for yesterday's breakfast foods
            if yesterday.userMeals.count == 0{
                mealFoods.text = "Foods: None"
            } else{
                
                var n: String = "Foods: "
                for i in yesterday.userMeals {
                    n += i.name + ", "
                }
                mealFoods.text = n
                
            }
           
        }
            
            //Check to see if current day displayed is equal to tomorrow
        else if day == 1{
            
            ////This section is for tomorrow's breakfast foods
            if tomorrow.userMeals.count == 0{
                mealFoods.text = "Foods: None"
            } else{
                
                var n: String = "Foods: "
                for i in tomorrow.userMeals {
                    n += i.name + ", "
                }
                mealFoods.text = n
                
            }
            
        }
        
        
        
        
    }
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //Hides the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        //get data for today, yesterday, and tomorrow
        getToday()
        getYesterday()
        getTomorrow()
        
        //Load data numbers dependent on what day it is
        if day == 0{
            dayNow(now)
        } else if day == -1{
            dayBefore(before)
        } else if day == 1{
            dayAfter(after)
        }
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When button is clicked to direct to new view, that view depends on which button you tap (for same view)
    //This function passes data from current view to navigation bar to the actual next view.
    //Add breakfast button changes title to Breakfasts
    //Add lunch button changes title to Lunches
    //Add dinner button changes title to Dinners
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //Breakfast button is pressed
        if segue.identifier == "addMeals"{
            
            //connect to table view
            let dest = segue.destination as! MealTableViewController
            
            //Dest is the Meal table view. Change properties below
            dest.title = "Meals"
            
        }

        
        else if segue.identifier == "recipes"{
            
            //connect to table view
            let dest = segue.destination as! RecipeTableViewController
            
            //Dest is the Meal table view. Change properties below
            dest.title = "Explore Recipes"
            
        }
        
        
        
    }
    
    
    
    
}


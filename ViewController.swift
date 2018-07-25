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
//                Fixed duplicate bug where add meals would add multiple meals
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase


//Global variables

//The date chosen from the calendar
var dateChosenGlo: String?


class ViewController: UIViewController {
    
    
    //Properties and labels
    @IBOutlet weak var kcalsLeft: UILabel!
    @IBOutlet weak var mealRecommend: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mealFoods: UILabel!
    
    
    
    let shapeLayer = CAShapeLayer()
    //The selected day's properties (meals, nutrients)
    var today = Number()
    
    //Variables
    var folateGoal: Int = 0
    var ironGoal: Int = 0
    var magnesiumGoal: Int = 0
    var vitaminDGoal: Int = 0
    var dailyWaterConsume: Int = 0
    var dailyWaterGlassNumber: Int = 0
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var magGoalTxt: UILabel!
    @IBOutlet weak var dGoalTxt: UILabel!
    @IBOutlet weak var ironGoalTxt: UILabel!
    @IBOutlet weak var folateGoalTxt: UILabel!
    @IBOutlet weak var waterGoalTxt: UILabel!
    
    
    
    //Get today's date
    let dateFormatter = DateFormatter()
    var todayFormatted = ""
    
    //Firebase database reference and handle for retrieveing foods
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    
    
    
    
    //TODO: Replace this function with one that inputs many nutrient values, and returns the corresponding string and unit.
    //This function may be moved into another view controller where printing the nutrients is done.
    //*
    //*
    //*
    //This function takes in an Int and outputs a String.
    //Turns the number of calories into a displayable string for the app
    private func recommendedCalories(calories: Int) -> String {
        
        let ret: String = "Recommend: " + String(calories) + " Kcals";
        return ret;
        
    }
    
    
    //TODO: This function is no longer needed.
    //*
    //*
    //*
    //Prints the numbers for the day
    //It will print Kcals, meal recommended calories
    private func printNumbers(kCalories: Int, bCalories: Int, lCalories: Int, dCalories: Int) {
        
        //Number of calories left in the day.
        //Center the text and set it to a number
        //Default number is 0
        
        //Number of calories recommended for today's meal in the day.
        //set it to a number
        //Default number is 0, units is Kcals
        
        
    }
    
    
    
    
    
    //TODO:
    //*
    //*
    //*
    //Print foods function will print the foods that the user added to meal
    //This is dependent on what day the user is currently displaying (today, tomorrow, yesterday)
    //And it will display different foods for all meal. lunch and dinner.
    //This will get an array, and checks the count.
    //If the count is 0 then print "none", else print all the foods in the array
    private func printFoods(){
        
        print("printFoods CALLED")
        //If there are no foods inside the selected date's database, then set this to display none
        if today.userMeals.count == 0{
            mealFoods.text = "Foods: None"
        }
            //Else display all the foods in the selected date's database
        else{
            
            //String to contain all of selected date's food.
            var n: String = "Foods: "
            
            //Display all the names of the foods in the selected date
            for i in today.userMeals {
                n += i.name + ", "
            }
            
            //Set label to this string
            mealFoods.text = n
            
        }
        
        
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
              
                
                //Include all nutrients into that meal
                for i in mealNutrients{
                    
                    if i.foodID == meal.foodID{
                        meal.nutrients += [i]
                    }
                    
                }
                
                //Add meal into array
                self.today.userMeals += [meal]

            }
            
            //Load data numbers dependent on what day it is
            self.printFoods()

            
        })
        
    }
 
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        
        //User Interface of the view controller begins here
        
        // initialize daily nutrient goals
        initGoals()
        folateGoalTxt.text = String(folateGoal) + "mg"
        ironGoalTxt.text = String(ironGoal) + "mg"
        dGoalTxt.text = String(vitaminDGoal) + "mg"
        magGoalTxt.text = String(magnesiumGoal) + "mg"
        
        //waterGoalTxt.text = String(dailyWaterConsume) + "ml"
        
        // progressbar animation
        // draw the score circle and its animation
        let center = CGPoint(x: self.view.frame.width/2, y: 153)
        
        // define stroke colors
        let trackColor = UIColor(hue: 0, saturation: 0, brightness: 0.82, alpha: 0.2)
        let strokeColor = UIColor(hue: 0.1528, saturation: 0.88, brightness: 0.97, alpha: 1.0)
        
        // create the track layer
        let circularPath = UIBezierPath(arcCenter: center, radius: 56, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
        
        let trackLayer = CAShapeLayer();
        trackLayer.path = circularPath.cgPath
        trackLayer.strokeColor = trackColor.cgColor
        trackLayer.lineWidth = 10
        trackLayer.fillColor = UIColor.clear.cgColor
        
        // make the edge of stroke round and smooth
        trackLayer.lineCap = kCALineCapRound
        contentView.layer.addSublayer(trackLayer)
        
        // create the shape layer
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = strokeColor.cgColor
        shapeLayer.lineWidth = 10
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        // make the edge of stroke round and smooth
        shapeLayer.lineCap = kCALineCapRound
        
        shapeLayer.strokeEnd = 0
        contentView.layer.addSublayer(shapeLayer)
        circleAnimation()
        
        //User interface code ends here.
        
        
        
        
        
        //The rest of the code here on this function is firebase.
        //*
        //*
        //*
        
        //initialize ref
        ref = Database.database().reference()
        
        
        
        //Get today's date in string format.
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
        
     
        loadFromDatabase()
        
        
        // Do any additional setup after loading the view, typically from a nib.
        //Hides the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        
        
        
        
        
    }
    
    //TODO: Have these goals selected from database instead of being hardcoded
    //Currently, these values are hard coded
    //*
    //*
    //*
    //Changes the variables in these goals to hard coded values
    private func initGoals() {
        folateGoal = 400
        ironGoal = 8
        magnesiumGoal = 240
        vitaminDGoal = 100
        dailyWaterConsume = 2000
        dailyWaterGlassNumber = dailyWaterConsume / 250
    }
    
    
    //Creates a circle animation.
    @objc private func circleAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 0.5
        basicAnimation.duration = 2
        
        // for animation to stay in the end
        basicAnimation.fillMode = kCAFillModeForwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //When button is clicked to direct to new view, that view depends on which button you tap (for same view)
    //This function passes data from current view to navigation bar to the actual next view.
    //Add meal button changes title to meals
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        //Add Meal button is pressed
        if segue.identifier == "addMeals"{
            
            //connect to table view
            let dest = segue.destination as! MealTableViewController
            
            //Dest is the Meal table view. Change properties below
            dest.title = "Meals"
            
            //Give number of meals to next
            dest.numberOfDayMeals = today.userMeals.count
            print("HEAHEA: " + String(today.userMeals.count))
            
        }
        
        //Add Meal button is pressed
        if segue.identifier == "seeMeals"{
            
            //connect to table view
            let dest = segue.destination as! TodayMealTableViewController
            
            //Dest is the Meal table view. Change properties below
            dest.title = "Day's Meals"
            dest.userMeals = today.userMeals
            
            //Give number of meals to next
            dest.numberOfDayMeals = today.userMeals.count
            
        }
        
    }
    
}


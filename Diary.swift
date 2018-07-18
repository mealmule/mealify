////
////  Diary.swift
////  mealify
////
////  Created by Juey on 2018-07-16.
////  Copyright © 2018 Meal Mules. All rights reserved.
////
//
//import UIKit
//
////-1 is yesterday
////0 is today
////1 is tomorrow
//
////Global variables
////var day: Int = 0
////
////var today = Number()
////var yesterday = Number(day_before: true)
////var tomorrow = Number(day_after: true)
////
////var breakfastMeals = [Meal]()
////var lunchMeals = [Meal]()
////var dinnerMeals = [Meal]()
//
//
//class Diary: UIViewController {
//
//
//    //Properties
//    @IBOutlet weak var kcalsLeft: UILabel!
//    @IBOutlet weak var breakfastRecommend: UILabel!
//    @IBOutlet weak var lunchRecommend: UILabel!
//    @IBOutlet weak var dinnerRecommend: UILabel!
//
//    @IBOutlet weak var todayButton: UIButton!
//    @IBOutlet weak var tomorrowButton: UIButton!
//    @IBOutlet weak var yesterdayButton: UIButton!
//
//    @IBOutlet weak var breakfastFoods: UILabel!
//
//    // homepage-02's properties
//
//    //Variables
//    var folateGoal: Int = 0
//    var ironGoal: Int = 0
//    var magnesiumGoal: Int = 0
//    var vitaminDGoal: Int = 0
//    var dailyWaterConsume: Int = 0
//    var dailyWaterGlassNumber: Int = 0
//    var glassTap = false;
//
//
//    @IBOutlet weak var mealFoods: UILabel!
//
//    @IBOutlet weak var waterButton: UIButton!
//
//    @IBAction func glassButton(_ sender: UIButton) {
//        glassTap = !glassTap;
//        if(glassTap) {
//            // change glass image to color
//            waterButton.setImage(#imageLiteral(resourceName: "glass_color"), for: UIControlState.normal)
//        } else {
//            // change glass image to grey
//            waterButton.setImage(#imageLiteral(resourceName: "glass_1_grey"), for: UIControlState.normal)
//        }
//    }
//
//
//    //This function takes in an Int and outputs a String.
//    //Turns the number of calories into a displayable string for the app
//    private func recommendedCalories(calories: Int) -> String {
//
//        let ret: String = "Recommend: " + String(calories) + " Kcals";
//        return ret;
//
//    }
//
//
//    //Prints the numbers for the day
//    //It will print Kcals, breakfast recommended calories
//    //lunch recommended calories, and dinner recommended calories
//    private func printNumbers(kCalories: Int, bCalories: Int, lCalories: Int, dCalories: Int) {
//
//        //Number of calories left in the day.
//        //Center the text and set it to a number
//        //Default number is 0
////        kcalsLeft.textAlignment = .center;
////        kcalsLeft.text = String(kCalories);
//
//        //Number of calories recommended for today's breakfast in the day.
//        //set it to a number
//        //Default number is 0, units is Kcals
////        breakfastRecommend.text = recommendedCalories(calories: bCalories);
//
//        //Number of calories recommended for today's lunch in the day.
//        //set it to a number
//        //Default number is 0, units is Kcals
////        lunchRecommend.text = recommendedCalories(calories: lCalories);
//
//        //Number of calories recommended for today's dinner in the day.
//        //set it to a number
//        //Default number is 0, units is Kcals
////        dinnerRecommend.text = recommendedCalories(calories: dCalories);
//
//    }
//
//
//
//
//
//    //This function will set all the numbers to the current day's recommendations
//    //Kcals left will be changed
//    //Breakfast recommendation calories will be changed
//    //Lunch recommendation calories will be changed
//    //Dinner recommendation calories will be changed
////    private func getToday(){
////
////        today.kCals = 50
////        today.bCals = 810
////        today.lCals = 803
////        today.dCals = 1598
////
////
////
////    }
//
//    //This function will set all the numbers to the yesterday's recommendations
//    //Kcals left will be changed
//    //Breakfast recommendation calories will be changed
//    //Lunch recommendation calories will be changed
//    //Dinner recommendation calories will be changed
////    private func getYesterday(){
////
////        yesterday.kCals = 4256
////        yesterday.bCals = 216
////        yesterday.lCals = 997
////        yesterday.dCals = 216
////
////
////
////    }
//
//    //This function will set all the numbers to the tomorrow's recommendations
//    //Kcals left will be changed
//    //Breakfast recommendation calories will be changed
//    //Lunch recommendation calories will be changed
//    //Dinner recommendation calories will be changed
////    private func getTomorrow(){
////
////        tomorrow.kCals = 526
////        tomorrow.bCals = 125
////        tomorrow.lCals = 168
////        tomorrow.dCals = 732
////
////
////
////    }
////
//
//    //This function will direct the user to today.
//    //The new page will be the same as today except with different numbers
//    //Different progress, and Kcals left/recommended.
//    //The page will have the same numbers when the user leaves the page and comes back
//    //The page does not have to be new, it can be the same page with different numbers
//    //so every time this button is pressed, it will just display different numbers
//    @IBOutlet weak var now: UIButton!
//
//    @IBAction func dayNow(_ sender: Any) {
//
//        todayButton.setTitleColor(.blue, for: .normal)
//        yesterdayButton.setTitleColor(.gray, for: .normal)
//        tomorrowButton.setTitleColor(.gray, for: .normal)
//
//
//        day = 0
//        printNumbers(kCalories: today.kCals, bCalories: today.bCals, lCalories: today.lCals, dCalories: today.dCals)
//        printFoods()
//    }
//
//    //This function will direct the user to the day before today.
//    //The new page will be the same as today except with different numbers
//    //Different progress, and Kcals left/recommended.
//    //The page will have the same numbers when the user leaves the page and comes back
//    //The page does not have to be new, it can be the same page with different numbers
//    //so every time this button is pressed, it will just display different numbers
//    @IBOutlet weak var before: UIButton!
//
//    @IBAction func dayBefore(_ sender: Any){
//
//        todayButton.setTitleColor(.gray, for: .normal)
//        yesterdayButton.setTitleColor(.blue, for: .normal)
//        tomorrowButton.setTitleColor(.gray, for: .normal)
//
//        day = -1
//        printNumbers(kCalories: yesterday.kCals, bCalories: yesterday.bCals, lCalories: yesterday.lCals, dCalories: yesterday.dCals)
//        printFoods()
//    }
//
//    //This function will direct the user to the day after today.
//    //The new page will be the same as today except with different numbers
//    //Different progress, and Kcals left/recommended.
//    //The page will have the same numbers when the user leaves the page and comes back
//    //The page does not have to be new, it can be the same page with different numbers
//    //so every time this button is pressed, it will just display different numbers
//    @IBOutlet weak var after: UIButton!
//
//    @IBAction func dayAfter(_ sender: Any){
//
//        todayButton.setTitleColor(.gray, for: .normal)
//        yesterdayButton.setTitleColor(.gray, for: .normal)
//        tomorrowButton.setTitleColor(.blue, for: .normal)
//
//        day = 1
//        printNumbers(kCalories: tomorrow.kCals, bCalories: tomorrow.bCals, lCalories: tomorrow.lCals, dCalories: tomorrow.dCals)
//        printFoods()
//    }
//
//    //Print foods function will print the foods that the user added to either breakfast, lunch, or dinner
//    //This is dependent on what day the user is currently displaying (today, tomorrow, yesterday)
//    //And it will display different foods for all breakfast. lunch and dinner.
//    //This will get an array, and checks the count.
//    //If the count is 0 then print "none", else print all the foods in the array
//    public func printFoods(){
//
//
//        //Check to see if current day displayed is equal to today
//        if day == 0{
//
//            //This section is for today's breakfast foods
//            if today.breakfastMeals.count == 0{
//                mealFoods.text = "Foods: None"
//            } else{
//
//                var n: String = "Foods: "
//                for i in today.breakfastMeals {
//                    n += i.name + ", "
//                }
//                mealFoods.text = n
//
//            }
//
//        }
//
//            //Check to see if current day displayed is equal to yesterday
//        else if day == -1{
//
//            //This section is for yesterday's breakfast foods
//            if yesterday.breakfastMeals.count == 0{
//                mealFoods.text = "Foods: None"
//            } else{
//
//                var n: String = "Foods: "
//                for i in yesterday.breakfastMeals {
//                    n += i.name + ", "
//                }
//                mealFoods.text = n
//
//            }
//
//        }
//    }
//
//    // instantiate the contenView so animations can scroll with other contents in this view
//    @IBOutlet weak var contentView: UIView!
//    let shapeLayer = CAShapeLayer()
//
//
//    @IBOutlet weak var folateGoalTxt: UILabel!
//    @IBOutlet weak var ironGoalTxt: UILabel!
//    @IBOutlet weak var dGoalTxt: UILabel!
//    @IBOutlet weak var magGoalTxt: UILabel!
//    @IBOutlet weak var waterGoalTxt: UILabel!
//
//    override func viewDidLoad() {
//
//        super.viewDidLoad()
//
//        // initialize daily nutrient goals
//        initGoals()
//        folateGoalTxt.text = String(folateGoal) + "mg"
//        ironGoalTxt.text = String(ironGoal) + "mg"
//        dGoalTxt.text = String(vitaminDGoal) + "mg"
//        magGoalTxt.text = String(magnesiumGoal) + "mg"
//        waterGoalTxt.text = String(dailyWaterConsume) + "ml"
//
//
//        // Do any additional setup after loading the view, typically from a nib.
//        //Hides the navigation bar
//        self.navigationController?.isNavigationBarHidden = true
//
//        //get data for today, yesterday, and tomorrow
////        getToday()
////        getYesterday()
////        getTomorrow()
//
//        //Load data numbers dependent on what day it is
//        if day == 0{
//            dayNow(now)
//        } else if day == -1{
//            dayBefore(before)
//        } else if day == 1{
//            dayAfter(after)
//        }
//
//        // draw the score circle and its animation
//        let center = CGPoint(x: self.view.frame.width/2, y: 163)
//
//        // define stroke colors
//        let trackColor = UIColor(hue: 0, saturation: 0, brightness: 0.82, alpha: 0.2)
//        let strokeColor = UIColor(hue: 0.1528, saturation: 0.88, brightness: 0.97, alpha: 1.0)
//
//        // create the track layer
//        let circularPath = UIBezierPath(arcCenter: center, radius: 54, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi , clockwise: true)
//
//        let trackLayer = CAShapeLayer();
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = trackColor.cgColor
//        trackLayer.lineWidth = 10
//        trackLayer.fillColor = UIColor.clear.cgColor
//        // make the edge of stroke round and smooth
//        trackLayer.lineCap = kCALineCapRound
//        contentView.layer.addSublayer(trackLayer)
//
//        // create the shape layer
//        shapeLayer.path = circularPath.cgPath
//
//        shapeLayer.strokeColor = strokeColor.cgColor
//        shapeLayer.lineWidth = 10
//        shapeLayer.fillColor = UIColor.clear.cgColor
//        // make the edge of stroke round and smooth
//        shapeLayer.lineCap = kCALineCapRound
//
//        shapeLayer.strokeEnd = 0
//        contentView.layer.addSublayer(shapeLayer)
//        circleAnimation()
//
//    }
//
//    @objc private func circleAnimation() {
//        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        basicAnimation.toValue = 0.5
//        basicAnimation.duration = 2
//
//        // for animation to stay in the end
//        basicAnimation.fillMode = kCAFillModeForwards
//        basicAnimation.isRemovedOnCompletion = false
//
//        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
//    }
//
//    private func initGoals() {
//        folateGoal = 400
//        ironGoal = 8
//        magnesiumGoal = 240
//        vitaminDGoal = 100
//        dailyWaterConsume = 2000
//        dailyWaterGlassNumber = dailyWaterConsume / 250
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    //When button is clicked to direct to new view, that view depends on which button you tap (for same view)
//    //This function passes data from current view to navigation bar to the actual next view.
//    //Add breakfast button changes title to Breakfasts
//    //Add lunch button changes title to Lunches
//    //Add dinner button changes title to Dinners
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//
//        //Breakfast button is pressed
//        if segue.identifier == "AddMeal"{
//
//            //connect to table view
//            let dest = segue.destination as! MealTableViewController
//
//            //Dest is the Meal table view. Change properties below
//            dest.title = "Breakfasts"
//
//        }
//
//    }
//
//
//
//
//}
//

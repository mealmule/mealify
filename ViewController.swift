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
import Charts


//Global variables

//The date chosen from the calendar
var dateChosenGlo: String?


class ViewController: UIViewController, ChartViewDelegate {
    
    let group = DispatchGroup()

    //Properties and labels
    @IBOutlet weak var kcalsLeft: UILabel!
    @IBOutlet weak var mealRecommend: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var mealFoods: UILabel!
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartView!
    
    @IBOutlet weak var pieChart: PieChartView!
    let micronutrients: [String] = ["Folate", "Iron", "Magnesium", "Vitamin D"]
    var micronutrient_amount: [Double] = []
    var micronutrient_score: [Double] = []
    
    let macronutrients: [String] = ["Carbohydrates", "Fats", "Proteins"]
    var macronutrient_amount: [Double] = []
    var macronutrient_score: [Double] = []
    
    
    
    let shapeLayer = CAShapeLayer()
    //The selected day's properties (meals, nutrients)
    var today = Number()
    
    //Variables
    var userScore: Double = 0.0
    var folateGoal: Double = 0
    var ironGoal: Double = 0
    var magnesiumGoal: Double = 0
    var vitaminDGoal: Double = 0
    var dailyWaterConsume: Double = 0
    var dailyWaterGlassNumber: Int = 0
    var proteinGoal: Double = 0
    var carbGoal: Double = 0
    var fatGoal: Double = 0
    
    // initialize progress bar color as yellow
    var strokeColor: UIColor = UIColor(hue: 0.2472, saturation: 0.42, brightness: 0.91, alpha: 1.0)
    
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var magGoalTxt: UILabel!
    @IBOutlet weak var dGoalTxt: UILabel!
    @IBOutlet weak var ironGoalTxt: UILabel!
    @IBOutlet weak var folateGoalTxt: UILabel!
    @IBOutlet weak var waterGoalTxt: UILabel!
    
    @IBOutlet weak var carbProgress: UIProgressView!
    @IBOutlet weak var proteinProgress: UIProgressView!
    @IBOutlet weak var fatProgress: UIProgressView!
    
    
    //Get today's date
    let dateFormatter = DateFormatter()
    var todayFormatted = ""
    
    //Firebase database reference and handle for retrieveing foods
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    //Get the userID
    let userID = (Auth.auth().currentUser?.uid)!
    var userInfo = UserDaily()
    
    
    
    
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
                let foodID = allNames["foodID"] as! Int
                let mn = allNames["mealNumber"] as! Int
                
                //Turn it into a meal
                var meal = allMeals[self.binarySearch(arr: allMeals, searchItem: foodID)]
                meal.mealNumber = mn
                
                //Add meal into array
                self.today.userMeals += [meal]

            }
            
            //Load data numbers dependent on what day it is
            self.printFoods()
            

            
        })
        
        
    }
    
    //TODO:
    //*
    //*
    //*
    //Precondition: array must be sorted
    //If element is not found, then return nil
    //Else return the index in which the object is contained
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
 
    // happy face indicates user's daily socre status
    @IBOutlet weak var face: UIImageView!
    
    fileprivate func drawFace() {
        // if user score is meet certain level, change the stroke color of the circle
        if (userScore >= 3 && userScore < 7.5) {
            strokeColor = UIColor(hue: 0.2472, saturation: 0.61, brightness: 0.9, alpha: 1.0)
            face.image = #imageLiteral(resourceName: "face_2")
        } else if (userScore >= 7.5) {
            strokeColor = UIColor(hue: 0.2472, saturation: 0.42, brightness: 0.91, alpha: 1.0)
            face.image = #imageLiteral(resourceName: "face_3")
        } else {
            face.image = #imageLiteral(resourceName: "face1")
        }
        // draw the progress indicator
        circleAnimation()
        print("User score: " + String(userScore))
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let userID = (Auth.auth().currentUser?.uid)!
        
        
        //User Interface of the view controller begins here
        
//        // initialize daily nutrient goals
//        initGoals()
//        folateGoalTxt.text = String(folateGoal) + "µg"
//        ironGoalTxt.text = String(ironGoal) + "mg"
//        dGoalTxt.text = String(vitaminDGoal) + "IU"
//        magGoalTxt.text = String(magnesiumGoal) + "mg"
//
//        //waterGoalTxt.text = String(dailyWaterConsume) + "ml"
//
//        // progressbar animation
//        // draw the score circle and its animation
//
//        // define stroke colors
//        let trackColor = UIColor(hue: 0, saturation: 0, brightness: 0.82, alpha: 0.2)
//
//        drawFace()
//
//
//        // create the track layer
//        let circularPath = UIBezierPath(arcCenter: .zero, radius: 58, startAngle: 0, endAngle: 2 * CGFloat.pi , clockwise: true)
//
//        let trackLayer = CAShapeLayer();
//        trackLayer.path = circularPath.cgPath
//        trackLayer.strokeColor = trackColor.cgColor
//        trackLayer.lineWidth = 10
//        trackLayer.fillColor = UIColor.clear.cgColor
//        trackLayer.position = CGPoint(x: self.view.frame.width/2, y: 125)
//
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
//        shapeLayer.position = CGPoint(x: self.view.frame.width/2, y: 125)
//        shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
//
//        // make the edge of stroke round and smooth
//        shapeLayer.lineCap = kCALineCapRound
//
//        shapeLayer.strokeEnd = 0
//        contentView.layer.addSublayer(shapeLayer)
//        circleAnimation()
        
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
        

        
        
        // Do any additional setup after loading the view, typically from a nib.
        //Hides the navigation bar
        self.navigationController?.isNavigationBarHidden = true
        
        // Query the nutrient history for micro and macronutrients for a given day
        databaseHandle = self.ref?.child("nutrientHistory").child(userID).child(dateChosenGlo!).observe(.value, with: {(snapshot) in
            
            
            
            
            //User Interface of the view controller begins here
            
            // initialize daily nutrient goals
            self.initGoals()
            self.loadFromDatabase()
            
            self.group.notify(queue: .main){
                
                self.folateGoalTxt.text = String(self.folateGoal) + "µg"
                self.ironGoalTxt.text = String(self.ironGoal) + "mg"
                self.dGoalTxt.text = String(self.vitaminDGoal) + "IU"
                self.magGoalTxt.text = String(self.magnesiumGoal) + "mg"
                
                //waterGoalTxt.text = String(dailyWaterConsume) + "ml"
                
                // progressbar animation
                // draw the score circle and its animation
                
                // define stroke colors
                let trackColor = UIColor(hue: 0, saturation: 0, brightness: 0.82, alpha: 0.2)
                
                self.drawFace()
                
                
                // create the track layer
                let circularPath = UIBezierPath(arcCenter: .zero, radius: 58, startAngle: 0, endAngle: 2 * CGFloat.pi , clockwise: true)
                
                let trackLayer = CAShapeLayer();
                trackLayer.path = circularPath.cgPath
                trackLayer.strokeColor = trackColor.cgColor
                trackLayer.lineWidth = 10
                trackLayer.fillColor = UIColor.clear.cgColor
                trackLayer.position = CGPoint(x: self.view.frame.width/2, y: 125)
                
                // make the edge of stroke round and smooth
                trackLayer.lineCap = kCALineCapRound
                self.contentView.layer.addSublayer(trackLayer)
                
                // create the shape layer
                self.shapeLayer.path = circularPath.cgPath
                
                self.shapeLayer.strokeColor = self.strokeColor.cgColor
                self.shapeLayer.lineWidth = 10
                self.shapeLayer.fillColor = UIColor.clear.cgColor
                self.shapeLayer.position = CGPoint(x: self.view.frame.width/2, y: 125)
                self.shapeLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
                
                // make the edge of stroke round and smooth
                self.shapeLayer.lineCap = kCALineCapRound
                
                self.shapeLayer.strokeEnd = 0
                self.contentView.layer.addSublayer(self.shapeLayer)
                self.circleAnimation()
                
                //User interface code ends here.
                
                
                let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                

                self.micronutrient_amount = [
                    (snapDictionary["folate"] as? Double ?? 0.0)/self.folateGoal,
                    (snapDictionary["iron"] as? Double ?? 0.0)/self.ironGoal,
                    (snapDictionary["magnesium"] as? Double ?? 0.0)/self.magnesiumGoal,
                    (snapDictionary["vitaminD"] as? Double ?? 0.0)/self.vitaminDGoal
                ]
                self.macronutrient_amount = [
                    (snapDictionary["carbohydrates"] as? Double ?? 0.0)/self.carbGoal,
                    (snapDictionary["fats"] as? Double ?? 0.0)/self.fatGoal,
                    (snapDictionary["proteins"] as? Double ?? 0.0)/self.proteinGoal
                ]

                // load progress bar with values
                self.carbProgress.setProgress(Float(self.macronutrient_amount[0]), animated: true)
                self.proteinProgress.setProgress(Float(self.macronutrient_amount[2]), animated: true)
                self.fatProgress.setProgress(Float(self.macronutrient_amount[1]), animated: true)
                
                var userScoreContainer: Double = 0.0
                

                
                // add up all numbers
                for i in 0...self.micronutrient_amount.count - 1 {
                    
                    if self.micronutrient_amount[i] > 1{
                        userScoreContainer = userScoreContainer + 1.0
                    }
                    else{
                        userScoreContainer = userScoreContainer + self.micronutrient_amount[i]
                    }
                }
                

                
                // add up all numbers
                for i in 0...self.macronutrient_amount.count - 1 {
                    
                    if self.macronutrient_amount[i] > 1{
                        userScoreContainer = userScoreContainer + 1.0
                    }
                    else{
                        userScoreContainer = userScoreContainer + self.macronutrient_amount[i]
                    }
                }
                
                self.userScore = Double(round(Double(userScoreContainer / 7 * 10) * 10) / 10)
                self.drawFace()
                print("user score: ", self.userScore)
                print("user score container: ", userScoreContainer)
                print("folate: " + String(self.micronutrient_amount[0]))
                print("iron: " + String(self.micronutrient_amount[1]))
                print("magnesium: " + String(self.micronutrient_amount[2]))
                print("vitaminD: " + String(self.micronutrient_amount[3]))
                
                self.ref?.child("nutrientHistory").child(userID).child("userScore").setValue(self.userScore)
                
                print(self.micronutrient_amount)
                print(self.macronutrient_amount)
                self.setHorizontalChart(dataPoints: self.micronutrients, values: self.micronutrient_amount)
                self.setPieChart(dataPoints: self.macronutrients, values: self.macronutrient_amount)
            }
            
        })
        
        
        
    }
    
    //TODO: Have these goals selected from database instead of being hardcoded
    //Currently, these values are hard coded
    //*
    //*
    //*
    //Changes the variables in these goals to hard coded values
    private func initGoals() {
        
        //Group dispatch here so it can wait for completion before executing code
        group.enter()
        //Retrieve all user info from the user on selected date and put them in today.userMeals()
        ref?.child("nutrientHistory").child(userID).observeSingleEvent(of: .value, with: { (snapshot) in
            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                let age = Float(allNames["age"] as! String)
                let gender = allNames["gender"] as! String
                
                self.userInfo = UserDaily(gender: gender, age: age!)
                
                // get daily goals from UserDaily class based on gender and age
                self.proteinGoal = self.userInfo.proteinsDaily
                self.carbGoal = self.userInfo.carbohydratesDaily
                self.fatGoal = self.userInfo.fatsDaily
                self.folateGoal = self.userInfo.folateDaily
                self.ironGoal = self.userInfo.ironDaily
                self.vitaminDGoal = self.userInfo.vitaminDDaily
                self.magnesiumGoal = self.userInfo.magnesiumDaily
                
                self.dailyWaterConsume = self.userInfo.moistureDaily
                self.dailyWaterGlassNumber = Int (self.dailyWaterConsume / 250)
                
                self.group.leave()
                
            }
        })
        
        
        
    }
    
    
    //Creates a circle animation.
    @objc private func circleAnimation() {
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = userScore / 10
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
            
            //Find the meal number to put into database
            var maxi = 0
            
            for i in today.userMeals{
                
                if i.mealNumber > maxi{
                    maxi = i.mealNumber
                }
                
            }
            
            //Give number of meals to next
            dest.numberOfDayMeals = maxi + 1
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
    
    func setHorizontalChart(dataPoints: [String], values: [Double]) {
        let xaxis : XAxis = XAxis()
        let chartFormatter = ChartFormatter(labels: micronutrients)
        
        
        var dataEntries: [ChartDataEntry] = []
        let colors: [UIColor] = [
            UIColor(red: 248, green: 231, blue: 28),
            UIColor(red: 248, green: 231, blue: 28),
            UIColor(red: 152, green: 214, blue: 224),
            UIColor(red: 152, green: 214, blue: 224)
        ]
        
        for i in 0..<dataPoints.count {
            print(i)
            let dataEntry = BarChartDataEntry(x: Double(i) * 5, y: values[i])
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataset = BarChartDataSet(values: dataEntries, label: "Per unit")
        
        xaxis.valueFormatter = chartFormatter
        
        
        
        chartDataset.colors = ChartColorTemplates.joyful()
        // chartDataset.colors = colors
        let chartData = BarChartData()
        chartData.addDataSet(chartDataset)
        horizontalBarChart.leftAxis.enabled = false
        horizontalBarChart.rightAxis.enabled = false
        horizontalBarChart.rightAxis.drawGridLinesEnabled = false
        horizontalBarChart.rightAxis.drawAxisLineEnabled = true
        horizontalBarChart.rightAxis.drawTopYLabelEntryEnabled = true
        horizontalBarChart.rightAxis.drawLabelsEnabled = true
        horizontalBarChart.legend.enabled = false
        
        //        horizontalBarChart.xAxis.enabled = true
        horizontalBarChart.xAxis.labelPosition = .bottom
        horizontalBarChart.xAxis.drawAxisLineEnabled = false
        horizontalBarChart.xAxis.drawGridLinesEnabled = false
        
        // *************
        
        horizontalBarChart.xAxis.granularity = 5
        horizontalBarChart.xAxis.labelFont = .systemFont(ofSize: 12)
//        horizontalBarChart.xAxis.xOffset = 0
        horizontalBarChart.extraLeftOffset = 40
        
        // **************
        horizontalBarChart.data = chartData
        
        
        horizontalBarChart.xAxis.valueFormatter = xaxis.valueFormatter
        horizontalBarChart.animate(yAxisDuration: 2.5)
        horizontalBarChart.chartDescription?.text = ""
        
    }
    
    func setPieChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        let chartDataset = PieChartDataSet(values: dataEntries, label: nil)
        
        chartDataset.colors = ChartColorTemplates.vordiplom()
        
        let chartData = PieChartData(dataSet: chartDataset)
        pieChart.data = chartData
        pieChart.animate(yAxisDuration: 2.5)
        pieChart.legend.enabled = false
        pieChart.chartDescription?.text = ""
        
    }
    
}

public class ChartFormatter: NSObject, IAxisValueFormatter {
    var labels: [String] = []
    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return labels[Int(value)/5]
    }
    init(labels: [String]) {
        super.init()
        self.labels = labels
    }
}

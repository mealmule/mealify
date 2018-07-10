//
//  File: ChartsViewController.swift
//  mealify
//
//  Worked on by Justin Lew on 2018-06-29.
//  Copyright © 2018 mealmules. All rights reserved.
//
// ***************************************************
// ******************  Overview **********************
// ***************************************************
// This view controller utilizes the Charts API for iOS provided by the Githubt repository danielgindi
// Link to the repository https://github.com/danielgindi/Charts
// The chart displayed will require the users calories, carbohydrates, proteins and fats in their respective units (cals, and g) over a fixed period
//  of time.
// We will have to query from the database to obtain 4 arrays with calories, carbs, proteins, and diets and use that to call the setCharts function

// **********************************************
// ****************   BUGS   ********************
// **********************************************
// The set charts does not check to see if a nutrient array for a particular day (say July 1, 2018) exists
// This will happen if the user has not logged in for at least a day


import UIKit
import Charts
import Firebase
import FirebaseAuth
import FirebaseDatabase

class ChartsViewController: UIViewController, ChartViewDelegate {
    
    
    var days : [String]!
    var today = Date()
    let dateFormatter = DateFormatter()
    var todayFormatted = ""
    var ref : DatabaseReference?
    let cal = Calendar.current
    var calories : [Double] = []
    var carbohydrates : [Double] = []
    var proteins : [Double] = []
    var fats : [Double] = []
    
    @IBOutlet weak var lineChartView: LineChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Here is where we are supposed to query from the database of statistics for the past 10 days
        // Creating dummy data
        
//        days = ["Jan 1", "Jan 2", "Jan 3", "Jan 4", "Jan 5", "Jan 6", "Jan 7", "Jan 8", "Jan 9", "Jan 10"]
//        let calories = [200.0 , 150.0, 75.0, 300.0, 250.0, 200.0 , 150.0, 75.0, 300.0, 250.0]
//        let carbohydrates = calories.map { $0 / 2}
//        let fats = calories.map { $0 / 4 }
//        let proteins = calories.map { $0 / 3}
        
        let userID = Auth.auth().currentUser?.uid
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: today)
        
        ref = Database.database().reference().child("nutrientHistory").child(userID!)
        
        var dateArray : [String] = []
        var dateInitialize = ""
        for i in 0...7 {
            dateInitialize = self.dateFormatter.string(from: self.cal.date(byAdding: .day, value: -i, to: self.today)!)
            //            print(dateInitialize)
            dateArray.insert(dateInitialize, at: 0)
            
        }
        
        
        ref?.observe(.value, with: { (snapshot) in
            let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            
            for i in dateArray {
                //                print(type(of: snapDictionary[i]!["carbohydrates"]!! as! Double))
                self.carbohydrates.append(snapDictionary[i]!["carbohydrates"]!! as! Double)
                self.calories.append(snapDictionary[i]!["kCals"]!! as! Double)
                self.fats.append(snapDictionary[i]!["fats"]!! as! Double)
                self.proteins.append(snapDictionary[i]!["proteins"]!! as! Double)
            }
            self.setChart(dataPoints: dateArray, values: self.calories, values2: self.carbohydrates, values3: self.fats, values4: self.proteins)
        })
        
        
        
//        setChart(dataPoints: days, values: calories, values2: carbohydrates, values3: fats, values4: proteins)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setChart(dataPoints: [String], values: [Double], values2: [Double], values3: [Double], values4: [Double]) {
        lineChartView.noDataText = "There is no data to output. Please input some data!"
        //        lineChartView.delegate = self
        
        var dataEntries1 : [ChartDataEntry] = []
        var dataEntries2 : [ChartDataEntry] = []
        var dataEntries3 : [ChartDataEntry] = []
        var dataEntries4 : [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let caloriesDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            let carbohydratesDataEntry = ChartDataEntry(x: Double(i), y: values2[i])
            let fatsDataEntry = ChartDataEntry(x: Double(i), y: values3[i])
            let proteinsDataEntry = ChartDataEntry(x: Double(i), y: values4[i])
            dataEntries1.append(caloriesDataEntry)
            dataEntries2.append(carbohydratesDataEntry)
            dataEntries3.append(fatsDataEntry)
            dataEntries4.append(proteinsDataEntry)
            
        }
        
        let caloriesChartDataSet = LineChartDataSet(values: dataEntries1, label: "Calories")
        let carbohydratesChartDataSet = LineChartDataSet(values: dataEntries2, label: "Carbohydrates")
        let fatsChartDataSet = LineChartDataSet(values: dataEntries3, label: "Fats")
        let proteinsChartDataSet = LineChartDataSet(values: dataEntries4, label: "Proteins")
        
        
        // Make the lines cubic
        
        caloriesChartDataSet.mode = .cubicBezier
        carbohydratesChartDataSet.mode = .cubicBezier
        fatsChartDataSet.mode = .cubicBezier
        proteinsChartDataSet.mode = .cubicBezier
        
        // Change colours for all four lines
        
        caloriesChartDataSet.colors = [UIColor(red: 0, green: 0, blue: 1, alpha: 1)]
        carbohydratesChartDataSet.colors = [UIColor(red: 0, green: 1, blue: 0, alpha: 1)]
        fatsChartDataSet.colors = [UIColor(red: 1, green: 0, blue: 0, alpha: 1)]
        proteinsChartDataSet.colors = [UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1)]
        
        
        //        caloriesChartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!
        
        // Lets go change the x-axis points later
        
        
        let chartData = LineChartData()
        
        
        chartData.addDataSet(caloriesChartDataSet)
        chartData.addDataSet(carbohydratesChartDataSet)
        chartData.addDataSet(fatsChartDataSet)
        chartData.addDataSet(proteinsChartDataSet)
        lineChartView.data = chartData
        //        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.animate(xAxisDuration: 2.0, yAxisDuration: 2.0)
        
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

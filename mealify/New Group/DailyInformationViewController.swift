//
//  DailyInformationViewController.swift
//  mealify
//
//  Created by Justin Lew on 2018-07-14.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Charts



class DailyInformationViewController: UIViewController, RetrieveDateDelegate, ChartViewDelegate {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    
    var dateChosen: String?
    
    let micronutrients: [String] = ["Folate", "Iron", "Magnesium", "Vitamin A", "Vitamin D"]
    let micronutrient_amount: [Double] = [50, 100, 75, 50, 100]
    
    let macronutrients: [String] = ["Carbohydrates", "Fats", "Proteins"]
    let macronutrient_amount: [Double] = [50, 50, 50]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateLabel.text = dateChosen
        
        setHorizontalChart(dataPoints: micronutrients, values: micronutrient_amount)
        
        setPieChart(dataPoints: macronutrients, values: macronutrient_amount)
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getDateInformation(_ date: String) {
        print(date)
        DateLabel.text = date
    }
    
    func setHorizontalChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), y: values[i])
            
            
            dataEntries.append(dataEntry)
        }
        
        let chartDataset = BarChartDataSet(values: dataEntries, label: "Per unit")
        chartDataset.colors = ChartColorTemplates.material()
        
        var chartData = BarChartData()
        chartData.addDataSet(chartDataset)
        
        horizontalBarChart.data = chartData
        horizontalBarChart.animate(yAxisDuration: 2.5)
        
    }
    
    func setPieChart(dataPoints: [String], values: [Double]) {
        var dataEntries: [PieChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let dataEntry = PieChartDataEntry(value: values[i], label: dataPoints[i])
            dataEntries.append(dataEntry)
        }
        
        let chartDataset = PieChartDataSet(values: dataEntries, label: "Macronutrients")
        
        chartDataset.colors = ChartColorTemplates.material()
        
        let chartData = PieChartData(dataSet: chartDataset)
        pieChart.data = chartData
        pieChart.animate(yAxisDuration: 2.5)
        

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

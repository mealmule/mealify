//
//  DailyInformationViewController.swift
//  mealify
//
//  Created by Justin Lew on 2018-07-14.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

// Change log:
// ----- Version 1 ------
// Import charts to view controller to output pie chart and horitzontal bar chart
// Specified actual date of input depending on the calendar date chosen by the user

// ----- Version 2 ------
// Query from databse to obtain actual data of users
// Pipe data to charts API


// Bugs:
// ----- Bug 1 ------
// Have to obtain dateChosen from calendar but I'm waiting on Juey to change the view first :)
// The app works nonetheless hahaha


import UIKit
import Charts
import Firebase
import FirebaseDatabase
import FirebaseAuth
import FirebaseStorage
import SDWebImage


class DailyInformationViewController: UIViewController, RetrieveDateDelegate, ChartViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var horizontalBarChart: HorizontalBarChartView!
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func profileButton(_ sender: Any) {
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Remove Current Photo", style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: "Take Photo", style: .default, handler:
            { action in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.camera
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
        ))
        alert.addAction(UIAlertAction(title: "Choose from Library", style: .default, handler:
            { action in
                if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.photoLibrary) {
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
                    imagePicker.allowsEditing = true
                    self.present(imagePicker, animated: true, completion: nil)
                }
            }
        ))
        self.present(alert, animated: true)
    }
    
    var dateChosen: String?
    
    var ref : DatabaseReference?
    
    var today = Date()
    
    let micronutrients: [String] = ["Folate", "Iron", "Magnesium", "Vitamin D"]
    var micronutrient_amount: [Double] = []
    
    let macronutrients: [String] = ["Carbohydrates", "Fats", "Proteins"]
    var macronutrient_amount: [Double] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let userID = (Auth.auth().currentUser?.uid)!
        
        ref = Database.database().reference()
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let reference = storageRef.child("images/profile/\(userID).png")
        reference.downloadURL { (url, error) in
            self.profilePicture.sd_setImage(with: url)
        }
        
        
        
        
        DateLabel.text = dateChosen
        
        // use todays date for now
        // ***********************
        // ***********************
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        var todayFormatted = formatter.string(from: today)
        
        // ***********************
        // ***********************
        // ***********************
        
    self.ref?.child("nutrientHistory").child(userID).child(todayFormatted).observeSingleEvent(of: .value, with: {(snapshot) in
        let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
        self.micronutrient_amount = [
            snapDictionary["folate"]! as! Double,
            snapDictionary["iron"]! as! Double,
            snapDictionary["magnesium"]! as! Double,
            snapDictionary["vitaminD"]! as! Double
        ]
        self.macronutrient_amount = [
            snapDictionary["carbohydrates"]! as! Double,
            snapDictionary["fats"]! as! Double,
            snapDictionary["proteins"]! as! Double
        ]
        print(self.micronutrient_amount)
        print(self.macronutrient_amount)
        self.setHorizontalChart(dataPoints: self.micronutrients, values: self.micronutrient_amount)
        self.setPieChart(dataPoints: self.macronutrients, values: self.macronutrient_amount)
    })
        
        // Do any additional setup after loading the view.
    }
    
    //Todo:
    //*
    //*
    //*
    //Back button functionality.
    //Give functionality to the back button so whenever it is pressed, it will perform an action
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        //Is popped from the view controller (back button)
        if self.isMovingFromParentViewController {
            
            //Hide navigation bar
            self.navigationController?.isNavigationBarHidden = true
        }
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true, completion: nil)
        
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        let storage = Storage.storage()
        var data = Data()
        data = UIImagePNGRepresentation(chosenImage)!
        let storageReference = storage.reference()
        let userID = (Auth.auth().currentUser?.uid)!
        var imageReference = storageReference.child("images/profile/\(userID).png")
        _ = imageReference.putData(data, metadata: nil, completion: {(metadata, error) in
            guard let metadata = metadata else {
                print(error)
                return
            }
        })
        
        
        
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

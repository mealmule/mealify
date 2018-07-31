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
    @IBOutlet weak var lineChartView: LineChartView!
    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func profileButton(_ sender: Any) {
        let alert = UIAlertController(title: "Change Profile Photo", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Remove Current Photo", style: .default, handler:
            { action in
                var profilePictureReference = Storage.storage().reference().child("images/profile/\((Auth.auth().currentUser?.uid)!).png")
                profilePictureReference.delete { error in
                    if let error = error {
                        print(error)
                    } else {
                        self.profilePicture.image = nil
                    }
                }
        }))
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
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    var days : [String]!
    let micronutrients: [String] = ["Folate", "Iron", "Magnesium", "Vitamin D"]
    var micronutrient_amount: [Double] = []
    
    let macronutrients: [String] = ["Carbohydrates", "Fats", "Proteins"]
    var macronutrient_amount: [Double] = []
    
    var carbohydrates : [Double] = []
    var proteins : [Double] = []
    var fats : [Double] = []
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // make profile picture circular
        
        
        profilePicture.layer.borderWidth = 1
        profilePicture.layer.masksToBounds = false
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        profilePicture.clipsToBounds = true
        
        let storage = Storage.storage()
        let storageRef = storage.reference()
        
        
        
        let userID = (Auth.auth().currentUser?.uid)!
        
        ref = Database.database().reference()
        
        
        let reference = storageRef.child("images/profile/\(userID).png")
        reference.downloadURL { (url, error) in
            self.profilePicture.sd_setImage(with: url)
        }

        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        var todayFormatted = formatter.string(from: today)

        var dateArray : [String] = []
        var dateInitialize = ""
        for i in 0...7 {
            dateInitialize = formatter.string(from: self.cal.date(byAdding: .day, value: -i, to: self.today)!)
            //            print(dateInitialize)
            dateArray.insert(dateInitialize, at: 0)
            
        }
        
        print(dateArray)
        // this querys the carbs, fats and proteins for the past few days
        ref?.child("nutrientHistory/\(userID)").observe(.value, with: { (snapshot) in
            let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            
            for i in dateArray {
                self.carbohydrates.append(snapDictionary[i]!["carbohydrates"] as? Double ?? 0.0)
                self.fats.append(snapDictionary[i]!["fats"] as? Double ?? 0.0)
                self.proteins.append(snapDictionary[i]!["proteins"] as? Double ?? 0.0)
            }
            self.setChart(dataPoints: dateArray, values: self.carbohydrates, values2: self.fats, values3: self.proteins)
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

    
    func setChart(dataPoints: [String], values: [Double], values2: [Double], values3: [Double]) {
        lineChartView.noDataText = "There is no data to output. Please input some data!"
        //        lineChartView.delegate = self
        
        var dataEntries1 : [ChartDataEntry] = []
        var dataEntries2 : [ChartDataEntry] = []
        var dataEntries3 : [ChartDataEntry] = []
        
        for i in 0..<dataPoints.count {
            let carbohydratesDataEntry = ChartDataEntry(x: Double(i), y: values[i])
            let fatsDataEntry = ChartDataEntry(x: Double(i), y: values2[i])
            let proteinsDataEntry = ChartDataEntry(x: Double(i), y: values3[i])
            dataEntries1.append(carbohydratesDataEntry)
            dataEntries2.append(fatsDataEntry)
            dataEntries3.append(proteinsDataEntry)
            
        }
        
        let carbohydratesChartDataSet = LineChartDataSet(values: dataEntries1, label: "Carbohydrates")
        let fatsChartDataSet = LineChartDataSet(values: dataEntries2, label: "Fats")
        let proteinsChartDataSet = LineChartDataSet(values: dataEntries3, label: "Proteins")
        
        
        // Make the lines cubic
        
//        carbohydratesChartDataSet.mode = .cubicBezier
//        fatsChartDataSet.mode = .cubicBezier
//        proteinsChartDataSet.mode = .cubicBezier
        
        // Change colours for all four lines
        
        carbohydratesChartDataSet.colors = [UIColor(red: 0, green: 1, blue: 0, alpha: 1)]
        fatsChartDataSet.colors = [UIColor(red: 1, green: 0, blue: 0, alpha: 1)]
        proteinsChartDataSet.colors = [UIColor(red: 0.2, green: 0.3, blue: 0.5, alpha: 1)]
        
        
        //        caloriesChartDataSet.valueFont = UIFont(name: "Helvetica", size: 12.0)!
        
        // Lets go change the x-axis points later
        
        
        let chartData = LineChartData()
        
        
        chartData.addDataSet(carbohydratesChartDataSet)
        chartData.addDataSet(fatsChartDataSet)
        chartData.addDataSet(proteinsChartDataSet)
        lineChartView.data = chartData
//        lineChartView.drawGridBackgroundEnabled = false
        lineChartView.xAxis.drawGridLinesEnabled = false
        lineChartView.xAxis.drawAxisLineEnabled = true
        lineChartView.rightAxis.drawGridLinesEnabled = false
        lineChartView.leftAxis.drawGridLinesEnabled = false
        //        lineChartView.xAxis.labelPosition = .bottom
        lineChartView.animate(xAxisDuration: 1.0, yAxisDuration: 1.0)
        
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
        profilePicture.image = chosenImage
        
        
        
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

//public class ChartFormatter: NSObject, IAxisValueFormatter {
//    var labels: [String] = []
//    public func stringForValue(_ value: Double, axis: AxisBase?) -> String {
//        return labels[Int(value)]
//    }
//    init(labels: [String]) {
//        super.init()
//        self.labels = labels
//    }
//}

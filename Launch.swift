//
//  Launch.swift
//  mealify
//
//  Created by vincent on 2018-07-28.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation
import UIKit
import Firebase

var allMeals = [Meal]()
var mealNutrients = [NutrientMealInfo]()
var nutrients = [Nutrients]()
var measures = [Measure]()
var conversion = [MeasureConversion]()




class LaunchViewController: UIViewController {
    
    
    var ref1: DatabaseReference!
    var ref2: DatabaseReference!
    var ref3: DatabaseReference!
    var ref4: DatabaseReference!
    var ref5: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    var mealsFilled = false
    var mealNutrientsFilled = false
    var nutrientsFilled = false
    var measureFilled = false
    var conversionFilled = false
    var rep = true
    
    let group = DispatchGroup()
    
    func getData1(){
        
        group.enter()
        loadAllMeals(completionHandler: {done in
            
            
            if done{
                print("Done Loading")
                self.group.leave()
            }
            
            
        })
        
    }
    
    func getData2(){
        
        group.enter()
        loadMealNutrients(completionHandler: {message in
            
            
            if message == ""{
                print("Done Loading")
                self.group.leave()
            }
            
         
            
            
            
            
        })
        
    }
    
    func getData3(){
        
        group.enter()
        loadNutrients(completionHandler: {message in
            
            if message == ""{
                print("Done Loading")
                self.group.leave()
            }
            
            
            
        })
        
    }
    
    func getData4(){
        
        group.enter()
        loadMeasures(completionHandler: {message in
            
            
            
            if message == ""{
                print("Done Loading")
                self.group.leave()
            }
            
            
            
        })
        
    }
    
    func getData5(){
        print("Done HEHEHe")
        group.enter()
        loadConversion(completionHandler: {message in
            
            
            
            if message == ""{
                print("Done Loading")
                self.group.leave()
            }
            
            
            
        })
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ref1 = Database.database(url: "https://mealify-7babd-2e44f.firebaseio.com/").reference()
        ref2 = Database.database(url: "https://mealify-7babd-78a83.firebaseio.com/").reference()
        ref3 = Database.database(url: "https://mealify-7babd-a6cd5.firebaseio.com/").reference()
        ref4 = Database.database(url: "https://mealify-7babd-b53b7.firebaseio.com/").reference()
        ref5 = Database.database(url: "https://mealify-7babd-cf680.firebaseio.com/").reference()
        
    
        
        
        
        getData1()
        getData2()
        getData3()
        getData4()
        getData5()
        
       
        group.notify(queue: .main){
            self.loadMeals()
        }

        
    }
    

    
    func loadAllMeals(completionHandler:@escaping (_ done: Bool)->()){
        
        databaseHandle = ref1?.observe(.childAdded, with: { (snapshot) in

            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
               
                let userInterest = allNames["FoodDescription"] as! String
                let foodID = allNames["FoodID"] as! Int
                
                allMeals += [Meal(name: userInterest, foodID: foodID, mealNumber: -1)]
                
                
                if allMeals.count != 5690 {
                    
                    completionHandler(false)
                }
                else{
                    completionHandler(true)
                }
                
            }
       
            
        })
        
    }
    
    func loadMealNutrients(completionHandler:@escaping (_ message: String)->()){
        
        databaseHandle = ref2?.observe(.childAdded, with: { (snapshot) in
          
            if let allNames = snapshot.value as? [String:AnyObject] {
              
                let nutrientID = allNames["NutrientID"] as! Int
                let foodID = allNames["FoodID"] as! Int
                let nutrientSourceID = allNames["NutrientSourceID"] as! Int
                let nutrientValue = allNames["NutrientValue"] as! NSNumber
                
                
                mealNutrients += [NutrientMealInfo(foodID: foodID, nutrientID: nutrientID, nutrientSourceID: nutrientSourceID, nutrientValue: nutrientValue)]
                
               
                if mealNutrients.count != 44060 {
                    
                    completionHandler("Loaded Meal Nutrients")
                }
                else{
               
                    completionHandler("")
                }
                
                
                
                
            }
            
            
            
            
            
        })
        
    }
    
    func loadNutrients(completionHandler:@escaping (_ message: String)->()){
        
        databaseHandle = ref3?.observe(.childAdded, with: { (snapshot) in
          
            if let allNames = snapshot.value as? [String:AnyObject] {
         
                let nutrientCode = allNames["NutrientCode"] as! Int
                let nutrientDecimals = allNames["NutrientDecimals"] as! Int
                let nutrientName = allNames["NutrientName"] as! String
                let nutrientNameF = allNames["NutrientNameF"] as! String
                let nutrientSymbol = allNames["NutrientSymbol"] as! String
                let nutrientUnit = allNames["NutrientUnit"] as! String
                let tagName = allNames["Tagname"] as! String
                
                nutrients += [Nutrients(nutrientCode: nutrientCode, nutrientDecimals: nutrientDecimals, nutrientName: nutrientName, nutrientNameF: nutrientNameF, nutrientSymbol: nutrientSymbol, nutrientUnit: nutrientUnit, tagName: tagName)]
                
                if nutrients.count != 8 {
                    completionHandler("Loaded Nutrients")
                }
                else{
                    completionHandler("")
                }
                
                
            }
            
            
            
            
            
        })
        
    }
    
    func loadMeasures(completionHandler:@escaping (_ message: String)->()){

        databaseHandle = ref4?.observe(.childAdded, with: { (snapshot) in
           
            if let allNames = snapshot.value as? [String:AnyObject] {
                
              
                let measureID = allNames["MeasureID"] as! Int
                let measureDescription = allNames["MeasureDescription"] as! String
                measures += [Measure(measureDescription: measureDescription, measureID: measureID)]
                
                if measures.count != 1162 {
                    completionHandler("Loaded Measures")
                }
                else{
                    completionHandler("")
                }
                
                
                
            }
            
            
            
            
            
        })
        
    }
    
    func loadConversion(completionHandler:@escaping (_ message: String)->()){
        
        databaseHandle = ref5?.observe(.childAdded, with: { (snapshot) in
          
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                
                let measureID = allNames["MeasureID"] as! Int
                let foodID = allNames["FoodID"] as! Int
                let conversionFactorValue = allNames["ConversionFactorValue"] as! Double
                conversion += [MeasureConversion(foodID: foodID, measureID: measureID, conversionFactorValue: conversionFactorValue)]
                
                if conversion.count != 19505 {
                    completionHandler("Loaded Conversions")
                }
                else{
                    completionHandler("")
                }
                
                
            }
            
            
        })
        
    }
    
    
    public func loadMeals(){
        
        print("ALLMEALS 5690: " + String(allMeals.count))
        print("NUTRIENTS: " + String(mealNutrients.count))
        print("NUTS 8: " + String(nutrients.count))
        print("MEASURE 1162: " + String(measures.count))
        print("CONvERSION 19505: " + String(conversion.count))
        
        
        
        allMeals.sort(by: {$0.foodID < $1.foodID})
        
        for k in mealNutrients{
            
            let index = binarySearch(arr: allMeals, searchItem: k.foodID)
            allMeals[index].nutrients += [k]
            
            
            
//            for i in allMeals{
//
//                if i.foodID == k.foodID{
//                    i.nutrients += [k]
//                    break
//                }
//
//            }
            
        }
        
        print("DONE 1")
        
            
      
        measures.sort(by: {$0.measureID < $1.measureID})
        
        //Go through conversion to find the measure name and conversion factor value
        //After those are found, then you can multiply conversion factor value with nutrient value
        //And you can get the measure description to display
        for i in conversion{
            
            
                
            //Get the measure description
            if  let index = binarySearchMeasure(arr: measures, searchItem: i.measureID){
                
                let index2 = binarySearch(arr: allMeals, searchItem: i.foodID)
                
                
                //We want grams and ml units, not 1/6 pie (20 cm diamater) or something
                //So we want the shortest string to have more probability of grams and ml units
                //Stringcount is 0 so we put anything in here for now
                if allMeals[index2].measure == ""{
                    
                    allMeals[index2].measure = "Measure: " + measures[index].measureDescription
                    
                    //Got the conversionFactorValue
                    allMeals[index2].factor = i.conversionFactorValue
                    
                }
                    //else if it is not 0, then compare and get least length
                else if measures[index].measureDescription.count < allMeals[index2].measure.count{
                    
                    allMeals[index2].measure = "Measure: " + measures[index].measureDescription
                    
                    //Got the conversionFactorValue
                    allMeals[index2].factor = i.conversionFactorValue
                    
                }
                
            }
            
        }
        
        print("DONE 2")
            
        
        
        self.performSegue(withIdentifier: "done", sender: self)
        
        
    }
    
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
    
    func binarySearchMeasure(arr: [Measure], searchItem: Int) -> Int? {
        var lowerIndex = 0;
        var upperIndex = arr.count - 1
        
        
        
        
        while (true) {
     
            let currentIndex = (lowerIndex + upperIndex)/2
            
            if(arr[currentIndex].measureID == searchItem) {
                return currentIndex
                
            }
            else if lowerIndex > upperIndex{
                return nil
            }
           
            else {
                if (arr[currentIndex].measureID > searchItem) {
                    upperIndex = currentIndex - 1
                }
                else {
                    lowerIndex = currentIndex + 1
                }
            }
        }
    }
    
    
}


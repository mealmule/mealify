//
//  FilterViewController.swift
//  mealify
//
//  Created by vincent on 2018-07-30.
//  Team name: Meal Mules
//  Changes made: Added filter feature
//  Known bugs: none
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

//Global variables for filter text
//This is so that you can store the text so that it can be saved when leaving view controller
var proteinsFilterGlo: String?
var fatsFilterGlo: String?
var carbsFilterGlo: String?
var moistureFilterGlo: String?
var ironFilterGlo: String?
var magnesiumFilterGlo: String?
var vitaminDFilterGlo: String?
var folateFilterGlo: String?

//Global variables for switches
//This is so that you can store the switch so that it can be saved when leaving view controller
var proteinsGGlo: Bool = true
var fatsGGlo: Bool = true
var carbsGGlo: Bool = true
var moistureGGlo: Bool = true
var ironGGlo: Bool = true
var magnesiumGGlo: Bool = true
var vitaminDGGlo: Bool = true
var folateGGlo: Bool = true

class FilterViewController: UIViewController, UITextFieldDelegate {
    
    //Labels for all the filters
    @IBOutlet weak var proteinsFilter: UITextField!
    @IBOutlet weak var fatsFilter: UITextField!
    @IBOutlet weak var carbsFilter: UITextField!
    @IBOutlet weak var moistureFilter: UITextField!
    @IBOutlet weak var ironFilter: UITextField!
    @IBOutlet weak var magnesiumFilter: UITextField!
    @IBOutlet weak var vitaminDFilter: UITextField!
    @IBOutlet weak var folateFilter: UITextField!
    
    //Switches for all the filters
    @IBOutlet weak var proteinsG: UISegmentedControl!
    @IBOutlet weak var fatsG: UISegmentedControl!
    @IBOutlet weak var carbsG: UISegmentedControl!
    @IBOutlet weak var moistureG: UISegmentedControl!
    @IBOutlet weak var ironG: UISegmentedControl!
    @IBOutlet weak var magnesiumG: UISegmentedControl!
    @IBOutlet weak var vitaminDG: UISegmentedControl!
    @IBOutlet weak var folateG: UISegmentedControl!
    
    func segmentState(sender: UISegmentedControl, state: Bool) {
        
        
        if state == true{
            
            sender.selectedSegmentIndex = 1
            
        }
        else{
            
            sender.selectedSegmentIndex = 0
            
        }
        
    }
    
    //TODO:
    //*
    //*
    //*
    //Button that clears all the filter to default
    //Change every thing back to what it was before
    @IBAction func clearFilters(_ sender: Any) {
        
        //Change all text to nil
        proteinsFilter.text = nil
        fatsFilter.text = nil
        carbsFilter.text = nil
        moistureFilter.text = nil
        magnesiumFilter.text = nil
        ironFilter.text = nil
        vitaminDFilter.text = nil
        folateFilter.text = nil
        
        //Change all this to nil
        proteinsFilterGlo = proteinsFilter.text
        fatsFilterGlo = fatsFilter.text
        carbsFilterGlo = carbsFilter.text
        moistureFilterGlo = moistureFilter.text
        magnesiumFilterGlo = magnesiumFilter.text
        ironFilterGlo = ironFilter.text
        vitaminDFilterGlo = vitaminDFilter.text
        folateFilterGlo = folateFilter.text
        
        //Change all switches to true
        proteinsGGlo = true
        fatsGGlo = true
        carbsGGlo = true
        moistureGGlo = true
        ironGGlo = true
        magnesiumGGlo = true
        vitaminDGGlo = true
        folateGGlo = true
        
        //Switch all switches to true
        segmentState(sender: proteinsG, state: true)
        segmentState(sender: fatsG, state: true)
        segmentState(sender: carbsG, state: true)
        segmentState(sender: moistureG, state: true)
        segmentState(sender: ironG, state: true)
        segmentState(sender: magnesiumG, state: true)
        segmentState(sender: vitaminDG, state: true)
        segmentState(sender: folateG, state: true)
        
        
    }
    
    //All the boolean variables to determine whether or not the switches are on
    var proteinsIsG: Bool = true
    var fatsIsG: Bool = true
    var carbsIsG: Bool = true
    var moistureIsG: Bool = true
    var ironIsG: Bool = true
    var magnesiumIsG: Bool = true
    var vitaminDIsG: Bool = true
    var folateIsG: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Text delegate
        proteinsFilter.delegate = self
        fatsFilter.delegate = self
        carbsFilter.delegate = self
        moistureFilter.delegate = self
        ironFilter.delegate = self
        magnesiumFilter.delegate = self
        vitaminDFilter.delegate = self
        folateFilter.delegate = self
        
        //Restore all previous filters
        proteinsFilter.text = proteinsFilterGlo
        fatsFilter.text = fatsFilterGlo
        carbsFilter.text = carbsFilterGlo
        moistureFilter.text = moistureFilterGlo
        magnesiumFilter.text = magnesiumFilterGlo
        ironFilter.text = ironFilterGlo
        vitaminDFilter.text = vitaminDFilterGlo
        folateFilter.text = folateFilterGlo
        
        //Restore all previous switches
        segmentState(sender: proteinsG, state: proteinsGGlo)
        segmentState(sender: fatsG, state: fatsGGlo)
        segmentState(sender: carbsG, state: carbsGGlo)
        segmentState(sender: moistureG, state: moistureGGlo)
        segmentState(sender: ironG, state: ironGGlo)
        segmentState(sender: magnesiumG, state: magnesiumGGlo)
        segmentState(sender: vitaminDG, state: vitaminDGGlo)
        segmentState(sender: folateG, state: folateGGlo)
        
        
        
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
            //Get nturients from the All Meals
            check()
            
            //If the nutrientsFiltered is not empty, store all the values
            if !nutrientsFilteredMeals.isEmpty{
                
                proteinsFilterGlo = proteinsFilter.text
                fatsFilterGlo = fatsFilter.text
                carbsFilterGlo = carbsFilter.text
                moistureFilterGlo = moistureFilter.text
                magnesiumFilterGlo = magnesiumFilter.text
                ironFilterGlo = ironFilter.text
                vitaminDFilterGlo = vitaminDFilter.text
                folateFilterGlo = folateFilter.text
            }
            
        }
    }
    
    
    //TODO:
    //*
    //*
    //*
    //Check for meals that fufil all the filters
    //This is dependent on all the filter fields
    //If theres nothing in the text fields, those fields are always true
    func check(){
        
        //Set this to empty for now
        nutrientsFilteredMeals = []
        
        
        //Search through all the meals
        for i in allMeals{
            
            //From all the nutrients in the meals
            for k in i.nutrients{
                
                //Keep track of whether it is proteins, fats, carbohydrates, moisture, iron, magnesium, vitaminD, or folate
                //If nutrient ID = protein
                if k.nutrientID == 203{
                    
                    //Get proteins filter if not nil
                    if let proteins = Double(proteinsFilter.text!){
                        
                        //If proteins switch is on, then it it is greater than
                        if proteinsG.selectedSegmentIndex == 1{
                            
                            //Proteins bool is set to this
                            proteinsIsG = Double(truncating: k.nutrientValue) * i.factor >= proteins
                            //Switch is on
                            proteinsGGlo = true
                            
                        }
                            //Else it is less than
                        else{
                            //Proteins bool is set to this
                            proteinsIsG = Double(truncating: k.nutrientValue) * i.factor < proteins
                            //Switch is off
                            proteinsGGlo = false
                        }
                    }
                        //Else by default, it is always true
                    else{
                        proteinsIsG = true
                    }
                    
                }
                    //Repeat for all the other nutrients, except its different nutrient id every time, and different varaibles
                else if k.nutrientID == 204{
                    if let fats = Double(fatsFilter.text!){
                        if fatsG.selectedSegmentIndex == 1{
                            
                            fatsIsG = Double(truncating: k.nutrientValue) * i.factor >= fats
                            fatsGGlo = true
                            
                        }
                        else{
                            fatsIsG = Double(truncating: k.nutrientValue) * i.factor < fats
                            fatsGGlo = false
                        }
                    }
                    else{
                        fatsIsG = true
                    }
                }
                else if k.nutrientID == 205{
                    if let carbs = Double(carbsFilter.text!){
                        if carbsG.selectedSegmentIndex == 1{
                            
                            carbsIsG = Double(truncating: k.nutrientValue) * i.factor >= carbs
                            carbsGGlo = true
                            
                        }
                        else{
                            carbsIsG = Double(truncating: k.nutrientValue) * i.factor < carbs
                            carbsGGlo = false
                        }
                    }
                    else{
                        carbsIsG = true
                    }
                }
                else if k.nutrientID == 255{
                    if let moisture = Double(moistureFilter.text!){
                        if moistureG.selectedSegmentIndex == 1{
                            
                            moistureIsG = Double(truncating: k.nutrientValue) * i.factor >= moisture
                            moistureGGlo = true
                            
                        }
                        else{
                            moistureIsG = Double(truncating: k.nutrientValue) * i.factor < moisture
                            moistureGGlo = false
                        }
                    }
                    else{
                        moistureIsG = true
                    }
                }
                else if k.nutrientID == 303{
                    if let iron = Double(ironFilter.text!){
                        if ironG.selectedSegmentIndex == 1{
                            
                            ironIsG = Double(truncating: k.nutrientValue) * i.factor >= iron
                            ironGGlo = true
                            
                        }
                        else{
                            ironIsG = Double(truncating: k.nutrientValue) * i.factor < iron
                            ironGGlo = false
                        }
                    }
                    else{
                        ironIsG = true
                    }
                }
                else if k.nutrientID == 304{
                    if let magnesium = Double(magnesiumFilter.text!){
                        if magnesiumG.selectedSegmentIndex == 1{
                            
                            magnesiumIsG = Double(truncating: k.nutrientValue) * i.factor >= magnesium
                            magnesiumGGlo = true
                            
                        }
                        else{
                            magnesiumIsG = Double(truncating: k.nutrientValue) * i.factor < magnesium
                            magnesiumGGlo = false
                        }
                    }
                    else{
                        magnesiumIsG = true
                    }
                }
                else if k.nutrientID == 324{
                    if let vitaminD = Double(vitaminDFilter.text!){
                        if vitaminDG.selectedSegmentIndex == 1{
                            
                            vitaminDIsG = Double(truncating: k.nutrientValue) * i.factor >= vitaminD
                            vitaminDGGlo = true
                            
                        }
                        else{
                            vitaminDIsG = Double(truncating: k.nutrientValue) * i.factor < vitaminD
                            vitaminDGGlo = false
                        }
                    }
                    else{
                        vitaminDIsG = true
                    }
                }
                else if k.nutrientID == 806{
                    if let folate = Double(folateFilter.text!){
                        //print ("FOLATE: " + String(folate))
                        if folateG.selectedSegmentIndex == 1{
                            
                            folateIsG = Double(truncating: k.nutrientValue) * i.factor >= folate
                            folateGGlo = true
                            
                        }
                        else{
                            folateIsG = Double(truncating: k.nutrientValue) * i.factor < folate
                            folateGGlo = false
                        }
                    }
                    else{
                        folateIsG = true
                    }
                }
                
                
            }
        
            
            //Now AND all of the nutrient booleans, and if all of them are true, then add the meal to the array
            //This would give the array all the meals with all the filters
            if proteinsIsG && fatsIsG && carbsIsG && ironIsG && magnesiumIsG && moistureIsG && vitaminDIsG && folateIsG{
                nutrientsFilteredMeals += [i]
            }
            
            
        }
        
        
        
    }
    
    
    
    
    
    //TODO:
    //*
    //*
    //*
    //This function checks to see if the text fields are numbers
    //If it is not numbers, do not allow the user to type it in
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        //Numbers that are invalid
        let invalidCharacters = CharacterSet(charactersIn: "0123456789").inverted
        return string.rangeOfCharacter(from: invalidCharacters, options: [], range: string.startIndex ..< string.endIndex) == nil
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

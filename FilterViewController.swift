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

var proteinsFilterGlo: String?
var fatsFilterGlo: String?
var carbsFilterGlo: String?
var moistureFilterGlo: String?
var ironFilterGlo: String?
var magnesiumFilterGlo: String?
var vitaminDFilterGlo: String?
var folateFilterGlo: String?

class FilterViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var proteinsFilter: UITextField!
    @IBOutlet weak var fatsFilter: UITextField!
    @IBOutlet weak var carbsFilter: UITextField!
    @IBOutlet weak var moistureFilter: UITextField!
    @IBOutlet weak var ironFilter: UITextField!
    @IBOutlet weak var magnesiumFilter: UITextField!
    @IBOutlet weak var vitaminDFilter: UITextField!
    @IBOutlet weak var folateFilter: UITextField!
    
    @IBOutlet weak var proteinsG: UISwitch!
    @IBOutlet weak var fatsG: UISwitch!
    @IBOutlet weak var carbsG: UISwitch!
    @IBOutlet weak var moistureG: UISwitch!
    @IBOutlet weak var ironG: UISwitch!
    @IBOutlet weak var magnesiumG: UISwitch!
    @IBOutlet weak var vitaminDG: UISwitch!
    @IBOutlet weak var folateG: UISwitch!
    

    @IBAction func clearFilters(_ sender: Any) {
        proteinsFilter.text = nil
        fatsFilter.text = nil
        carbsFilter.text = nil
        moistureFilter.text = nil
        magnesiumFilter.text = nil
        ironFilter.text = nil
        vitaminDFilter.text = nil
        folateFilter.text = nil
        
        proteinsFilterGlo = proteinsFilter.text
        fatsFilterGlo = fatsFilter.text
        carbsFilterGlo = carbsFilter.text
        moistureFilterGlo = moistureFilter.text
        magnesiumFilterGlo = magnesiumFilter.text
        ironFilterGlo = ironFilter.text
        vitaminDFilterGlo = vitaminDFilter.text
        folateFilterGlo = folateFilter.text
    }
    
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
        proteinsFilter.delegate = self
        fatsFilter.delegate = self
        carbsFilter.delegate = self
        moistureFilter.delegate = self
        ironFilter.delegate = self
        magnesiumFilter.delegate = self
        vitaminDFilter.delegate = self
        folateFilter.delegate = self
        
        proteinsFilter.text = proteinsFilterGlo
        fatsFilter.text = fatsFilterGlo
        carbsFilter.text = carbsFilterGlo
        moistureFilter.text = moistureFilterGlo
        magnesiumFilter.text = magnesiumFilterGlo
        ironFilter.text = ironFilterGlo
        vitaminDFilter.text = vitaminDFilterGlo
        folateFilter.text = folateFilterGlo
        
        
        
        
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

        
        //Is popped from the view controller (back button)
        if self.isMovingFromParentViewController {
            
            //Hide navigation bar
            check()
            
          
        }
    }
    
    func check(){
        
        nutrientsFilteredMeals = []
        
        
        for i in allMeals{
            
            for k in i.nutrients{
                
                //Keep track of whether it is proteins, fats, carbohydrates, moisture, iron, magnesium, vitaminD, or folate
                //Then set those values to temp so that it can be added into the database
                if k.nutrientID == 203{
                    if let proteins = Double(proteinsFilter.text!){
                        if proteinsG.isOn{
                            
                            proteinsIsG = Double(truncating: k.nutrientValue) * i.factor >= proteins
                            
                        }
                        else{
                            proteinsIsG = Double(truncating: k.nutrientValue) * i.factor < proteins
                        }
                    }
                    else{
                        proteinsIsG = true
                    }
                   
                }
                else if k.nutrientID == 204{
                    if let fats = Double(fatsFilter.text!){
                        if fatsG.isOn{
                            
                            fatsIsG = Double(truncating: k.nutrientValue) * i.factor >= fats
                            
                        }
                        else{
                            fatsIsG = Double(truncating: k.nutrientValue) * i.factor < fats
                        }
                    }
                    else{
                        fatsIsG = true
                    }
                }
                else if k.nutrientID == 205{
                    if let carbs = Double(carbsFilter.text!){
                        if carbsG.isOn{
                            
                            carbsIsG = Double(truncating: k.nutrientValue) * i.factor >= carbs
                            
                        }
                        else{
                            carbsIsG = Double(truncating: k.nutrientValue) * i.factor < carbs
                        }
                    }
                    else{
                        carbsIsG = true
                    }
                }
                else if k.nutrientID == 255{
                    if let moisture = Double(moistureFilter.text!){
                        if moistureG.isOn{
                            
                            moistureIsG = Double(truncating: k.nutrientValue) * i.factor >= moisture
                            
                        }
                        else{
                            moistureIsG = Double(truncating: k.nutrientValue) * i.factor < moisture
                        }
                    }
                    else{
                        moistureIsG = true
                    }
                }
                else if k.nutrientID == 303{
                    if let iron = Double(ironFilter.text!){
                        if ironG.isOn{
                            
                            ironIsG = Double(truncating: k.nutrientValue) * i.factor >= iron
                            
                        }
                        else{
                            ironIsG = Double(truncating: k.nutrientValue) * i.factor < iron
                        }
                    }
                    else{
                        ironIsG = true
                    }
                }
                else if k.nutrientID == 304{
                    if let magnesium = Double(magnesiumFilter.text!){
                        if magnesiumG.isOn{
                            
                            magnesiumIsG = Double(truncating: k.nutrientValue) * i.factor >= magnesium
                            
                        }
                        else{
                            magnesiumIsG = Double(truncating: k.nutrientValue) * i.factor < magnesium
                        }
                    }
                    else{
                        magnesiumIsG = true
                    }
                }
                else if k.nutrientID == 324{
                    if let vitaminD = Double(vitaminDFilter.text!){
                        if vitaminDG.isOn{
                            
                            vitaminDIsG = Double(truncating: k.nutrientValue) * i.factor >= vitaminD
                            
                        }
                        else{
                            vitaminDIsG = Double(truncating: k.nutrientValue) * i.factor < vitaminD
                        }
                    }
                    else{
                        vitaminDIsG = true
                    }
                }
                else if k.nutrientID == 806{
                    if let folate = Double(folateFilter.text!){
                        //print ("FOLATE: " + String(folate))
                        if folateG.isOn{
                            
                            folateIsG = Double(truncating: k.nutrientValue) * i.factor >= folate
                            
                        }
                        else{
                            folateIsG = Double(truncating: k.nutrientValue) * i.factor < folate
                        }
                    }
                    else{
                        folateIsG = true
                    }
                }
                
                
            }
            
            print(proteinsIsG, fatsIsG,carbsIsG,ironIsG,magnesiumIsG,moistureIsG,vitaminDIsG,folateIsG)
            if proteinsIsG && fatsIsG && carbsIsG && ironIsG && magnesiumIsG && moistureIsG && vitaminDIsG && folateIsG{
                
                nutrientsFilteredMeals += [i]
                
            }

            
        }
        
       
        
    }
    

    
    
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
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

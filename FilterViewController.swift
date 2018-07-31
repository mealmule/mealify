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

var proteinsGGlo: Bool = true
var fatsGGlo: Bool = true
var carbsGGlo: Bool = true
var moistureGGlo: Bool = true
var ironGGlo: Bool = true
var magnesiumGGlo: Bool = true
var vitaminDGGlo: Bool = true
var folateGGlo: Bool = true

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
        
        proteinsGGlo = true
        fatsGGlo = true
        carbsGGlo = true
        moistureGGlo = true
        ironGGlo = true
        magnesiumGGlo = true
        vitaminDGGlo = true
        folateGGlo = true
        
        proteinsG.setOn(proteinsGGlo, animated: false)
        fatsG.setOn(fatsGGlo, animated: false)
        carbsG.setOn(carbsGGlo, animated: false)
        moistureG.setOn(moistureGGlo, animated: false)
        ironG.setOn(ironGGlo, animated: false)
        magnesiumG.setOn(magnesiumGGlo, animated: false)
        vitaminDG.setOn(vitaminDGGlo, animated: false)
        folateG.setOn(folateGGlo, animated: false)
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
        
        proteinsG.setOn(proteinsGGlo, animated: true)
        fatsG.setOn(fatsGGlo, animated: true)
        carbsG.setOn(carbsGGlo, animated: true)
        moistureG.setOn(moistureGGlo, animated: true)
        ironG.setOn(ironGGlo, animated: true)
        magnesiumG.setOn(magnesiumGGlo, animated: true)
        vitaminDG.setOn(vitaminDGGlo, animated: true)
        folateG.setOn(folateGGlo, animated: true)
        
        
        
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
                            proteinsGGlo = true
                            
                        }
                        else{
                            proteinsIsG = Double(truncating: k.nutrientValue) * i.factor < proteins
                            proteinsGGlo = false
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
                        if carbsG.isOn{
                            
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
                        if moistureG.isOn{
                            
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
                        if ironG.isOn{
                            
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
                        if magnesiumG.isOn{
                            
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
                        if vitaminDG.isOn{
                            
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
                        if folateG.isOn{
                            
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

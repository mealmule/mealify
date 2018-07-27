//
//  ViewController.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-25.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase
class ViewController2: UIViewController {
    var ref: DatabaseReference?
    let userID = (Auth.auth().currentUser?.uid)!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var fish: UIButton!
    @IBAction func FishButton(_ sender: UIButton) {
        print("Fish chosen")
        fish.setTitleColor(UIColor .green, for: .normal)
       
        if((pork.titleColor(for: .normal) == .green) || (beef.titleColor(for: .normal) == .green) || (chicken.titleColor(for: .normal) == .green) || (noMeat.titleColor(for: .normal) == .green)){
    
            pork.setTitleColor(UIColor .blue, for: .normal)
            beef.setTitleColor(UIColor .blue, for: .normal)
            chicken.setTitleColor(UIColor .blue, for: .normal)
            noMeat.setTitleColor(UIColor .blue, for: .normal)
        }
 
    }
    
    @IBOutlet weak var pork: UIButton!
    @IBAction func PorkButton(_ sender: UIButton) {
        print("Pork chosen")
        pork.setTitleColor(UIColor .green, for: .normal)
        
        if((fish.titleColor(for: .normal) == .green) || (beef.titleColor(for: .normal) == .green) || (chicken.titleColor(for: .normal) == .green) || (noMeat.titleColor(for: .normal) == .green)){
       
            fish.setTitleColor(UIColor .blue, for: .normal)
            beef.setTitleColor(UIColor .blue, for: .normal)
            chicken.setTitleColor(UIColor .blue, for: .normal)
            noMeat.setTitleColor(UIColor .blue, for: .normal)
        }
 
    }
    
    @IBOutlet weak var beef: UIButton!
    @IBAction func BeefButton(_ sender: UIButton) {
        print("Beef chosen");
        beef.setTitleColor(UIColor .green, for: .normal)
        
        if((pork.titleColor(for: .normal) == .green) || (fish.titleColor(for: .normal) == .green) || (chicken.titleColor(for: .normal) == .green) || (noMeat.titleColor(for: .normal) == .green)){
      
            pork.setTitleColor(UIColor .blue, for: .normal)
            fish.setTitleColor(UIColor .blue, for: .normal)
            chicken.setTitleColor(UIColor .blue, for: .normal)
            noMeat.setTitleColor(UIColor .blue, for: .normal)
        }
 
    }
    
    @IBOutlet weak var chicken: UIButton!
    @IBAction func ChickenButton(_ sender: UIButton) {
        print("Chicken chosen")
        chicken.setTitleColor(UIColor .green, for: .normal)
        
        if((pork.titleColor(for: .normal) == .green) || (beef.titleColor(for: .normal) == .green) || (fish.titleColor(for: .normal) == .green) || (noMeat.titleColor(for: .normal) == .green)){

            pork.setTitleColor(UIColor .blue, for: .normal)
            beef.setTitleColor(UIColor .blue, for: .normal)
            fish.setTitleColor(UIColor .blue, for: .normal)
            noMeat.setTitleColor(UIColor .blue, for: .normal)
        }
 
    }
    @IBOutlet weak var noMeat: UIButton!
    @IBAction func noMeatButton(_ sender: UIButton) {
        print("no meat chosen")
        noMeat.setTitleColor(UIColor .green, for: .normal)
        
        if((pork.titleColor(for: .normal) == .green) || (beef.titleColor(for: .normal) == .green) || (chicken.titleColor(for: .normal) == .green) || (fish.titleColor(for: .normal) == .green)){

            pork.setTitleColor(UIColor .blue, for: .normal)
            beef.setTitleColor(UIColor .blue, for: .normal)
            chicken.setTitleColor(UIColor .blue, for: .normal)
            fish.setTitleColor(UIColor .blue, for: .normal)
        }
 
    }
    @IBOutlet weak var nextButton: UIButton!
    @IBAction func next(_ sender: UIButton) {
        if(pork.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("meatPref").setValue("pork")
        }else if(fish.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("meatPref").setValue("fish")
        }else if(beef.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("meatPref").setValue("beef")
        }else if(noMeat.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("meatPref").setValue("noMeat")
        }else if(chicken.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("meatPref").setValue("chicken")
        }
    }
    
    @IBOutlet weak var backButton: UIButton!
    @IBAction func Back(_ sender: UIButton) {
        backButton.setTitleColor(UIColor .green, for: .normal)
    }
    
}


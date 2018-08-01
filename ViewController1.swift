//
//  SecondViewController.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-25.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase



class SecondViewController: UIViewController {
    
    

    var ref: DatabaseReference?
    let userID = (Auth.auth().currentUser?.uid)!

    @IBAction func heightSlider(_ sender: UISlider) {
        userHeightCM.text = String(Int(sender.value))
        userHeight.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    }
    
    @IBOutlet weak var oldness: UITextField!        //text field
    
    @IBAction func userOldness(_ sender: UITextField) {
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        if !loadFromMainIsTrue {
            self.performSegue(withIdentifier: "backToRegs", sender: nil)
        }
        else {
            self.performSegue(withIdentifier: "backToMain", sender: nil)
        }
    }
    
    
    
    @IBAction func older(_ sender: UIButton) {      //increase age button
        let ageInt = Int(oldness.text!)
        if(ageInt != 101){
            oldness.text = String(ageInt! + 1)
        }
        
    }
    
    @IBAction func younger(_ sender: UIButton) {    //decrease age button
        let ageInt = Int(oldness.text!)
        if(ageInt != 0){
            oldness.text = String(ageInt! - 1)
        }
    }
    
    // if weight arrows are tapped, the weight number changes.
     @IBOutlet weak var userWeight: UITextField!
    var weightInt: Int!
    @IBAction func thinerBtn(_ sender: UIButton) {
        weightInt = Int(userWeight.text!)
        if(weightInt != 0) {
            userWeight.text = String (weightInt! - 1)
        }
    }
    @IBAction func heavierBtn(_ sender: UIButton) {
        weightInt = Int(userWeight.text!)
        userWeight.text = String (weightInt! + 1)
        
    }
    
    
    @IBOutlet weak var nextButton: UIButton!        //next view controller button
    @IBAction func nextButton(_ sender: UIButton) {
        nextButton.setTitleColor(UIColor .green, for: .normal)
        if(avatarImage.image == #imageLiteral(resourceName: "Asset 2@300x")){
            self.ref?.child("nutrientHistory").child(userID).child("gender").setValue("female")

        }
        else if(avatarImage.image == #imageLiteral(resourceName: "Asset 1@300x")){
            self.ref?.child("nutrientHistory").child(userID).child("gender").setValue("male")

        };
        self.ref?.child("nutrientHistory").child(userID).child("age").setValue(oldness.text!)

    }
    
    @IBOutlet weak var female: UIButton!            //female button
    @IBOutlet weak var avatarImage: UIImageView!
    @IBAction func girl(_ sender: UIButton) {
        // change the button color to yellow if tapped
        female.setTitleColor(yellow, for: .normal)
        male.setTitleColor(grey, for: .normal)
                // change the avatar image to girl
        avatarImage.image = #imageLiteral(resourceName: "Asset 2@300x")
    }
    
    
    @IBOutlet weak var male: UIButton!              //male button
    @IBOutlet weak var boyImage: UIImageView!
    
    @IBAction func boy(_ sender: UIButton) {
        // change button colors
        male.setTitleColor(yellow, for: .normal)
        female.setTitleColor(grey, for: .normal)

        // change the avatar image to boy
        avatarImage.image = #imageLiteral(resourceName: "Asset 1@300x")
    }
    
    
    @IBOutlet weak var userHeight: UISlider!

    @IBOutlet weak var userHeightCM: UITextField!
    var yellow: UIColor!
    var grey: UIColor!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

        // define uicolors
        yellow = UIColor(hue: 0.1139, saturation: 0.69, brightness: 0.96, alpha: 1.0)
        grey = UIColor(hue: 0, saturation: 0, brightness: 0.82, alpha: 1.0)
        
        female.setTitleColor(yellow, for: .normal)
        male.setTitleColor(grey, for: .normal)
    }
    
    
}

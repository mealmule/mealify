//
//  SecondViewController.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-25.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit

class userInfo{                 //user class
    var gender = ""
    var age = 0
    var height = 0
    var weight = 0
    var specialDiet = "none"
    var weightBalance = "remain weight"

}

class SecondViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        userHeight.transform = CGAffineTransform(rotationAngle: CGFloat(-Double.pi/2))
    }
    
    @IBOutlet weak var oldness: UITextField!        //text field
    
    @IBAction func userOldness(_ sender: UITextField) {
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
    
    @IBOutlet weak var nextButton: UIButton!        //next view controller button
    @IBAction func nextButton(_ sender: UIButton) {
        nextButton.setTitleColor(UIColor .green, for: .normal)
    }
    
    @IBOutlet weak var female: UIButton!            //female button
    @IBOutlet weak var girlImage: UIImageView!
    
    @IBAction func girl(_ sender: UIButton) {
        girlImage.isHidden = false
        female.setTitleColor(UIColor .green, for: .normal)
        if(male.isHidden == false){
            male.setTitleColor(UIColor .blue, for: .normal)
            boyImage.isHidden = true
        }
    }
    
    
    @IBOutlet weak var male: UIButton!              //male button
    @IBOutlet weak var boyImage: UIImageView!
    
    @IBAction func boy(_ sender: UIButton) {
        boyImage.isHidden = false
        male.setTitleColor(UIColor .green, for: .normal)
        if(female.isHidden == false){
            female.setTitleColor(UIColor .blue, for: .normal)
            girlImage.isHidden = true
        }
    }
    
    
    
    
    @IBOutlet weak var userWeight: UITextField!
    
    @IBAction func weightSlider(_ sender: UISlider) {
        userWeight.text = String(Int(sender.value))
    }
    
    @IBOutlet weak var userHeight: UISlider!

    @IBOutlet weak var userHeightCM: UITextField!
    @IBAction func heightSlider(_ sender: UISlider) {
        userHeightCM.text = String(Int(sender.value))
    }
    
    
}

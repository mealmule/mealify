//
//  ViewController5.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-29.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController5: UIViewController {
    var ref: DatabaseReference?
    let userID = (Auth.auth().currentUser?.uid)!

    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

    }
    @IBOutlet weak var ricee: UIButton!
    @IBAction func rice(_ sender: UIButton) {
        ricee.setTitleColor(UIColor .green, for: .normal)
        
        if((breadd.titleColor(for: .normal) == .green) || (peass.titleColor(for: .normal) == .green) || (potatoess.titleColor(for: .normal) == .green)){
            breadd.setTitleColor(UIColor .blue, for: .normal)
            peass.setTitleColor(UIColor .blue, for: .normal)
            potatoess.setTitleColor(UIColor .blue, for: .normal)
        }
        
    }
    
    @IBOutlet weak var breadd: UIButton!
    @IBAction func bread(_ sender: UIButton) {
        breadd.setTitleColor(UIColor .green, for: .normal)
        
        if((ricee.titleColor(for: .normal) == .green) || (peass.titleColor(for: .normal) == .green) || (potatoess.titleColor(for: .normal) == .green)){
            ricee.setTitleColor(UIColor .blue, for: .normal)
            peass.setTitleColor(UIColor .blue, for: .normal)
            potatoess.setTitleColor(UIColor .blue, for: .normal)
        }
        
        
    }
    @IBOutlet weak var peass: UIButton!
    @IBAction func peas(_ sender: UIButton) {
        peass.setTitleColor(UIColor .green, for: .normal)
        
        if((breadd.titleColor(for: .normal) == .green) || (ricee.titleColor(for: .normal) == .green) || (potatoess.titleColor(for: .normal) == .green)){
            breadd.setTitleColor(UIColor .blue, for: .normal)
            ricee.setTitleColor(UIColor .blue, for: .normal)
            potatoess.setTitleColor(UIColor .blue, for: .normal)
        }
        
    }
    
    @IBOutlet weak var potatoess: UIButton!
    @IBAction func potatoes(_ sender: UIButton) {
        potatoess.setTitleColor(UIColor .green, for: .normal)
        
        if((breadd.titleColor(for: .normal) == .green) || (peass.titleColor(for: .normal) == .green) || (ricee.titleColor(for: .normal) == .green)){
            breadd.setTitleColor(UIColor .blue, for: .normal)
            peass.setTitleColor(UIColor .blue, for: .normal)
            ricee.setTitleColor(UIColor .blue, for: .normal)
        }
        
    
    }
    @IBAction func next(_ sender: Any) {
        if(ricee.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("carbPref").setValue("rice")
        }else if(breadd.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("carbPref").setValue("bread")
        }else if(peass.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("carbPref").setValue("peas")
        }else if(potatoess.titleColor(for: .normal) == .green){
            self.ref?.child("nutrientHistory").child(userID).child("carbPref").setValue("potatoes")
        }
    }
}

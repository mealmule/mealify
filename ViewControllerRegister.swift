//
//  ViewControllerRegister.swift
//  mealify
//
//  Created by John Zheng on 2018-07-02.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewControllerRegister: UIViewController {

    //@IBOutlet weak var registerstatus: UILabel!
    var ref: DatabaseReference?
    @IBOutlet weak var username: UITextField!
    
    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    //@IBOutlet weak var confirmpassword: UITextField!
    @IBOutlet weak var confirmpassword: UITextField!
    
    @IBOutlet weak var registerstatus: UILabel!
    //@IBOutlet weak var username: UITextField!
    var today = Date()
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    var todayFormatted = ""
    
    var databaseRef : DatabaseReference?
    
    
    @IBOutlet weak var registerButtonNode: UIButton!
    @IBAction func registerbutton(_ sender: Any) {
        if let email = emailtext.text, let pass = passwordtext.text{
            if passwordtext.text! == confirmpassword.text! {
            Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
                if let u = authResult {
                    print("Registration complete!")
                    
                    self.todayFormatted = self.dateFormatter.string(from: self.today)
                    
                    let userID = (Auth.auth().currentUser?.uid)!
                    
                    
                    var dateInitialize = ""
                    for i in 0...7 {
                        
                        dateInitialize = self.dateFormatter.string(from: self.cal.date(byAdding: .day, value: -i, to: self.today)!)
                        
                        self.databaseRef?.child("nutrientHistory").child(userID).child(dateInitialize).setValue(["email": self.emailtext.text, "pass": self.passwordtext.text, "kCals": 0, "proteins": 0, "fats": 0, "carbohydrates": 0, "iron": 0, "magnesium": 0, "vitaminD": 0, "folate": 0, "moisture": 0])
                        
                    }
                    self.databaseRef?.child("nutrientHistory").child(userID).child("username").setValue(self.username.text!)
                    self.performSegue(withIdentifier: "gotoqa", sender: self)
                } else {
                    print(error)
                    self.registerstatus.text = "Please enter a valid email and a password at least 6 characters long!"
                    self.registerstatus.textColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1.0)
                }
            } //
            }else{
                registerstatus.text! = "Please enter the same password for both fields!"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: today)
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "gotoqa" {
            loadFromMainIsTrue = false
        }

        
    }
 

}

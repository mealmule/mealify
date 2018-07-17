//
//  ViewControllerRegister.swift
//  mealify
//
//  Created by John Zheng on 2018-07-02.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase

class ViewControllerRegister: UIViewController {

    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    var today = Date()
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    var todayFormatted = ""
    
    var databaseRef : DatabaseReference?
    
    
    @IBAction func registerbutton(_ sender: Any) {
        if let email = emailtext.text, let pass = passwordtext.text{
            Auth.auth().createUser(withEmail: email, password: pass) { (authResult, error) in
                if let u = authResult {
                    print("Registration complete!")
                    
                    self.todayFormatted = self.dateFormatter.string(from: self.today)
                    
                    let userID = (Auth.auth().currentUser?.uid)!
                    
                    
                    var dateInitialize = ""
                    for i in 0...7 {
                        
                        dateInitialize = self.dateFormatter.string(from: self.cal.date(byAdding: .day, value: -i, to: self.today)!)
                        
                        self.databaseRef?.child("nutrientHistory").child(userID).child(dateInitialize).setValue(["email": self.emailtext.text, "pass": self.passwordtext.text, "kCals": 0, "proteins": 0, "fats": 0, "carbohydrates": 0, "iron": 0, "magnesium": 0, "vitamin D": 0, "folate": 0, "Water": 0])
                        
                    }
                    self.performSegue(withIdentifier: "gotoqa", sender: self)
                } else {
                    print(error)
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        databaseRef = Database.database().reference()
        
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: today)

        // Do any additional setup after loading the view.
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

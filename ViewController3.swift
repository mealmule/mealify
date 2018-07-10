//
//  ViewController3.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-27.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit
import Firebase

class ViewController3: UIViewController {

    @IBOutlet weak var emailtext: UITextField!
    
    @IBOutlet weak var passwordtext: UITextField!
    
    var today = Date()
    let dateFormatter = DateFormatter()
    let cal = Calendar.current
    var todayFormatted = ""
    var ref : DatabaseReference?
    
    
    @IBAction func loginbutton(_ sender: UIButton) {
        if let email = emailtext.text, let pass = passwordtext.text{
            Auth.auth().signIn(withEmail: email, password: pass){
                (user,error) in
                if let u = user{
                    print("Log in successful")
                    let userID = Auth.auth().currentUser?.uid
                    
                    self.ref?.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                        if snapshot.hasChild(self.todayFormatted) {
                            
                        } else {
                            self.ref?.child("nutrientHistory").child(userID!).child(self.todayFormatted).setValue(["kCals": 0, "proteins": 0, "fats": 0, "carbohydrates": 0])
                            
                        }
                    })
                    self.performSegue(withIdentifier: "loggedin", sender: self)
                } else {
                    print(error)
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        ref = Database.database().reference()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        todayFormatted = dateFormatter.string(from: today)
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

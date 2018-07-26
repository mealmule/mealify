//
//  FriendDetailViewController.swift
//  mealify
//
//  Created by Kaybo on 2018-07-17.
//  Copyright © 2018 Meal Mules. All rights reserved.
//
// ***************************************************
// ******************  Overview **********************
// ***************************************************
//This viewcontroller allows users to see their friends in detail


import UIKit
import FirebaseAuth
import FirebaseDatabase

class FriendDetailViewController: UIViewController {
    var status = 0
    var someIndex = 0;
    var somelist : [String] = []
    var friendlist : [String] = []
    var friendkey : [String] = []
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    
    @IBOutlet weak var friendname: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        friendname.text = somelist[someIndex]
        self.navigationController?.isNavigationBarHidden = false
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
            self.navigationController?.isNavigationBarHidden = true
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//this function removes users friend from firebase
    @IBAction func removefriendbutton(_ sender: Any) {
        if status == 0{
            ref = Database.database().reference()
            ref.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                if let friendList = snapDictionary["friendlist"]{
                    print(friendList)
                    for i in friendList as! NSDictionary{
                        self.friendlist.append(friendList[i.key]!! as! String)
                        self.friendkey.append(i.key as! String)
                        
                    }
                    for j in 0..<self.friendlist.count{
                        if self.friendname.text! == self.friendlist[j]{
                            self.ref?.child("nutrientHistory").child(self.userID!).child("friendlist").child(self.friendkey[j]).setValue(nil)
                            self.status = 1
                        }
                    }
                
                    
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
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

//
//  FriendsViewController.swift
//  mealify
//
//  Created by Kaybo on 2018-07-14.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

// ***************************************************
// ******************  Overview **********************
// ***************************************************
//This viewcontroller allows the user to add friends

// ***************************************************
// ******************  BUGS  *************************
// ***************************************************
//User is able to add himself/herself to database. There is no validation for this edge case

import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendsViewController: UIViewController {
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!

    @IBOutlet weak var friendtext: UITextField!
    @IBOutlet weak var feedbackmessage: UILabel!
    @IBOutlet weak var userFriendCode: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userFriendCode.text = userID
        self.navigationController?.isNavigationBarHidden = false

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
    
    
    //Friend add function
    //Searches through the database and check if user exists
    //if user exists, goes into that user tree and create a new child node which puts ID of users who wants to add the searched user
    //edge cases are implemented
    @IBAction func searchfriend(_ sender: UIButton) {
        ref = Database.database().reference()
        if friendtext.text != "" {
        var someArr : [String] = []
            let friendcode = friendtext.text
            if userID! != friendtext.text!{
                someArr = []
            ref.child("nutrientHistory").child(friendtext.text!).observeSingleEvent(of: .value, with: { (snapshot) in
                // Get user value
                print(snapshot.value)
                if (snapshot.exists()){
                    print("snapshot works!")
                    self.feedbackmessage.text = "Invitation sent! Enter another friend code if you have more friends."
                    //validate to see if there are duplicates
                    let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                    print(snapDictionary["friendrequest"])
                    if let friendRequestList = snapDictionary["friendrequest"]{
                        var flag = 0;
                        print(friendRequestList)
                        for i in friendRequestList as! NSDictionary{
                            print(friendRequestList[i.key]!!)
                            someArr.append(friendRequestList[i.key]!! as! String)
                        }
                        for j in someArr{
                            if(self.userID! == j){
                                flag = 1;
                                print("duplicates in friends list")
                            }
                        }
                        if(flag == 0){self.ref?.child("nutrientHistory").child(friendcode!).child("friendrequest").childByAutoId().setValue(String(self.userID!))
                            
                        }else{
                            self.feedbackmessage.text = "You have already sent this person an invite!"
                        }
                    }else{
                    self.ref?.child("nutrientHistory").child(friendcode!).child("friendrequest").childByAutoId().setValue(String(self.userID!))
                    }
                    
                }else{
                    print("snapshot does not exists!")
                    self.feedbackmessage.text = "Friend code does not exist! Please try again"
                }
                
                // ...
            }) { (error) in
                print(error.localizedDescription)
            }//////////////
            }else{
                feedbackmessage.text = "You cannot add yourself as a friend!"
            }
            friendtext.text = ""
        }//not this one
    }
    
    
    


}

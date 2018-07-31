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
    var somelist2 : [String] = []
    var friendlist : [String] = []
    var friendkey : [String] = []
    var friendlist2 : [String] = []
    var friendkey2 : [String] = []
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var tempfriendname = "test"
    
    @IBOutlet weak var friendname: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tempfriendname = somelist[someIndex]
        friendname.text = somelist2[someIndex]
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
                        if self.tempfriendname == self.friendlist[j]{
                            self.ref.child("nutrientHistory").child(self.friendlist[j]).observeSingleEvent(of: .value, with: { (snapshot) in
                                print("THIS IS FRIENDLIST OF THE OTHER USER \(self.friendlist[j])")
                            })
                            {(error) in
                                print(error.localizedDescription)
                            }
                            self.ref?.child("nutrientHistory").child(self.userID!).child("friendlist").child(self.friendkey[j]).setValue(nil)
                            self.status = 1
                            self.ref.child("nutrientHistory").child(self.tempfriendname).observeSingleEvent(of: .value, with: { (snapshot) in
                                let snapDictionary2 = snapshot.value as? [String : AnyObject] ?? [:]
                                if let friendList2 = snapDictionary2["friendlist"]{
                                    for k in friendList2 as! NSDictionary{
                                        self.friendlist2.append(friendList2[k.key] as! String)
                                        self.friendkey2.append(k.key as! String)
                                    }
                                    for m in 0..<self.friendlist2.count{
                                        if self.friendlist2[m] == self.userID!{
                                            self.ref?.child("nutrientHistory").child(self.tempfriendname).child("friendlist").child(self.friendkey2[m]).setValue(nil)
                                        }
                                    }
                                }
                            })
                            {(error) in
                                print(error.localizedDescription)
                            }
                        }
                    }
                
                    
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    

}

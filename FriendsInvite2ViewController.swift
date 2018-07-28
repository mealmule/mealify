//
//  FriendsInvite2ViewController.swift
//  mealify
//
//  Created by Kaybo on 2018-07-15.
//  Copyright © 2018 Meal Mules. All rights reserved.
//
// ***************************************************
// ******************  Overview **********************
// ***************************************************
import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendsInvite2ViewController: UIViewController {
    
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var status = 0
    var someIndex = 0
    var somelist : [String] = []
    var somelist2 : [String] = []
    var friendlist : [String] = []
    var keyArray : [String] = []
    var valueArray : [String] = []
    var acceptname  = "placeholder"
    
    @IBOutlet weak var friend: UILabel!
    
    @IBOutlet weak var test: UILabel!
    @IBOutlet weak var feedback: UILabel!
    
//function that allows user to accept the friend invitation and creates a childnode in friendlist on firebase database
//if user does not have friendlist node, it will be automatically created for him/her upon adding friends
    @IBAction func accept(_ sender: UIButton) {
        print("This is the status of the accept button \(status)")
        if status == 0 {
            ref = Database.database().reference()
            ref.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                if let friendRequestList = snapDictionary["friendrequest"]{
                    print(friendRequestList)
                    for i in friendRequestList as! NSDictionary{
                        self.valueArray.append(friendRequestList[i.key]!! as! String)
                        self.keyArray.append(i.key as! String)
                        
                    }
                    print("this is the key array! \(self.keyArray)")
                    print("this is the value array! \(self.valueArray)" )
                    for j in 0..<self.valueArray.count{
                        print("this is the j value \(j)")
                        if self.valueArray[j] == self.acceptname{
                            self.ref?.child("nutrientHistory").child(self.userID!).child("friendrequest").child(self.keyArray[j]).setValue(nil)
                            self.ref?.child("nutrientHistory").child(self.userID!).child("friendlist").childByAutoId().setValue(self.valueArray[j])
                            
                             self.status = 1 //now user cannot press accept or reject button, must go back to the tableview
                        }
                    }
                    
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
    }

//function that rejects the friend invitation
//the friendrequest in the database will remove this friend request
    @IBAction func reject(_ sender: UIButton) {
        print("This is the status of the accept button \(status)")
        if status == 0{
            ref = Database.database().reference()
            ref.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
                let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
                if let friendRequestList = snapDictionary["friendrequest"]{
                    print(friendRequestList)
                    for i in friendRequestList as! NSDictionary{
                        self.valueArray.append(friendRequestList[i.key]!! as! String)
                        self.keyArray.append(i.key as! String)
                    }
                    print("this is the key array! \(self.keyArray)")
                    print("this is the value array! \(self.valueArray)" )
                    for j in 0..<self.valueArray.count{
                        print("this is the j value \(j)")
                        if self.valueArray[j] == self.acceptname{
                            self.ref?.child("nutrientHistory").child(self.userID!).child("friendrequest").child(self.keyArray[j]).setValue(nil)
                            self.status = 1 //now user cannot press accept or reject button, must go back to the tableview
                        }
                    }
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }

//shows the friend name
    override func viewDidLoad() {
        super.viewDidLoad()
        print(somelist)
        friend.text = somelist2[someIndex]
        acceptname = somelist[someIndex]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}

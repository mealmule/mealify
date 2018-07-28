//
//  FriendListViewController.swift
//  mealify
//
//  Created by Kaybo on 2018-07-17.
//  Copyright © 2018 Meal Mules. All rights reserved.
//
// ***************************************************
// ******************  Overview **********************
// ***************************************************
//This shows a tableview of user's friendlist

import UIKit
import FirebaseAuth
import FirebaseDatabase

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var friendRequestArr : [String] = []
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var myIndex = 0
    var friendRequestArrUsername : [String] = []
    var databaseUniqueID : [String] = []
    
    
    // get user healthScore
    var healthScore = 8.9
    // get friend's healthScore
    var FriendHealthScore = 7.2
    @IBOutlet weak var mealKingImg: UIImageView!
    @IBOutlet weak var healthScoreLabel: UILabel!
    
    @IBOutlet weak var friendListTableView: UITableView!
    
//loads friendlist into the viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()
        

        ref = Database.database().reference()
        print("Current user is \(userID!)")
        ref.child("nutrientHistory").child(userID!).observe(.value, with: { (snapshot) in
            self.friendRequestArrUsername = []
            self.databaseUniqueID = []
            self.friendRequestArr = []
            let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            if let friendRequestList = snapDictionary["friendlist"]{
                for i in friendRequestList as! NSDictionary{
                    self.friendRequestArr.append(friendRequestList[i.key]!! as! String)
                }
                /////////////////////////
                self.ref.child("nutrientHistory").observeSingleEvent(of: .value, with: { (snapshot) in
                    self.databaseUniqueID = []
                    let snapDictionary2 = snapshot.value as? [String : AnyObject] ?? [:]
                    for i in snapDictionary2 as! NSDictionary{
                        self.databaseUniqueID.append(i.key as! String)
                    }
                    //print("THIS IS TESTING \(self.databaseUniqueID)")
                    for i in 0 ..< (self.friendRequestArr.count){
                        for j in 0 ..< (self.databaseUniqueID.count){
                            if self.friendRequestArr[i] == self.databaseUniqueID[j]
                            {
                                self.friendRequestArrUsername.append(snapDictionary2[self.databaseUniqueID[j]]!["username"]!! as! String)
                            }
                        }
                    }
                    self.friendListTableView.reloadData()
                    
                }) { (error) in
                    print(error.localizedDescription)
                }
                /////////////////////////
                
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
        
        
        
        
        
        
        
        //////////////////////////////////////////////////////
        if (healthScore > FriendHealthScore) {
            mealKingImg.image = #imageLiteral(resourceName: "mealKing")
        } else {
            mealKingImg.image = #imageLiteral(resourceName: "mule")
        }
        healthScoreLabel.text = String(healthScore)
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (friendRequestArrUsername.count)
    }

//Puts all user into the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell2")
        cell.textLabel?.text = friendRequestArrUsername[indexPath.row]
        return(cell)
    }

//Performs segue and sends user into friend detail view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        myIndex = indexPath.row
        performSegue(withIdentifier: "viewfrienddetail", sender: self)
    }
    
//Delegation and sends data into FriendDetailViewcontroller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "viewfrienddetail"{
            let nextviewcontroller = segue.destination as! FriendDetailViewController
            nextviewcontroller.someIndex = myIndex
            nextviewcontroller.somelist = friendRequestArr
        }
    }
}

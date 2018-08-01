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
import FirebaseStorage
import SDWebImage

class FriendListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    var friendRequestArr : [String] = []
    var userID = Auth.auth().currentUser?.uid
    var ref: DatabaseReference!
    var myIndex = 0
    var friendRequestArrUsername : [String] = []
    var friendScore : [Double] = []
    var databaseUniqueID : [String] = []
    var healthScoreInt : Double = 0.0
    var concatArr : [String] = []
    
    
    
    
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
            if let userHealthScore = snapDictionary["userScore"]{
                //self.healthScoreLabel.text =  userHealthScore as! String
                self.healthScoreInt = userHealthScore as! Double
                self.healthScoreLabel.text = String(self.healthScoreInt)
                
            }
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
                                self.friendScore.append(snapDictionary2[self.databaseUniqueID[j]]!["userScore"]!! as! Double)
                            }
                        }
                    }
                    
                    //THIS IS A SORTING ALGORITHM!!!!!!
                    //Sorts the user from highest to lowest score
//                    var minimum : Int
//                    var temp : Double
//                    var temp1 : String
//                    var temp2 : String
//                    print("THIS IS SORTING ALGORITH BEFOREEEE \(self.friendScore)")
//                    for i in 0..<self.friendScore.count{
//                        minimum = i
//                        for j in 0..<i{
//                            if self.friendScore[i] < self.friendScore[j]{
//                                minimum = j
//                            }
//                            temp = self.friendScore[i]
//                            self.friendScore[i] = self.friendScore[j]
//                            self.friendScore[j] = temp
//                        }
//                    }
//                    print("THIS IS THE SORTING ALGORITHM ARRAY \(self.friendScore)")
                    ////////////////////////////////////
                    
                    
                    
                    
                    
                    
                    //Concatenating both userscores and username into tableview
                    for i in 0..<self.friendScore.count{
//self.concatArr.append(String(self.friendScore[i]) + "                 " + self.friendRequestArrUsername[i] )
                        self.concatArr.append(self.friendRequestArrUsername[i] + "          "  + String(self.friendScore[i]))
                    }
                    print("THIS IS THE SUMMMMMMMMMMMMM \(self.concatArr)")
                    
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
        //healthScoreLabel.text = String(healthScore)
        
        // initializing storage reference in Firebase
        
        
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
        
        return (concatArr.count)
    }

//Puts all user into the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = UITableViewCell(style: .default, reuseIdentifier: "cell2")
            cell.textLabel?.text = self.concatArr[indexPath.row]
//            let rowUserID = self.friendRequestArr[indexPath.row]
//            let profilePictureRef = Storage.storage().reference().child("images/profile/\(rowUserID).png")
//            profilePictureRef.downloadURL { (url, error) in
//                cell.imageView?.layer.borderWidth = 1
//                cell.imageView?.layer.masksToBounds = false
////                cell.imageView?.layer.cornerRadius = 20
////                cell.imageView?.clipsToBounds = true
//                cell.imageView?.sd_setImage(with: url)
//            }
        
    
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
            nextviewcontroller.somelist2 = friendRequestArrUsername
        }
    }
}

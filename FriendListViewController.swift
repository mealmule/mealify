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

    @IBOutlet weak var friendListTableView: UITableView!
    
//loads friendlist into the viewcontroller
    override func viewDidLoad() {
        super.viewDidLoad()

        ref = Database.database().reference()
        print("Current user is \(userID!)")
        ref.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            if let friendRequestList = snapDictionary["friendlist"]{
                for i in friendRequestList as! NSDictionary{
                    self.friendRequestArr.append(friendRequestList[i.key]!! as! String)
                }
                self.friendListTableView.reloadData()
                print("Friend Request Arr \(self.friendRequestArr)")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (friendRequestArr.count)
    }

//Puts all user into the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell2")
        cell.textLabel?.text = friendRequestArr[indexPath.row]
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

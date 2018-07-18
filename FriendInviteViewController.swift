//
//  FriendInviteViewController.swift
//  mealify
//
//  Created by Kaybo(Feng) on 2018-07-15.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

// ***************************************************
// ******************  Overview **********************
// ***************************************************
//This viewcontroller allows the user to see a list of other users who added them as a friend.
//The list of friends invite is gathered from the Firebase Database.





import UIKit
import FirebaseDatabase
import FirebaseAuth

class FriendInviteViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var tableviewstuff: UITableView!
    
    var ref: DatabaseReference!
    var userID = Auth.auth().currentUser?.uid
    var myIndex = 0
    var friendRequestArr : [String] = []
    
    
//Gathers the list of friend invitation from firebase and sends it to the user tableview
    func getinfo() -> Int{
        ref = Database.database().reference()
        print("Current user is \(userID!)")
        ref.child("nutrientHistory").child(userID!).observeSingleEvent(of: .value, with: { (snapshot) in
            let snapDictionary = snapshot.value as? [String : AnyObject] ?? [:]
            if let friendRequestList = snapDictionary["friendrequest"]{
                for i in friendRequestList as! NSDictionary{
                    self.friendRequestArr.append(friendRequestList[i.key]!! as! String)
                }
                self.tableviewstuff.reloadData()
                print("Friend Request Arr \(self.friendRequestArr)")
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        return 1
    }
    
//upon opening the view, this functions allows the function getinfo() to gather information from the database
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        var test = getinfo()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//gathers how many columns there are in the tableview
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return (friendRequestArr.count)
    }
    
//puts the information into the cell of the tableview
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cell")
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = friendRequestArr[indexPath.row]
        return(cell)
    }

//Upon tapping on the cells in the tableview, this function allows the cells in the tableview to redirect user to another view
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       myIndex = indexPath.row
        
        performSegue(withIdentifier: "viewrequest", sender: self)
    }

//Delegations sends data to FriendsInvite2ViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "viewrequest"{
            let nextviewcontroller = segue.destination as! FriendsInvite2ViewController
            nextviewcontroller.someIndex = myIndex
            nextviewcontroller.somelist = friendRequestArr
            
        }

    }


}

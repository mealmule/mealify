//
//  MealTableViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added table that contains all foods (placeholder foods for now)
//                Added Search bar to search for any foods
//                Added segue to page where it displays the meal
//                Added database for meals
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import FirebaseDatabase

var nutrients = [Nutrients]()

class MealTableViewController: UITableViewController {
    
    var ref: DatabaseReference!
    var ref2: DatabaseReference!
    var ref3: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    //Properties and variables
    var meals = [Meal]()
    var filteredMeals = [Meal]()
    var nutrientMealInfo = [NutrientMealInfo]()
    let searchController = UISearchController(searchResultsController: nil)
    
    var offset = 0
    var reachedEndOfItems = false
    var mealsToLoad = 0
    var loadingMeals = 0
    //This adds new meals into the array.
    //TODO:
    //For now, they are sample meals, but can import meals from database later
    private func loadSampleMeals() {
        
    }
    
    //Returns true or false, true being search bar is empty, false being it is not empty
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    //This function takes in whatever you type in from the search bar and compare it to all the meals in the list
    //This will then give the filtered version of the table
    //Reload data afterwards so that new filtered items appear whenever you type into the search bar
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredMeals = meals.filter({( meal : Meal) -> Bool in
            return meal.name.lowercased().contains(searchText.lowercased())
        })
        
        tableView.reloadData()
    }
    
    //Determines if you are filtering by checking the search bar and seeing if its empty
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    //Back button functionality.
    //Replace previous back button so that this one can have some functionality to it
    //For example, I wanted to hide the navigation bar when the back button is pressed
    @objc func back(sender: UIBarButtonItem) {
        
        //Functionality
        //Hide the navigation bar again
        self.navigationController?.isNavigationBarHidden = true
        
        //This leads you back to the previous view controller.
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database(url: "https://mealify-7babd-2e44f.firebaseio.com/").reference()
        ref2 = Database.database(url: "https://mealify-7babd-78a83.firebaseio.com/").reference()
        ref3 = Database.database(url: "https://mealify-7babd-a6cd5.firebaseio.com/").reference()
        
        
        //Hides the back button on navigation bar and implement your own.
        //This gives the back button more options, for example, you can do other things
        //when the back button is pressed.
        self.navigationItem.hidesBackButton = true
        let newButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(MealTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newButton
        
        //Whenever this view is loaded, don't hide the navigation bar.
        self.navigationController?.isNavigationBarHidden = false
        
        //This loads all the sample meals and store them in the array
        //loadSampleMeals()
        
        //Setup the Search Controller
        //Adds search bar functionality.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        mealsToLoad = 10
        
        databaseHandle = ref?.observe(.childAdded, with: { (snapshot) in
            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                let userInterest = allNames["FoodDescription"] as! String
                let foodID = allNames["FoodID"] as! Int
                print(userInterest);
                self.meals += [Meal(name: userInterest, foodID: foodID)]
                self.tableView.reloadData()

            }
            
        })
        
        databaseHandle = ref2?.observe(.childAdded, with: { (snapshot) in
            
            if let allNames = snapshot.value as? [String:AnyObject] {
                
                let nutrientID = allNames["NutrientID"] as! Int
                let foodID = allNames["FoodID"] as! Int
                let nutrientSourceID = allNames["NutrientSourceID"] as! Int
                let nutrientValue = allNames["NutrientValue"] as! NSNumber
                
                
                self.nutrientMealInfo += [NutrientMealInfo(foodID: foodID, nutrientID: nutrientID, nutrientSourceID: nutrientSourceID, nutrientValue: nutrientValue)]
                self.tableView.reloadData()
            }
            
        })
        
        if nutrients.count < 8{
            databaseHandle = ref3?.observe(.childAdded, with: { (snapshot) in
                
                if let allNames = snapshot.value as? [String:AnyObject] {
                    
                    let nutrientCode = allNames["NutrientCode"] as! Int
                    let nutrientDecimals = allNames["NutrientDecimals"] as! Int
                    let nutrientName = allNames["NutrientName"] as! String
                    let nutrientNameF = allNames["NutrientNameF"] as! String
                    let nutrientSymbol = allNames["NutrientSymbol"] as! String
                    let nutrientUnit = allNames["NutrientUnit"] as! String
                    let tagName = allNames["Tagname"] as! String
                    
                    nutrients += [Nutrients(nutrientCode: nutrientCode, nutrientDecimals: nutrientDecimals, nutrientName: nutrientName, nutrientNameF: nutrientNameF, nutrientSymbol: nutrientSymbol, nutrientUnit: nutrientUnit, tagName: tagName)]
                    self.tableView.reloadData()
                }
                
            })
        }
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
 
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return the amount of meals based on what you type on the search bar.
        if isFiltering() {
           return filteredMeals.count
        }
        
        if(mealsToLoad != meals.count){
            mealsToLoad += 10
        }
        return meals.count
    }
    

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "MealTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MealTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MealTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        var meal : Meal
        if isFiltering() {
            meal = filteredMeals[indexPath.row]
        } else {
            meal = meals[indexPath.row]
        }
        
        cell.foodName.text = meal.name
        cell.foodName.adjustsFontSizeToFitWidth = true
        cell.foodName.minimumScaleFactor = 0.7
        
        return cell
    }
    
    
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        //connect to table view
        
        guard let selectedMealCell = sender as? MealTableViewCell else {
            fatalError("Unexpected sender: (String(describing: sender))")
        }
        
        //Getting the selected meal from the cell you clicked.
        //If user clicked on one cell, the returned value will be the cell you clicked.
        guard let indexPath = tableView.indexPath(for: selectedMealCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        //Check to see if filtered is on or off, return object dependent on the filter (search bar)
        var selectedMeal = Meal()
        if isFiltering(){
            selectedMeal = filteredMeals[indexPath.row]
        }
        else{
            selectedMeal = meals[indexPath.row]
        }
        
        for i in nutrientMealInfo{
            
            if i.foodID == selectedMeal.foodID{
                selectedMeal.nutrients += [i]
            }
            
        }
        
        //let dest = segue.destination as! ViewController
        
        
        //If the identifier goes back to view controller, then update the foods within that view controller
        if segue.identifier == "newFoods"{
            
            let dest = segue.destination as! MealViewController
            
            //If the breakfast section was pressed before, then update the breakfast foods
            if self.title == "Breakfasts"{
                dest.mealType = "Breakfasts"
            }
                //If the breakfast section was pressed before, then update the breakfast foods
            else if self.title == "Lunches"{
                dest.mealType = "Lunches"
            }
                //If the breakfast section was pressed before, then update the breakfast foods
            else if self.title == "Dinners"{
                
                dest.mealType = "Dinners"
            }
            
            dest.meal = selectedMeal
            
        }
        
        
        
        
        
        
    }
    
    
}

//Extension for search bar
extension MealTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

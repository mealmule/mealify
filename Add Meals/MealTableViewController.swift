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
//                Added more filter items for more filtering
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit


class MealTableViewController: UITableViewController {
    
    //Properties and variables
    
    var loadFromMain: Bool = true
    
    //Get number of meals user currently have for the day
    var numberOfDayMeals = 0
    
    //Create a meals array to contain all meals to display
    var meals = [Meal]()
    
    //Create another meals array to contain all filtered meals to display
    //All Filtered meals replace meals array when searching is being done.
    var allFilteredMeals = [Meal]()
    
    //filteredMeals is a subset of allFilteredMeals, this is for loading more filtered meals while scrolling
    //Loads toLoad at a time until all filtered meals is loaded
    var filteredMeals = [Meal]()
    
    //toLoad is how many meals to load at a time every time you reach the bottom of the table
    //This would reduce more lag while searching for meals (not loading 5000 meals at once)
    var toLoad = 35
    
    //How many unfiltered meals are loaded to display.
    var loaded = 0
    
    //How many filtered meals are loaded to display.
    var filteredLoaded = 0
    
    //searchController for implementing the search bar to search for meals.
    let searchController = UISearchController(searchResultsController: nil)
    
    
    //Determines if you are filtering by checking the search bar and seeing if its empty
    func isFiltering() -> Bool {
        return searchController.isActive && !searchBarIsEmpty()
    }
    
    //Returns true or false, true being search bar is empty, false being it is not empty
    func searchBarIsEmpty() -> Bool {
        // Returns true if the text is empty or nil
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
    
    //TODO:
    //*
    //*
    //*
    //This adds new meals into the array.
    //Adds toLoad amount of new meals to the array every time this function is called
    //This is for scrolling through unfiltered meals, to load bits at a time
    private func loadMoreMeals() {
        
        //If the user is not filtering, then load more meals
        if !isFiltering(){
            
            //Goes through toLoad more meals and add those into the array
            for i in loaded...(loaded + toLoad - 1){
                
                //Check if it is in range
                if i < nutrientsFilteredMeals.count{
                    
                    //Add meal
                    meals += [nutrientsFilteredMeals[i]]
                    
                }
                
            }
            
            //Update the loaded variable
            loaded += toLoad
        }
        
        //Reload the table data
        tableView.reloadData()
        print(loaded)
        
    }
    
    //TODO:
    //*
    //*
    //*
    //This adds new filtered meals into the array.
    //Adds toLoad amount of new meals to the array every time this function is called
    //This is for scrolling through filtered meals, to load bits at a time
    private func loadMoreFilteredMeals() {
        
        //If the user is filtering, then load more meals
        if isFiltering(){
            
            //Goes through toLoad more meals and add those into the array
            for i in filteredLoaded...(filteredLoaded + toLoad - 1){
                
                //Check if it is in range
                if i < allFilteredMeals.count{
                    
                    //Add meal
                    filteredMeals += [allFilteredMeals[i]]
                }
            }
            
            //Update filteredLoaded variable
            filteredLoaded += toLoad
            
        }
        
        //Reload data
        tableView.reloadData()
        print(loaded)
        
    }
    
    
    //TODO:
    //*
    //*
    //*
    //This function takes in whatever you type in from the search bar and compare it to all the meals in the list
    //This will then give the filtered version of the table
    //Reload data afterwards so that new filtered items appear whenever you type into the search bar
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        
        //Set these values to 0 to reset filtered
        filteredLoaded = 0
        filteredMeals = []
        
        //Filter allMeals
        allFilteredMeals = nutrientsFilteredMeals.filter({( meal : Meal) -> Bool in
            return meal.name.lowercased().contains(searchText.lowercased())
        })
        
        //Load the filtered meals
        loadMoreFilteredMeals()
        
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
    
    //TODO:
    //*
    //*
    //*
    //This function is called whenever this this view controller is shown
    //This is for the filter feature where you press the back button to show this page again
    //This would update the table with the filters
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //Set loaded and meals to 0
        loaded = 0
        meals = []
        
        //If the array is empty, then check if it is loaded from main, then set meals to all meals
        if nutrientsFilteredMeals.isEmpty{
            
            //Not loaded, from main, so must be loaded from filters
            if !loadFromMain{
                
                //Set alert to pop up if this is the case (filter found no meals)
                let alert = UIAlertController(title: "Alert", message: "No meals or ingredients found for filter settings. Reverting back to no filters", preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                
            }
            nutrientsFilteredMeals = allMeals
        }
        
        //Else if it is from main, then set it to allMEals
        if loadFromMain{
            nutrientsFilteredMeals = allMeals
        }
        
        //This loads meals and store them in the array
        loadMoreMeals()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //Table view delegate and datasource
        tableView.delegate = self
        tableView.dataSource = self
        
        //TODO: Rewrite this part to update
        //*
        //*
        //*
        //********//

        //Whenever this view is loaded, don't hide the navigation bar.
        self.navigationController?.isNavigationBarHidden = false
        
        //********//
        
        
        
        //Setup the Search Controller
        //Adds search bar functionality.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Meals"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        
        
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    
    
    //TODO:
    //*
    //*
    //*
    //If the user scrolled all the way to the bottom, and there are more meals to load, then load more meals
    //Compare the current offset with the maximum offset to find out if user is at the bottom
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        //Create current and maximum offset
        let currentOffset = scrollView.contentOffset.y
        let maximumOffset = scrollView.contentSize.height - scrollView.frame.size.height
        
        // Change 10.0 to adjust the distance from bottom, if distance is less than 10, then load more
        if maximumOffset - currentOffset <= 10.0 {
            
            //Not filtering
            if !isFiltering() && allMeals.count > loaded{
                self.loadMoreMeals()
            }
                //Filtering
            else if isFiltering() && allFilteredMeals.count > filteredLoaded{
                self.loadMoreFilteredMeals()
            }
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //return the amount of meals based on what you type on the search bar.
        if isFiltering() {
            return filteredMeals.count
        }
        
        //Else return normal meals count
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
        
        //If user is filtering, then return the meal on the filtered array
        if isFiltering() {
            meal = filteredMeals[indexPath.row]
        }
            //Else if the user is not filtering, then return the meal on the unfiltered array
        else {
            meal = meals[indexPath.row]
        }
        
        //Change cell properties
        cell.foodName.text = meal.name
        
        //Adjust just in case text is too large
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
        
        //Filter segues
        if segue.identifier == "filters"{
            print("LOADEDAEDA")
            loadFromMain = false
        }
        
        
        
        //If the identifier goes to meal view controller then update the foods within that view controller
        if segue.identifier == "newFoods"{
            
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
            
            //Return filtered meal if it is filtered
            if isFiltering(){
                selectedMeal = filteredMeals[indexPath.row]
            }
                //Else return unfiltered meal
            else{
                selectedMeal = meals[indexPath.row]
            }
            
            let dest = segue.destination as! MealViewController
            dest.meal = selectedMeal
            
            dest.numberOfDayMeals = numberOfDayMeals
            
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

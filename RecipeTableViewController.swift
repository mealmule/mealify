//
//  MealTableViewController.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added table that contains all foods (placeholder foods for now)
//                Added Search bar to search for any foods
//                Added segue to page where it displays the meal
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class RecipeTableViewController: UITableViewController {
    
    //Properties and variables
    var recipes = [Recipe]()
    var filteredRecipes = [Recipe]()
    let searchController = UISearchController(searchResultsController: nil)
    
    //This adds new meals into the array.
    //TODO:
    //For now, they are sample meals, but can import meals from database later
    private func loadSampleRecipes() {
        
        let recipe1 = Recipe(recipeName: "Salmon Sashimi", proteins: 5.6, vitaminA: 9.8, vitaminD: 4.2)
        let recipe2 = Recipe(recipeName: "Chocolate Chip Cookies", proteins: 3.2, vitaminA: 6.8, vitaminD: 4.2)
        let recipe3 = Recipe(recipeName: "Chocolate Cake", proteins: 16.2, vitaminA: 9.2, vitaminD: 7.2)
        let recipe4 = Recipe(recipeName: "Fried Rice", proteins: 7.6, vitaminA: 5.8, vitaminD: 2.1)
        let recipe5 = Recipe(recipeName: "Fruit Salad", proteins: 3.2, vitaminA: 12.8, vitaminD: 7.9)

        recipes += [recipe1, recipe2, recipe3, recipe4, recipe5]
        
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
        filteredRecipes = recipes.filter({( recipe : Recipe) -> Bool in
            return recipe.recipeName.lowercased().contains(searchText.lowercased())
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
        
        
        //Hides the back button on navigation bar and implement your own.
        //This gives the back button more options, for example, you can do other things
        //when the back button is pressed.
        self.navigationItem.hidesBackButton = true
        let newButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(RecipeTableViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newButton
        
        //Whenever this view is loaded, don't hide the navigation bar.
        self.navigationController?.isNavigationBarHidden = false
        
        //This loads all the sample meals and store them in the array
        loadSampleRecipes()
        
        //Setup the Search Controller
        //Adds search bar functionality.
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Recipes"
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        
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
            
            if (filteredRecipes.count > 2){
                return 2
            }
            else{
                return filteredRecipes.count
            }
            
        }
        
        if (recipes.count > 2){
            return 2
        }
        else{
            return recipes.count
        }
        
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "RecipeTableViewCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? RecipeTableViewCell  else {
            fatalError("The dequeued cell is not an instance of RecipeTableViewCell.")
        }
        
        
        // Fetches the appropriate meal for the data source layout.
        var recipe : Recipe
        if isFiltering() {
            recipe = filteredRecipes[indexPath.row]
        } else {
            recipe = recipes[indexPath.row]
        }
        
        cell.recipeName.text = recipe.recipeName
        
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
        
        guard let selectedRecipeCell = sender as? RecipeTableViewCell else {
            fatalError("Unexpected sender: (String(describing: sender))")
        }
        
        //Getting the selected meal from the cell you clicked.
        //If user clicked on one cell, the returned value will be the cell you clicked.
        guard let indexPath = tableView.indexPath(for: selectedRecipeCell) else {
            fatalError("The selected cell is not being displayed by the table")
        }
        
        //Check to see if filtered is on or off, return object dependent on the filter (search bar)
        var selectedRecipe = Recipe()
        if isFiltering(){
            selectedRecipe = filteredRecipes[indexPath.row]
        }
        else{
            selectedRecipe = recipes[indexPath.row]
        }
        
        //let dest = segue.destination as! ViewController
        
        
        //If the identifier goes back to view controller, then update the foods within that view controller
        if segue.identifier == "newRecipe"{
            
            let dest = segue.destination as! RecipeViewController
            
            dest.recipe = selectedRecipe
            
        }
        
        
        
        
        
        
    }
    
    
}

//Extension for search bar
extension RecipeTableViewController: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchController.searchBar.text!)
    }
}

//
//  RecipeViewController.swift
//  mealify
//
//  Created by vincent on 2018-07-13.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class RecipeViewController: UIViewController {
    
    var recipe = Recipe()

    @IBOutlet weak var recipeDescription: UITextView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        recipeName.text = recipe.recipeName
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        

        if segue.identifier == "backToMain"{
            
            let dest = segue.destination as! ViewController
            
          //dest.Recipe += [recipe]
        self.navigationController?.isNavigationBarHidden = true
            
        }
        else if segue.identifier == "viewNutrients"{
            let dest = segue.destination as! NutrientsViewController
            dest.recipe = recipe
        }
        
        
    }
 

}

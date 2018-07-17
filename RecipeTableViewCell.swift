//
//  RecipeTableViewCell.swift
//  mealify
//
//  Created by vincent on 2018-07-13.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {

    
    @IBOutlet weak var recipeImage: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeNutrients: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

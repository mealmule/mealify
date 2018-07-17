//
//  MealTableViewCell.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added foodName variable to display on table cell for now
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

//TODO: Add more properties to tabel cell
//Maybe description, calories, or proteins.
class MealTableViewCell: UITableViewCell {
    
    //Properties
    @IBOutlet weak var foodName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

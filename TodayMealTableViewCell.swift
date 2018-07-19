//
//  TodayMealTableViewCell.swift
//  mealify
//
//  Created by vincent on 2018-07-17.

//  Team name: Meal Mules
//  Changes made:
//                  added table cell food name label
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class TodayMealTableViewCell: UITableViewCell {
    
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

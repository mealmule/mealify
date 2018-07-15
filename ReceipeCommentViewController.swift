//
//  ReceipeCommentViewController.swift
//  mealify
//
//  Created by vincent on 2018-07-11.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit

class ReceipeCommentViewController: UIViewController {
    @IBOutlet weak var receipeView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var nameTextField: UITextField!
    
    var receipeName: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let receipeName = receipeName {
            self.receipeView.image = UIImage(named: receipeName)
        }
    }
}

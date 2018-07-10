//
//  ViewController4.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-27.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit

class ViewController4: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBOutlet weak var ye: UIButton!
    @IBAction func yes(_ sender: UIButton) {
        ye.setTitleColor(UIColor .green, for: .normal)
        if(nah.currentTitleColor == .green){
            nah.setTitleColor(UIColor .blue, for: .normal)
        }
    }
    @IBOutlet weak var nah: UIButton!
    @IBAction func no(_ sender: UIButton) {
        nah.setTitleColor(UIColor .green, for: .normal)
        if(ye.currentTitleColor == .green){
            ye.setTitleColor(UIColor .blue, for: .normal)
        }
    }

}

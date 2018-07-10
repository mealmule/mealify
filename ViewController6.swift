//
//  ViewController6.swift
//  userEatingHabits
//
//  Created by John Zheng on 2018-06-29.
//  Copyright © 2018 John Zheng. All rights reserved.
//

import UIKit

class ViewController6: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBOutlet weak var ye: UIButton!
    @IBAction func yes(_ sender: UIButton) {
        ye.setTitleColor(UIColor .green, for: .normal)
        
        if((nah.titleColor(for: .normal) == .green) || (nay.titleColor(for: .normal) == .green)){
            nah.setTitleColor(UIColor .blue, for: .normal)
            nay.setTitleColor(UIColor .blue, for: .normal)
        }
    }
    @IBOutlet weak var nah: UIButton!
    @IBAction func no(_ sender: UIButton) {
        nah.setTitleColor(UIColor .green, for: .normal)
        
        if((ye.titleColor(for: .normal) == .green) || (nay.titleColor(for: .normal) == .green)){
            ye.setTitleColor(UIColor .blue, for: .normal)
            nay.setTitleColor(UIColor .blue, for: .normal)
        }
    }
    @IBOutlet weak var nay: UIButton!
    @IBAction func noo(_ sender: UIButton) {
        nay.setTitleColor(UIColor .green, for: .normal)
        
        if((ye.titleColor(for: .normal) == .green) || (nah.titleColor(for: .normal) == .green)){
            nah.setTitleColor(UIColor .blue, for: .normal)
            ye.setTitleColor(UIColor .blue, for: .normal)
        }
    }
}

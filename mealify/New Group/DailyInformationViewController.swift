//
//  DailyInformationViewController.swift
//  mealify
//
//  Created by Justin Lew on 2018-07-14.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit



class DailyInformationViewController: UIViewController, RetrieveDateDelegate {

    @IBOutlet weak var DateLabel: UILabel!
    
    var dateChosen: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DateLabel.text = dateChosen

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    func getDateInformation(_ date: String) {
        print(date)
        DateLabel.text = date
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

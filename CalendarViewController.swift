//
//  CalendarViewController.swift
//  mealify
//
//  Created by Justin Lew on 2018-07-14.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import FSCalendar
import Charts

protocol RetrieveDateDelegate: class {
    func getDateInformation(_ date: String)
}


class CalendarViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, ChartViewDelegate{
    
    weak var delegate: RetrieveDateDelegate?
    
    var dateChosen: String?
    
    fileprivate weak var calendar: FSCalendar!
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let calendar = FSCalendar(frame: CGRect(x: 10, y: 60, width: 360, height: 300))
        calendar.dataSource = self
        calendar.delegate = self
        view.addSubview(calendar)
        self.calendar = calendar
        
        //Hides the back button on navigation bar and implement your own.
        //This gives the back button more options, for example, you can do other things
        //when the back button is pressed.
        self.navigationItem.hidesBackButton = true
        let newButton = UIBarButtonItem(title: "Back", style: UIBarButtonItemStyle.plain, target: self, action: #selector(CalendarViewController.back(sender:)))
        self.navigationItem.leftBarButtonItem = newButton
        
        //Whenever this view is loaded, don't hide the navigation bar.
        self.navigationController?.isNavigationBarHidden = false
        

        // Do any additional setup after loading the view.
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // when a date is selected, it should redirect to the information for that day

    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        delegate?.getDateInformation("hi")
        dateChosen = self.dateFormatter.string(from: date)
        
        performSegue(withIdentifier: "goToMain", sender: self)
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToMain" {
            dateChosenGlo = dateChosen
        }
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

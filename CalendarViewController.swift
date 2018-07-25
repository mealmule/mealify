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
        
        
        //Whenever this view is loaded, don't hide the navigation bar.
        self.navigationController?.isNavigationBarHidden = false
        

        // Do any additional setup after loading the view.
    }
    
    
    //Todo:
    //*
    //*
    //*
    //Back button functionality.
    //Give functionality to the back button so whenever it is pressed, it will perform an action
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)
        
        //Is popped from the view controller (back button)
        if self.isMovingFromParentViewController {
            
            //Hide navigation bar
            self.navigationController?.isNavigationBarHidden = true
        }
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

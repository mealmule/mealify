//
//  Day.swift
//  Home
//
//  Created by Vincent Yu on 2018-06-29.
//  Team name: Meal Mules
//  Changes made: Added dates, today, yesterday, and tomorrow
//  Known bugs: None so far
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation


//Object for what day it is, and return it in year, month, and day
class DateN {
    
    //Properties
    private let date: Date
    private let calendar: Calendar
    
    let year: Int
    let month: Int
    let day: Int
    
    //Init with all custom days
    init(yy: Int, mm: Int, dd: Int){
        
        self.date = Date()
        self.calendar = Calendar.current
        
        self.year = yy
        self.month = mm
        self.day = dd
        
        
    }
    //Init with being a day before today
    init (yesterday: Bool){
        
        if yesterday {
            self.date = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
            self.calendar = Calendar.current
            
            self.year = calendar.component(.year, from: date)
            self.month = calendar.component(.month, from: date)
            self.day = calendar.component(.day, from: date)
        }
        else{
            
            self.date = Date()
            self.calendar = Calendar.current
            
            self.year = calendar.component(.year, from: date)
            self.month = calendar.component(.month, from: date)
            self.day = calendar.component(.day, from: date)
            
        }
    }
    
    //Init with being a day after today
    init (tomorrow: Bool){
        
        if tomorrow {
            self.date = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
            self.calendar = Calendar.current
            
            self.year = calendar.component(.year, from: date)
            self.month = calendar.component(.month, from: date)
            self.day = calendar.component(.day, from: date)
        }
        else{
            
            self.date = Date()
            self.calendar = Calendar.current
            
            self.year = calendar.component(.year, from: date)
            self.month = calendar.component(.month, from: date)
            self.day = calendar.component(.day, from: date)
            
        }
    }
    
    //Init it to be today.
    init(){
        
        self.date = Date()
        self.calendar = Calendar.current
        
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
        
        
    }
    
}

//
//  Day.swift
//  Home
//
//  Created by vdy on 2018-06-29.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import Foundation

class DateN {
    
    private let date: Date
    private let calendar: Calendar
    
    let year: Int
    let month: Int
    let day: Int
    
    
    init(yy: Int, mm: Int, dd: Int){
        
        self.date = Date()
        self.calendar = Calendar.current
        
        self.year = yy
        self.month = mm
        self.day = dd
        
        
    }
    
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
    
    init(){
        
        self.date = Date()
        self.calendar = Calendar.current
        
        self.year = calendar.component(.year, from: date)
        self.month = calendar.component(.month, from: date)
        self.day = calendar.component(.day, from: date)
        
        
    }
    
}

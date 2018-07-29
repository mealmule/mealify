//
//  AppDelegate.swift
//  mealify
//
//  Created by Justin Lew on 2018-05-26.
//  Copyright © 2018 Meal Mules. All rights reserved.
//

import UIKit
import Firebase


@UIApplicationMain
class AppDelegate2: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    var ref1: DatabaseReference!
    var ref2: DatabaseReference!
    var ref3: DatabaseReference!
    var ref4: DatabaseReference!
    var ref5: DatabaseReference!
    var databaseHandle: DatabaseHandle?
    
    var mealsFilled = false
    var mealNutrientsFilled = false
    var nutrientsFilled = false
    var measureFilled = false
    var conversionFilled = false
    var rep = true
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        
        let myDatabase = Database.database().reference()
        
        //Change all back button colors to grey
        UINavigationBar.appearance().tintColor = UIColor(rgb: 0x9b9b9b)
        
        //Clear the title text for all the back buttons
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(-1000, 0), for:UIBarMetrics.default)
        
        
        return true
    }
    
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


//Extension for UIColor where you can choose which color you want, rgb
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


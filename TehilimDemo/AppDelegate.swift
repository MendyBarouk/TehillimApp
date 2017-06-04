//
//  AppDelegate.swift
//  TehilimDemo
//
//  Created by Mendy Barouk on 04/04/2017.
//  Copyright © 2017 Mendy Barouk. All rights reserved.
//

import UIKit
import CoreData
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        FIRApp.configure()
        
        return true
    }
    

}


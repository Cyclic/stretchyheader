//
//  AppDelegate.swift
//  StretchyHeaderLBTA
//
//  Created by Brian Voong on 12/21/18.
//  Copyright © 2018 Brian Voong. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.rootViewController = StretchyHeaderController(collectionViewLayout: NLStretchyHeaderLayout())
        
        return true
    }
}


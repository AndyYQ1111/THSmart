//
//  AppDelegate.swift
//  THSmart
//
//  Created by YueAndy on 2018/3/20.
//  Copyright © 2018年 pingan. All rights reserved.
//

import UIKit

let kXMAppKey = "401c897d783b0e3b7998c727f43cb76c"

let kXMSecret = "99cdbf92a1a5093e2014eae894ccf7e3"



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = BaseNavigationController(rootViewController: LoginVC())
        return true
    }
}


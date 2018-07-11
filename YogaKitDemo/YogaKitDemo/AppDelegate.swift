//
//  AppDelegate.swift
//  YogaKitDemo
//
//  Created by BBS on 2018/7/11.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        if let window = self.window {
            window.rootViewController = ViewController()
            window.backgroundColor = .white
            window.makeKeyAndVisible()
        }
        return true
    }


}


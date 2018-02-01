//
//  SettingViewController.swift
//  DragMacApp
//
//  Created by BBS on 2018/2/1.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import Cocoa

class SettingViewController: NSViewController {
    
    @IBOutlet weak var accessKeyInput: NSTextField!
    @IBOutlet weak var secretKeyInput: NSTextField!
    @IBOutlet weak var bucketInput: NSTextField!
    @IBOutlet weak var domainInput: NSTextField!
    
    var userDefaults: UserDefaults!
    
    var setttingMeta: [String: NSTextField]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setttingMeta = [
            "accessKey": accessKeyInput,
            "secretKey": secretKeyInput,
            "bucket": bucketInput,
            "domain": domainInput
        ]
        userDefaults = NSUserDefaultsController.shared.defaults
        displaySetting()
    }
    
    func displaySetting() {
       
        for (key, input) in setttingMeta {
            guard let value = userDefaults.string(forKey: key), value.count > 0 else {
                if key == "accessKey" {
                    input.stringValue = "InfH3C262bywrAeDYs2145mmcZgrBrHEqLU3piJB"
                }
                if key == "secretKey" {
                    input.stringValue = "w2ngjcYeM3cvYdNabEPKGV4-aedrQcGN_pm1-7-m"
                }
                if key == "bucket" {
                    input.stringValue = "meihao-image"
                }
                continue
            }
            input.stringValue = value
        }
    }
    
    
    @IBAction func confimAction(_ sender: NSButton) {
        for (key, input) in setttingMeta {
            let settting = input.stringValue
            userDefaults.set(settting, forKey: key)
        }
        userDefaults.synchronize()
        self.view.window?.close()
    }
    
    @IBAction func cancelAction(_ sender: NSButton) {
        self.view.window?.close()
    }
    
}

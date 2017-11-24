//
//  UITableViewCell+Extension.swift
//  Extension
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit



extension UITableViewCell {
    
    //用结构体创建关联key ,可以有效避免 命名空间的污染
    private struct AssociatedKeys {
        static var firstKey = "firstKey"
    }
    
    
    var firstProperty: Bool? {
        set {
            objc_setAssociatedObject(self, &AssociatedKeys.firstKey, NSNumber.init(value: newValue!), objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
        get {
            return (objc_getAssociatedObject(self, &AssociatedKeys.firstKey) as? NSNumber)?.boolValue
        }
    }

    
    func addObserver() {
        let runloop = CFRunLoopGetCurrent()
        let runMode = CFRunLoopMode.defaultMode
        
        let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) { (observer, _) in
            if (true) {//达到一定的条件就移除此监听
                CFRunLoopRemoveObserver(runloop, observer, runMode)
            }
            self.perform(#selector(self.timeAction), on: Thread.main, with: nil, waitUntilDone: false, modes: [RunLoopMode.defaultRunLoopMode.rawValue])
        }
        CFRunLoopAddObserver(runloop, observer, runMode)
    }
    
    @objc func timeAction() {}
}

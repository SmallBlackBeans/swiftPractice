//
//  UICommonManager.swift
//  Swift3-4
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class UICommonManager: NSObject {
    var activityVc: UIViewController?
    
    static let shared: UICommonManager = UICommonManager()
    
    // MARK: - 获取当前显示的控制器
    func currentVc() -> UIViewController {
        if let vc = self.activityVc {
            return vc
        }
        var activityViewController: UIViewController?
        var window = UIApplication.shared.keyWindow
        if window?.windowLevel != UIWindowLevelNormal {
            let windows = UIApplication.shared.windows
            for win in windows {
                if win.windowLevel == UIWindowLevelNormal {
                    window = win
                    break
                }
            }
        }
        let views = (window?.subviews)! as NSArray
        if views.count > 0 {
            let frontView = views.object(at: 0) as! UIView
            let nextResponder = frontView.next
            if (nextResponder?.isKind(of: UIViewController.self))! {
                activityViewController = nextResponder as? UIViewController
                if (nextResponder?.isKind(of: (UINavigationController.self)))! {
                    activityViewController = (nextResponder as? UINavigationController)?.childViewControllers.last
                }else if (nextResponder?.isKind(of: (UITabBarController.self)))! {
                    let nav = (nextResponder as? UITabBarController)?.selectedViewController
                    activityViewController = nav?.childViewControllers.last
                }
            }
            
            else {
                activityViewController = window?.rootViewController
            }
            self.activityVc = activityViewController
        }else {
            activityViewController = window?.rootViewController
        }
        return activityViewController!
    }
    
}

//
//  UIView+BlackBean.swift
//  Swift3-4
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

#if os(macOS)
    import AppKit
#else
    import UIKit
#endif

extension Blackbean where Base: View {
    var height: CGFloat {
        set {
            self.base.frame.size.height = newValue
        }
        get {
            return self.base.frame.size.height
        }
    }
    
    var width: CGFloat {
        set {
            self.base.frame.size.width = newValue
        }
        get {
            return self.base.frame.size.width
        }
    }
    
    var centerX: CGFloat {
        get {
            return self.base.frame.origin.x + self.base.frame.size.width * 0.5
        }
    }
    
    var centerY: CGFloat {
        get {
            return self.base.frame.origin.y + self.base.frame.size.height * 0.5
        }
    }
}

extension UIView {
    //获取第一响应者
    func findFirstResponder() -> UIView? {
        if self.isFirstResponder {
            return self
        }
        for subview in self.subviews {
            let view = subview.findFirstResponder()
            if view != nil {
                return view
            }
        }
        return nil
    }
}

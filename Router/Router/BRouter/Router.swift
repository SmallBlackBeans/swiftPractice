//
//  Router.swift
//  Router
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class Router: NSObject {
    open class func open(_ path: RouterPathable, present: Bool = false, animated: Bool = true, presentComplete: (() -> Void)? = nil) {
        if let cls = path.any as? Routable.Type {
            let vc = cls.initWithParams(params: path.params)
            vc.hidesBottomBarWhenPushed = true
            let currentVc = RouterManager.shared.currentVc()
            if currentVc.navigationController != nil && !present {
                currentVc.navigationController?.pushViewController(vc, animated: animated)
            }else {
                currentVc.present(vc, animated: animated, completion: presentComplete)
            }
        }
    }
}




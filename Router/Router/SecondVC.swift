//
//  SecondVC.swift
//  Router
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class SecondVC: UIViewController, Routable {
  
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.lightGray
    }

    
    static func initWithParams(params: RouterParameter?) -> UIViewController {
        return SecondVC()
    }

}




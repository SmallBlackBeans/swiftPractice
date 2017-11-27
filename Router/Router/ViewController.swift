//
//  ViewController.swift
//  Router
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let demo = Demo(name: "RVC title", id: 1)
            Router.open(RouterPath.third(demo))
        }
    }

}


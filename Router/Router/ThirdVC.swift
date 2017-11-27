//
//  ThirdVC.swift
//  Router
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit
struct Demo {
    var name: String
    var id: Int
}

class ThirdVC: UIViewController {
    
    let demo: Demo
    init(demo: Demo) {
        self.demo = demo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.cyan
        navigationItem.title = demo.name
        
    }
}


extension ThirdVC: Routable {
    
    static func initWithParams(params: RouterParameter?) -> UIViewController {
        guard let demo = params?["demo"] as? Demo else { fatalError("params is  error") }
        let thirdVc = ThirdVC.init(demo: demo)
        return thirdVc
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

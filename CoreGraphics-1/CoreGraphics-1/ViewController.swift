//
//  ViewController.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(cgView)
    }
    
    
    lazy var cgView: CGView = {
        let cgView = CGView()
        cgView.frame = CGRect.init(x: 0,y: 44,width: 300,height: 200)
        cgView.backgroundColor = UIColor.black
        return cgView
    }()

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


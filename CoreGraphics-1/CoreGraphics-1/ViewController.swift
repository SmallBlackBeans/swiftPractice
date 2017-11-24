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
        //self.view.addSubview(cgView)
        //self.view.addSubview(drawView)
        //view.addSubview(textView)
        view.addSubview(imageView)
        //view.addSubview(gradient)
        //view.addSubview(transformView)
    }
    
    
    
    lazy var transformView: CGTransformView = {
        let trans = CGTransformView.init(frame: view.bounds)
        return trans
    }()
    
    lazy var cgView: CGView = {
        let cgView = CGView()
        cgView.frame = CGRect.init(x: 0,y: 44,width: 300,height: 200)
        cgView.backgroundColor = UIColor.black
        return cgView
    }()

    
    lazy var drawView: CGDrawView = {
        let draw = CGDrawView.init(frame: self.view.bounds)
        return draw
    }()
    
    
    lazy var textView: CGTextView = {
        let text = CGTextView.init(frame: self.view.bounds)
        return text
    }()
    
    lazy var imageView: CGImageView = {
        let image = CGImageView.init(frame: view.bounds)
        return image
    }()
    
    lazy var gradient: CGGradienView = {
        let gradient = CGGradienView.init(frame: view.bounds)
        return gradient
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


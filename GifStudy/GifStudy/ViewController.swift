//
//  ViewController.swift
//  GifStudy
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgV: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgV.animationDuration = 10
        imgV.animationRepeatCount = 0
        imgV.contentMode = .scaleAspectFit
        
        
    }
    @IBAction func play(_ sender: UIButton) {
        if !imgV.isAnimating {
            imgV.startAnimating()
        }
    }
    
    @IBAction func pause(_ sender: UIButton) {
        if imgV.isAnimating {
            imgV.stopAnimating()
        }
    }
    

}


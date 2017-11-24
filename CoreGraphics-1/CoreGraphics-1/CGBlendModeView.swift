//
//  CGBlendModeView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

//Quartz 2D 混合模式
class CGBlendModeView: UIView {


    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let rect2 = CGRect.init(x: 0, y: 50, width: 30, height: 200)
        UIRectFillUsingBlendMode(rect2, CGBlendMode.xor)
    }

}

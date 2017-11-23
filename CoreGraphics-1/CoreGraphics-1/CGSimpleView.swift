//
//  CGSimpleView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit


/// 简化版
class CGSimpleView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.move(to: CGPoint.init(x: 10, y: 30))
        context?.addLine(to: CGPoint.init(x: 10, y: 100))
        context?.addLine(to: CGPoint.init(x: 150, y: 100))
        
        context?.closePath()
        
        
        UIColor.red.setStroke()
        UIColor.yellow.setFill()
        
        context?.drawPath(using: .fillStroke)
        
        
        
    }

}

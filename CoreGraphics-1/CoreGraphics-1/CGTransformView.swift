//
//  CGTransformView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit


/// 上下文变换
class CGTransformView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        drawImage(context: context)
    }

    
    func drawImage(context: CGContext) {
        //保存初始状态
        context.saveGState()
        
        //平移
        context.translateBy(x: 100, y: 0)
        
        //缩放
        context.scaleBy(x: 0.8, y: 0.8)
        
        //旋转
        context.rotate(by: CGFloat(Double.pi / 16))
        
        let img = #imageLiteral(resourceName: "timg.jpeg")
        
        img.draw(at: CGPoint.init(x: 0, y: 100))
        
        
    }
}

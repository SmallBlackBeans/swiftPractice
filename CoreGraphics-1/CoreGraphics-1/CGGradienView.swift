//
//  CGGradienView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

public let context = UIGraphicsGetCurrentContext()!

//绘制渐变
class CGGradienView: UIView {
    
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawLinearGradient(context: context)
    }
    
    
    func drawLinearGradient(context: CGContext) {
        
        let color = CGColorSpaceCreateDeviceRGB()
        
        let components: [CGFloat] =
            [
                248.0/255.0,86.0/255.0,86.0/255.0,1,
                249.0/255.0,127.0/255.0,127.0/255.0,1,
                1.0,1.0,1.0,1.0
            ]
        
        //起始位置
        let locations: [CGFloat] = [0,0.4,1]
        let gradient = CGGradient.init(colorSpace: color, colorComponents: components, locations: locations, count: locations.count)
        
        /*
         绘制线性渐变
         context:图形上下文
         gradient:渐变色
         startPoint:起始位置
         endPoint:终止位置
         options:绘制方式,DrawsBeforeStartLocation 开始位置之前就进行绘制，到结束位置之后不再绘制，
         DrawsAfterEndLocation开始位置之前不进行绘制，到结束点之后继续填充
         */
        context.drawLinearGradient(gradient!, start: CGPoint.zero, end: CGPoint.init(x: self.bounds.size.width, y: 100), options: .drawsAfterEndLocation)
        
        
    }
    
     //渐变填充
    func drawRectWithLinearGradientFill(context: CGContext) {
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        //裁剪一块矩形
        //context.clip(to: CGRect.init(x: 20, y: 150, width: 280, height: 300))
        
        UIRectClip(CGRect.init(x: 20, y: 150, width: 280, height: 300))
        
        let components: [CGFloat] = [ 248.0/255.0,86.0/255.0,86.0/255.0,1,
                                      249.0/255.0,127.0/255.0,127.0/255.0,1,
                                      1.0,1.0,1.0,1.0]
        let locations: [CGFloat] = [0, 0.4, 1]
        
        let gradient = CGGradient.init(colorSpace: colorSpace, colorComponents: components, locations: locations, count: locations.count)
        
        context.drawLinearGradient(gradient!, start: CGPoint.init(x: 20, y: 250), end: CGPoint.init(x: 320, y: 300 ), options: .drawsAfterEndLocation)
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

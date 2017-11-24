//
//  CGRectView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class CGDrawView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        //矩形
        self.drawRectWithContext(context: context!)
        // uikit 封装矩形
        drawRectByUIKitWithContext(context: context!)
        
        //画椭圆
        drawEllipse(context: context!)
        
        //画弧形
        drawArc(context: context!)
        
        //Bezier
        drawCurve(context: context!)
        
    }
    
    
    
    
    /// 矩形
    ///
    /// - Parameter context: <#context description#>
    func drawRectWithContext(context: CGContext) {
        let rect = CGRect.init(x: 20, y: 50, width: 280, height: 50)
        
        context.addRect(rect)
        
        UIColor.yellow.set()
        context.drawPath(using: .fillStroke)
    }
    
    
    /// UIKit 封装
    ///
    /// - Parameter context:
    func drawRectByUIKitWithContext(context: CGContext) {
        let rect1 = CGRect.init(x: 20, y: 120, width: 280, height: 50)
        let rect2 = CGRect.init(x: 20, y: 180, width: 280, height: 50)
        
        UIColor.yellow.set()
        UIRectFill(rect1)
        
        UIColor.green.set()
        UIRectFill(rect2)
    }
    
    
    
    //椭圆 或 圆
    func drawEllipse(context: CGContext) {
        let rect = CGRect.init(x: 20, y: 340, width: 100, height: 120)
        
        context.addEllipse(in: rect)
        
        UIColor.purple.set()
        context.drawPath(using: .fill)
    }
    
    
    /// 弧形
    ///
    /// - Parameter context:
    func drawArc(context: CGContext) {
        /*
         添加弧形对象
         x:中心点x坐标
         y:中心点y坐标
         radius:半径
         startAngle:起始弧度
         endAngle:终止弧度
         closewise:是否逆时针绘制，0则顺时针绘制
         */
        
        
        context.addArc(center: CGPoint.init(x: 200, y: 250), radius: 50, startAngle: CGFloat(Double.pi * 0.5), endAngle: 0, clockwise: true)
        UIColor.green.set()
        context.drawPath(using: .fill)
    }
    
    
    
    /// 贝塞尔曲线
    ///
    /// - Parameter context:
    func drawCurve(context: CGContext) {
        context.move(to: CGPoint.init(x: 20, y: 310))
        
        //二阶
        context.addQuadCurve(to: CGPoint.init(x: 220, y: 310), control: CGPoint.init(x: 100, y: 400))
        
        
        //三阶
        context.move(to: CGPoint.init(x: 230, y: 310))
        
        context.addCurve(to: CGPoint.init(x: 100, y: 310), control1: CGPoint.init(x: 400, y: 410), control2: CGPoint.init(x: 300, y: 500))
        
        UIColor.yellow.setFill()
        UIColor.red.setStroke()
        
        context.drawPath(using: .fillStroke)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

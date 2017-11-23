//
//  CGView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import CoreGraphics
class CGView: UIView {

    //drawRect:方法 这个方法在loadView、viewDidLoad方法后执行
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        
        //获取上下文
        let context = UIGraphicsGetCurrentContext()
        
        //创建路径
        let path = CGMutablePath.init()
        path.move(to: CGPoint(x: 10, y: 30))
        path.addLine(to: CGPoint(x: 10, y: 100))
        path.addLine(to: CGPoint(x: 150, y: 100))
        
        context?.addPath(path)
        
        context?.closePath()
        
        
        context?.setStrokeColor(red: 1, green: 0, blue: 1, alpha: 1)
        context?.setFillColor(UIColor.white.cgColor)
        
        context?.setLineWidth(4)
        context?.setLineCap(CGLineCap.round)//顶点样式
        context?.setLineJoin(.round)//连接点样式
        
        
        /* 设置线段样式
         phase 虚线开始的位置 这里是 0
         lengths 虚线长度间隔
         */
        let lentghts: [CGFloat] = [5,7]//长度间隔
        context?.setLineDash(phase: 0, lengths: lentghts)
        
        /// 设置阴影
        let color = UIColor.gray.cgColor
        context?.setShadow(offset: CGSize.init(width: 2, height: 2), blur: 0.8, color: color)
        
        // 5、 绘制图像到指定图形上下文
        /*
         CGPathDrawingMode是填充方式,枚举类型
         Fill:只有填充（非零缠绕数填充），不绘制边框
         EOFill:奇偶规则填充（多条路径交叉时，奇数交叉填充，偶交叉不填充）
         Stroke:只有边框
         FillStroke：既有边框又有填充
         EOFillStroke：奇偶填充并绘制边框
         */
        context?.setTextDrawingMode(.fillStroke)
        
        
        
    }

}

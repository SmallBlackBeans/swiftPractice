//
//  CGRadialGradientView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit


/// 播散 渐变
class CGRadialGradientView: UIView {

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        drawRadialGradient(context: context)
    }
    
    func drawRadialGradient(context: CGContext) {
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        let components: [CGFloat] =
            [
                248.0/255.0,86.0/255.0,86.0/255.0,1,
                249.0/255.0,127.0/255.0,127.0/255.0,1,
                1.0,1.0,1.0,1.0
        ]
        let locations: [CGFloat] = [0,0.4,1]
        
        let gradient = CGGradient.init(colorSpace: colorSpace, colorComponents: components, locations: locations, count: locations.count)
        
        context.drawRadialGradient(gradient!, startCenter: CGPoint.init(x: 100, y: 100), startRadius: 0, endCenter: CGPoint.init(x: 105, y: 105), endRadius: 100, options: CGGradientDrawingOptions.drawsAfterEndLocation)
    }

    
    
   
    
}

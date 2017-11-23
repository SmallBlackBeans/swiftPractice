//
//  CTView.swift
//  CoreText
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import CoreText

class CTView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        
        
        super.draw(rect)
        
        
        //获取当前环境
        let context = UIGraphicsGetCurrentContext()!
        //坐标系翻转
        context.textMatrix = .identity
        context.translateBy(x: 0, y: self.bounds.size.height)
        context.scaleBy(x: 1.0, y: -1.0)
        
        let path = CGMutablePath.init()
        
        path.addRect(self.bounds)
        
        
        let attrString = NSMutableAttributedString.init(string: "Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!Hello CoreText!")
        attrString.addAttributes([NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 30)], range: NSMakeRange(0, 15))
        let framesetter = CTFramesetterCreateWithAttributedString(attrString)
        
        
        let bezierPath = UIBezierPath.init(roundedRect: self.bounds, cornerRadius: self.bounds.size.height * 0.5)
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), bezierPath.cgPath, nil)
        
        CTFrameDraw(frame,context)
    }
    
    
}

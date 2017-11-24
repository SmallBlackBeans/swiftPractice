//
//  CGTextView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class CGTextView: UIView {
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let context = UIGraphicsGetCurrentContext()
        
        self.drawText(context: context)
    }
    
    func drawText(context: CGContext?) {
        let str = "使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制使用CoreGraphics进行文字绘制"
        let rect = CGRect.init(x: 20, y: 20, width: 280, height: 200)
        
        let font = UIFont.systemFont(ofSize: 16)
        
        let color = UIColor.red
        
        let style = NSMutableParagraphStyle()
        style.alignment = .left
        
        (str as NSString).draw(in: rect, withAttributes:
            [
                NSAttributedStringKey.font: font,
                NSAttributedStringKey.foregroundColor: color,
                NSAttributedStringKey.paragraphStyle: style
            ]
        )
        
    }
    
}

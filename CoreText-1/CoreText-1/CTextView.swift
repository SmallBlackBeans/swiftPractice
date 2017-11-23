//
//  CTextView.swift
//  CoreText-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

//等高绘制
class CTextView: CoreTextView {
    let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width  //屏幕宽度
    let SCREEN_HEIGHT: CGFloat = UIScreen.main.bounds.size.height
    
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        let context = UIGraphicsGetCurrentContext()
        
        context?.textMatrix = .identity
        context?.translateBy(x: 0, y: self.bounds.size.width)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        let path = UIBezierPath.init(rect: rect)
        
        
        let attrString = "来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这"
        
        let mutableStr = NSMutableAttributedString.init(string: attrString)
        let frametter = CTFramesetterCreateWithAttributedString(mutableStr)
        let frame = CTFramesetterCreateFrame(frametter, CFRangeMake(0, mutableStr.length), path.cgPath, nil)
        
        
        let lines = CTFrameGetLines(frame)
        let lineCount = CFArrayGetCount(lines)
        
        
        var lineOrigins: [CGPoint] = Array.init(repeating: CGPoint.zero, count: lineCount)
        
        
        
        CTFrameGetLineOrigins(frame, CFRangeMake(0, 0), &lineOrigins)
        
        
        let size = sizeForText(mutableStr)
        let height = size.height
        
        let font = UIFont.systemFont(ofSize: 14)
        var frameY: CGFloat = 0
        
        //平均行高
        let lineHeight = height / CGFloat(lineCount)
        
        for i  in 0..<lineCount {
            let lineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            
            var lineAscent: CGFloat = 0
            var lineDescent: CGFloat = 0
            var leading: CGFloat = 0
            
            CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, &leading)
            
            var lineOrigin = lineOrigins[i]
            
            //左下角是原点
            frameY = height - CGFloat(i + 1) * lineHeight - font.descender
            lineOrigin.y = frameY
            
            //绘制
            context?.textPosition = lineOrigin
            CTLineDraw(lineRef, context!)
            
            frameY = frameY - lineDescent
        }
        
        //CTFrameDraw(frame, context!)
        
    }
    
    
    
    
  
    
}

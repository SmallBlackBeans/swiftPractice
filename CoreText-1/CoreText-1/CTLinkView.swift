//
//  CTLinkView.swift
//  CoreText-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import CoreGraphics
public let SCREEN_WIDTH: CGFloat = UIScreen.main.bounds.size.width
public let HEIGHT: CGFloat = UIScreen.main.bounds.size.height

/// 识别link
class CTLinkView: CoreTextView, UIGestureRecognizerDelegate {
    
    //url的正则
    let regex_url = "(http|ftp|https):\\/\\/[\\w\\-_]+(\\.[\\w\\-_]+)+([\\w\\-\\.,@?^=%&:/~\\+#]*[\\w\\-\\@?^=%&/~\\+#])?"
    
    let regex_at = "@[^\\s@]+?\\s{1}"
    

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(self.tap(gesture:)))
        tap.delegate = self
        addGestureRecognizer(tap)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc
    func tap(gesture: UITapGestureRecognizer) {
        if gesture.state == .ended {
            let nStr = self.str as NSString
            let pressStr = nStr.substring(with: self.pressRange!)
            print(pressStr)
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        var gestureShouldBegin = false
        
        let location = gestureRecognizer.location(in: self)
        let lineIndex = Int(location.y / lineHeight)
        
        
        //转换一下坐标
        let clickPoint = CGPoint.init(x: location.x, y: lineHeight - location.y)
        
        let lines = CTFrameGetLines(self.ctFrame!)
        let lineCount = CFArrayGetCount(lines)
        
        if lineIndex < lineCount {
            let clickLine = unsafeBitCast(CFArrayGetValueAtIndex(lines, lineIndex), to: CTLine.self)
            
            let startIndex = CTLineGetStringIndexForPosition(clickLine, clickPoint)
            
            for range in self.specialRanges {
                if startIndex >= range.location && startIndex <= range.location + range.length {
                    gestureShouldBegin = true
                    self.pressRange = range
                }
            }
            
        }
        return gestureShouldBegin
    }
    
    
    
    
    var lineHeight: CGFloat = 0
    var ctFrame: CTFrame?
    
    var specialRanges = [NSRange]()
    
    let str = "来一段数 @sd圣诞节 字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl http://www.baidu.com 是电话费卡刷卡来这来一段数字,文本emoji http://www.zuber.im 的哈哈哈29993002-309-sdflslsfl是电话费卡 @kakakkak 刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-兰emoji👿😊😊😊😊😊😊😊😊😊😊水电费洛杉矶大立科技😊😊😊😊😊😊😊索拉卡叫我😊😊😊😊😊sljwolw19287812来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这来一段数字,文本emoji的哈哈哈29993002-309-sdflslsfl是电话费卡刷卡来这"
    
    var pressRange: NSRange?
    
    var selfHeight: CGFloat = 0
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let context = UIGraphicsGetCurrentContext()
        
        context?.textMatrix = .identity
        context?.translateBy(x: 0, y: self.bounds.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        let path = UIBezierPath.init(rect: rect)
        
        let mutableStr = NSMutableAttributedString.init(string: str)
        self.specialRanges = recogniseSpecialStringWithAttribute(attrStr: mutableStr)
        
        let framesetter = CTFramesetterCreateWithAttributedString(mutableStr)
        ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableStr.length), path.cgPath, nil)
        
        let lines = CTFrameGetLines(ctFrame!)
        
        let lineCount = CFArrayGetCount(lines)
        
        var lineOrigins: [CGPoint] = [CGPoint].init(repeating: CGPoint.zero, count: lineCount)
        
        
        //获取每一行的原点
        CTFrameGetLineOrigins(ctFrame!, CFRangeMake(0, 0), &lineOrigins)
        
        
        
        //计算Size
        // 获得要绘制区域的高度
        let restrictSize = CGSize.init(width: SCREEN_WIDTH, height: CGFloat.greatestFiniteMagnitude)
        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
        
        let height = coreTextSize.height
        
        let font = UIFont.systemFont(ofSize: 14.0)
        
        var frameY: CGFloat = 0
        lineHeight = height / CGFloat(lineCount)
        
        for i in 0..<lineCount {
            let lineRef = unsafeBitCast(CFArrayGetValueAtIndex(lines, i), to: CTLine.self)
            var lineAscent: CGFloat = 0
            var lineDescent: CGFloat = 0
            var leading: CGFloat = 0
            
            CTLineGetTypographicBounds(lineRef, &lineAscent, &lineDescent, &leading)
            
            var lineOrigin = lineOrigins[i]
            
            frameY = height - CGFloat(i + 1) * lineHeight - font.descender
            lineOrigin.y = frameY
            
            context?.textPosition = lineOrigin
            CTLineDraw(lineRef, context!)
            
            frameY = frameY - lineDescent
        }
        
    }
    
    
    
    func recogniseSpecialStringWithAttribute(attrStr: NSMutableAttributedString) -> [NSRange] {
        var rangeArray = [NSRange]()
        
        let atRegular = try? NSRegularExpression.init(pattern: regex_at, options: NSRegularExpression.Options.caseInsensitive)
        
        let atResults = atRegular?.matches(in: attrStr.string, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, attrStr.length))
        
        for atResult in atResults! {
            attrStr.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.blue,
                                   ], range: NSMakeRange(atResult.range.location, atResult.range.length))
            rangeArray.append(atResult.range)
        }
        
        let urlRegular =  try? NSRegularExpression.init(pattern: regex_url, options: NSRegularExpression.Options.caseInsensitive)
        let urlResults = urlRegular?.matches(in: attrStr.string, options: NSRegularExpression.MatchingOptions.withTransparentBounds, range: NSMakeRange(0, attrStr.length))
        
        for urlResult in urlResults! {
            attrStr.addAttributes([NSAttributedStringKey.foregroundColor: UIColor.red], range: NSMakeRange(urlResult.range.location, urlResult.range.length))
            rangeArray.append(urlResult.range)
        }
        return rangeArray
    }
    
    
    
}



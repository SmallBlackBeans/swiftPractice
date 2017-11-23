//
//  CTPicTxtView.swift
//  CoreText-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

private typealias Image = UIImage
class CTPicTxtView: CoreTextView {

    var image: UIImage?
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        
        //获取上下文环境
        let context = UIGraphicsGetCurrentContext()
        
        //转换坐标
        context?.textMatrix = .identity
        context?.translateBy(x: 0, y: self.bounds.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        
        
        
        //绘制区域
        let path = UIBezierPath(rect: rect)
        
        
        
        //创建需要绘制的文字
        let attrString = "Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText Hello CoreText "
        
        let mutableAttr = NSMutableAttributedString.init(string: attrString)
        
        mutableAttr.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 20),
                                   NSAttributedStringKey.foregroundColor: UIColor.red,
                                   ], range: NSMakeRange(0, 5))
        
        let style = NSMutableParagraphStyle()
        style.lineSpacing = 6
        mutableAttr.addAttributes([NSAttributedStringKey.paragraphStyle: style], range: NSMakeRange(0, mutableAttr.length))
        
        
        //设置图片代理
        var imageName = "timg"
        
        var imageCallback = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (refCon) in
            
        }, getAscent: { (refCon) -> CGFloat in
           return 100 //返回高度
        }, getDescent: { (refConf) -> CGFloat in
            return 50 //返回底部距离
        }) { (refCon) -> CGFloat in
            return 100 //返回宽度
        }
        
        
        let runDelegate = CTRunDelegateCreate(&imageCallback, &imageName)
        let imgString = NSMutableAttributedString.init(string: " ")//空格用于给图片占位
        imgString.addAttribute(NSAttributedStringKey(rawValue: kCTRunDelegateAttributeName as String), value: runDelegate!, range: NSMakeRange(0, 1))//占了一个位置
        imgString.addAttribute(NSAttributedStringKey(rawValue: "imageName"), value: imageName, range: NSMakeRange(0, 1))
        mutableAttr.insert(imgString, at: 15)
        
        
        
        //网络加载
        var netImageCallback = CTRunDelegateCallbacks(version: kCTRunDelegateVersion1, dealloc: { (ref) in
            
        }, getAscent: { (ref) -> CGFloat in
            return 70
        }, getDescent: { (ref) -> CGFloat in
            return 50
        }) { (ref) -> CGFloat in
            return 100
        }
        
        var imageUrl = "https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1511412180308&di=ed7acd1d1c75a73659e93e08af249bfe&imgtype=0&src=http%3A%2F%2Fimg.ycwb.com%2Fnews%2Fattachement%2Fgif%2Fsite2%2F20160921%2F507b9d762551194c19be5f.gif"
        
        let urlRunDelegate = CTRunDelegateCreate(&netImageCallback, &imageUrl)
        let imgUrlString = NSMutableAttributedString.init(string: " ")
        imgUrlString.addAttribute(NSAttributedStringKey(rawValue: kCTRunDelegateAttributeName as String), value: urlRunDelegate!, range: NSMakeRange(0, 1))//占了一个位置
        imgUrlString.addAttribute(NSAttributedStringKey(rawValue: "urlImageName"), value: imageUrl, range: NSMakeRange(0, 1))
        mutableAttr.insert(imgUrlString, at: 100)
        
        let framesetter = CTFramesetterCreateWithAttributedString(mutableAttr)
        
        let frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, mutableAttr.length), path.cgPath, nil)
        
        //开始绘制
        CTFrameDraw(frame, context!)
        
     
        //处理绘制图片逻辑
        let lines = CTFrameGetLines(frame) as Array
        let ctLinesArray = lines as Array
        var originsArray = [CGPoint].init(repeating: CGPoint.zero, count: ctLinesArray.count)
        let range: CFRange = CFRangeMake(0, 0)
        
        //这边会把每一个行的初始位置都放到数组中
        CTFrameGetLineOrigins(frame, range, &originsArray)
        
        //遍历CTLine 找到图片所在的CTRun 并进行绘制 每一行可能有多个
        for i in 0..<lines.count {
            let line = lines[i]
            var lineAscent = CGFloat()
            var lineDescent = CGFloat()
            var lineLeading = CGFloat()
            CTLineGetTypographicBounds(line as! CTLine , &lineAscent, &lineDescent, &lineLeading)
            
            let runs = CTLineGetGlyphRuns(line as! CTLine) as NSArray
            //CTRun是每一个相同属性字符串 ，但是不会隔行。
            for j in 0..<runs.count {
                //遍历每一个CTRun
                var runAscent = CGFloat()
                var runDescent = CGFloat()
                let lineOrigin = originsArray[i]//获取该行的初始位置
                
                let run = runs[j]
                let attributes = CTRunGetAttributes(run as! CTRun) as NSDictionary
                
                let width = CGFloat( CTRunGetTypographicBounds(run as! CTRun, CFRangeMake(0, 0), &runAscent, &runDescent, nil))
                
                let runRect = CGRect.init(x: lineOrigin.x + CTLineGetOffsetForStringIndex(line as! CTLine, CTRunGetStringRange(run as! CTRun).location, nil), y: lineOrigin.y  - runDescent, width: width, height: runAscent + runDescent)
                
                let imageName = attributes.object(forKey: "imageName")
                let urlImageName = attributes.object(forKey: "urlImageName")
                if imageName is NSString {
                    //本地图片
                    if let image = UIImage.init(named: imageName as! String) {
                        let imageDrawRect = CGRect.init(x: runRect.origin.x, y: lineOrigin.y - runDescent, width: 100, height: 100)
                        context?.draw(image.cgImage!, in: imageDrawRect)
                    }
                }
                
                if let urlImageName = urlImageName as? String {
                    var image: Image?
                    let imageDrawRect = CGRect.init(x: runRect.origin.x, y: lineOrigin.y - runDescent, width: 100, height: 100)
                    if  self.image == nil {
                       //image = UIImage//占位图
                        if let url = URL.init(string: urlImageName) {
                            let request = URLRequest.init(url: url)
                            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                                if let data = data {
                                    DispatchQueue.main.sync {
                                        self.image = UIImage.init(data: data)
                                        self.setNeedsDisplay()
                                    }
                                }
                            }).resume()
                        }
                    } else {
                        image = self.image
                    }
                    if let image = image {
                        context?.draw(image.cgImage!, in: imageDrawRect)
                    }
                }
            }
            
            
        }
    }

}

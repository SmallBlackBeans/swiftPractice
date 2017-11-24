//
//  CGImageView.swift
//  CoreGraphics-1
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class CGImageView: UIView {

    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        //drawImage(context: context)
        let image = self.drawImageAtImage()
        let imageView = UIImageView(image: image)
        imageView.center = self.center
        self.addSubview(imageView)
    }
    
    func drawImage(context: CGContext?) {
        let img = #imageLiteral(resourceName: "timg.jpeg")
        img.draw(in: CGRect.init(x: 0, y: 200, width: 100, height: 80))
        img.draw(at: CGPoint.init(x: 0, y: 320))
    }
    
    
    func cgDrawImage(context: CGContext?) {
        let image = #imageLiteral(resourceName: "timg.jpeg")
        let size = UIScreen.main.bounds.size
        
        let height: CGFloat = 450
        let y: CGFloat = 50
        
        context?.saveGState()
        
        let rect = CGRect.init(x: 10, y: y, width: 300, height: height)
        
        
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.translateBy(x: 0, y: -size.height - (size.height - 2 * y - height))
        
        context?.draw(image.cgImage!, in: rect)
    }
    
    
    //水印图片 位图上下文
    func drawImageAtImage() -> UIImage {
        
        let size = CGSize.init(width: 300, height: 300)
        
        UIGraphicsBeginImageContext(size)
        
    
        let img = #imageLiteral(resourceName: "timg.jpeg")
        img.draw(in: CGRect.init(x: 0, y: 0, width: 300, height: 300))
        
        
        //添加水印
        let context = UIGraphicsGetCurrentContext()
        context?.move(to: CGPoint.init(x: 200, y: 178))
        context?.addLine(to: CGPoint.init(x: 265, y: 178))
        
        
        UIColor.red.setStroke()
        context?.setLineWidth(2)
        context?.drawPath(using: .stroke)
        
        
        let str = "韩小醋"
        (str as NSString).draw(in: CGRect.init(x: 200, y: 158, width: 100, height: 30), withAttributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 16), NSAttributedStringKey.foregroundColor: UIColor.red])
        
        //返回绘制的新图像
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        
        
        let data = UIImagePNGRepresentation(newImage!)
        do {
            try (data! as NSData).write(toFile: "path", options: NSData.WritingOptions.atomic)
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        //关闭上下文
        UIGraphicsEndImageContext()
        
        return newImage!
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
  

}

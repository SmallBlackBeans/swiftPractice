//
//  CoreTextView.swift
//  CoreText-1
//
//  Created by 韩承海 on 2017/11/23.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

class CoreTextView: UIView {

    
    /**
     计算Size
     
     - parameter txt: 文本
     
     - returns: size
     */
    func sizeForText(_ mutableAttrStr:NSMutableAttributedString) -> CGSize {
        //创建CTFramesetterRef实例
        let frameSetter = CTFramesetterCreateWithAttributedString(mutableAttrStr)
        
        // 获得要绘制区域的高度
        let restrictSize = CGSize.init(width: SCREEN_WIDTH, height: CGFloat.greatestFiniteMagnitude)
        let coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(frameSetter, CFRangeMake(0, 0) , nil, restrictSize, nil)
        return coreTextSize
    }

}

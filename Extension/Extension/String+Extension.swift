//
//  String+Extension.swift
//  Extension
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import Foundation


extension String {
    
    func pinYin() -> String {
        let mutableString = NSMutableString.init(string: self)
        //转换成拉丁字符
        CFStringTransform(mutableString, nil, kCFStringTransformToLatin, false)
        //去除音标
        CFStringTransform(mutableString, nil, kCFStringTransformStripDiacritics, false)
        let string = String(mutableString)
        //去除空格
        return string.replacingOccurrences(of: " ", with: "")
    }
}

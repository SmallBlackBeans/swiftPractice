//
//  Blackbean.swift
//  Swift3-4
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit


#if os(macOS)
    import AppKit
    public typealias Image = NSImage
    public typealias View = NSView
    public typealias Color = NSColor
    public typealias ImageView = NSImageView
    public typealias Button = NSButton
#else
    import UIKit
    public typealias Image = UIImage
    public typealias Color = UIColor
    #if !os(watchOS)
        public typealias ImageView = UIImageView
        public typealias View = UIView
        public typealias Button = UIButton
    #endif
#endif


public final class Blackbean<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}


public protocol BlackBeanCompatible {
    associatedtype CompatibleType
    var bb: CompatibleType { get }
}



public extension BlackBeanCompatible {
    public var bb: Blackbean<Self> {
        get { return Blackbean(self) }
    }
}


//实现了这个协议就拥有了bb属性， 然后再扩展 Blackbean，对其进行方法扩展
extension Image: BlackBeanCompatible { }
extension View: BlackBeanCompatible { }
#if !os(watchOS)
//    extension ImageView: BlackBeanCompatible { }
//    extension Button: BlackBeanCompatible { }
#endif















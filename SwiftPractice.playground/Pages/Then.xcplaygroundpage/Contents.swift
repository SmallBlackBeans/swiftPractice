//
//  StoryBoardManager.swift
//  StoryBoardExtension
//
//  Created by 韩承海 on 2017/3/17.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import Foundation
import UIKit
/// ej:
///     let label = UILabel().then {
///         $0.textAlignment = .Center
///         $0.textColor = UIColor.blackColor()
///         $0.text = "Hello, World!"
///     }
public protocol Then {}

extension Then where Self: Any {
    public func then(block: (inout Self)-> Void) -> Self {
        var copy = self
        block(&copy)
        return copy
    }
}

extension Then where Self: AnyObject {
    public func then(block: (Self) -> Void) -> Self {
        block(self)
        return self
    }
}

extension NSObject: Then {}
extension CGPoint: Then {}
extension CGRect: Then {}
extension CGSize: Then {}
extension CGVector: Then {}

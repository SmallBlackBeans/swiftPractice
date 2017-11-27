//
//  Routable.swift
//  Router
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

public typealias RouterParameter = [String: Any]
public protocol Routable {
    
    //初始化
    static func initWithParams(params: RouterParameter?) -> UIViewController
}



// MARK: - 路径解耦
public protocol RouterPathable {
    var any: AnyClass { get }
    var params: RouterParameter? { get }
}


//可以分模块 扩展
enum RouterPath: RouterPathable {
    case vc
    case second(String)
    case third(Demo)
    
    var any: AnyClass {
        switch self {
        case .vc:
            return ViewController.self
        case .second:
            return SecondVC.self
        case .third:
            return ThirdVC.self
            
        }
    }
    
    var params: RouterParameter? {
        switch self {
        case .second(let name):
            return ["name":name]
        case .third(let demo):
            return ["demo":demo]
        default:
            return nil
        }
    }
}



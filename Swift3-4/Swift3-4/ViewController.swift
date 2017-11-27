//
//  ViewController.swift
//  Swift3-4
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //第一种消除警告
        _ = discardableResultInt()
        //第二种
        discardableResultString()
        
        
        
        
        //取余 除法
        let m = 12.0
        let n: CGFloat = 19.0
        
        
        let x = CGFloat(m) / n
        print(x)
        let y = m *  Double(n)
        print(y)
        let k = m.remainder(dividingBy: Double(n))
        print(k)
        
        let l = CGFloat(m).truncatingRemainder(dividingBy: n)
        print(l)
        
        
        
        
        do {
            try canThrow()
        } catch let error as XHError {
            print("Error: \(error.domain) - \(error.code)")
        } catch {
            fatalError()
        }
        
        
        
        //前缀引用
        let v: View = View()
        v.bb.width = 10
        
        
        
        
        //GCD
        DispatchQueue.main.async {
            print("我在主线程异步执行")
        }
        
        DispatchQueue.global(qos: .background).async {
            print("我在后台异步执行")
        }
        
        
        let _ = DispatchQueue.init(label: "xhd.demo.test")
        
        let highQueue = DispatchQueue.init(label: "ddd", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
        highQueue.async {
            print("test")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print("3s 后执行")
        }
        
        
        print(UICommonManager.shared.currentVc())
    }
    
    
    // MARK: - 剔除参数中的可选值 反射判断如果值是optional就取出他实际的值.
    func absArray(param: [String: Any]) -> [String: Any] {
        let res = param.map { (k,v) -> (String, Any?) in
            let newValue = Mirror.init(reflecting: v)
            if newValue.displayStyle == Mirror.DisplayStyle.optional {
                if let value = newValue.children.first?.value {
                    return (k,value)
                }else {
                    return (k,nil)
                }
            }
            return (k, v)
        }
        var newParam: [String: Any] = [:]
        res.forEach { (key, v) in
            newParam[key] = v
        }
        return newParam
    }
    
}


extension ViewController: BlackBeanCompatible { }
extension Blackbean where Base: ViewController {
    var scale: CGFloat {
        return 1.0
    }
}


// MARK: - 自定义操作符
infix operator >>> : ATPrecedence
precedencegroup ATPrecedence {
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}

extension ViewController {
    func discardableResultInt() -> Int {
        return 1
    }
    @discardableResult func discardableResultString() -> String {
        return "str"
    }
    
    
    
    
    struct XHError: Error {
        let domain: String
        let code: Int
    }
    
    func canThrow() throws {
        let age = 20
        if age < 10 {
            let error = XHError.init(domain: "xxx", code: 100)
            throw error
        }else {
            
        }
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


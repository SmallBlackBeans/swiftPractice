import Foundation
import XCPlayground
import UIKit
class newFauture {
    //MARK: - 自增 自减 的移除 替换为 += -=
    
    
    //MARK: - for循环  变成了 for in   ().forEach{}
    
    
    //MARK: - 移除了函数参数中的var标记
    func gcd( a: Int,  b: Int) -> Int {
        var a = a
        var b = b
        if (a == b) {
            return a
        }
        repeat {
            if (a > b) {
                a = a - b
            } else {
                b = b - a
            }
        } while (a != b)
        return a
    }
    
    
    //MARK: - swift2函数的参数列表底层实现其实是元组，swift3移除
    let number = (a: 8, b: 12)
    //gcd(number) 被移除
    
    
    //MARK: - Selector 不再允许使用 String
    class Responder: NSObject {
        //继承自object的类，swift4不在自动添加@objc了，需要自己添加
        @objc func tap() {
            print("Button pressed")
        }
    }
    func SelectorStr() {
        let responder = Responder()
        let button = UIButton(type: .system)
        button.addTarget(responder, action: #selector(Responder.tap), for: .touchUpInside)
    }
    
    //MARK: - String key-path
    class Person: NSObject {
        @objc var name = ""
        
        init(name: String) {
            self.name = name
        }
        func test()  {
            let me = Person(name: "laotou")
            me.value(forKeyPath: #keyPath(Person.name))
        }
    }
    
    
    
    
    //MARK: - Foundation 去掉 NS 前缀
    func removeNS()  {
        let file = Bundle.main.path(forResource: "", ofType: "")
        let url = URL(fileURLWithPath: file!)
        let data = try! Data(contentsOf: url)
        let json = try! JSONSerialization.jsonObject(with: data)
        print(json)
    }
    
    //MARK: - M_PI 还是 .pi
    func M_pi() {
        let f_pi = Float.pi
        let d_pi = Double.pi
        let Cg_pi = CGFloat.pi
    }
    
    //MARK: - GCD
    func GCD() {
        let queue = DispatchQueue(label: "swift 3")
        queue.async {
            print("swift 3 queue")
        }
    }
    
    static let frame = CGRect(x: 0, y: 0, width: 100, height: 100)
    //MARK: -  Core Graphics
    class View: UIView {
        override func draw(_ rect: CGRect) {
            guard let context = UIGraphicsGetCurrentContext() else {
                return
            }
            let blue = UIColor.blue.cgColor
            context.setFillColor(blue)
            let red = UIColor.red.cgColor
            context.setStrokeColor(red)
            context.setLineWidth(10)
            context.addRect(rect)
            context.drawPath(using: .fillStroke)
        }
    }
    let aView = View(frame: frame)
    
    
    //MARK: - 动词与名词的命名约定
    /*
     名词
     reverse()  --> reversed() 因为返回的是一个反序的数组是个名词
     sort()    --> sorted()  enumerate() --> enumerated()
     动词
     sortInPlace()排序  --> sort()
     */
    
    
    //MARK: - API 规范化
    /*
     NSData(contentsOfURL) 改为 URL(contentsOf)
     NSJSONSerialization.JSONObjectWithData() 改为 JSONSerialization.jsonObject(with)
     */
    
    
    //MARK: - 枚举成员
    /*
     当做属性使用，以小写开头
     .System 改为 .system
     */
    
    //MARK: - @discardableResult，未使用的处理，消除警告⚠️   OC __attribute__((warn_unused_result))
    
    
    //MARK: - 协议不只包含语法，还有语义，不应该滥用协议
    /*
     “纯语义”协议的一个典型例子是 Error
     
     有价值的算法来自于一组连贯性的语义组成的约束
     
     正确的含义是在协议的遵守者中引入一个 init()，该无参构造器会在协议语义所影响的基础操作中担任重要的角色。
     */
    
}




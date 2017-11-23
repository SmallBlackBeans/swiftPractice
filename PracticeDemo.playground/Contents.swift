//: Playground - noun: a place where people can play

import UIKit

var str = "Hello, playground"
//
//enum StudentError : Error {
//    case nameEmpty
//    case scoreLow
//}
//
//
//
//class Person {}
//class Student : Person {
//    var name: String?
//    var score: Int?
//    var teacher: String?
//    var userIcon: UnsafeMutableRawPointer = malloc(40 * 40 * 4)//定义用户图像数据流
//
//    @objc
//    static let describe = "这是一个学生类型"
//    @objc
//    class func getDefaultValue() -> Int {
//        return 0
//    }
//
//
//    override init() {
//        super.init()
//    }
//
//
//    init(name: String) throws{
//        self.teacher = ""//存储属性必须放在defer块前
//        super.init()//先初始化自己的，在调用父类的
//        //然后可以修改父类的属性
//        if name == "" {
//            defer {
//                free(self.userIcon)
//                print("第二步发生异常，清理内存")
//            }
//            print("第一步 抛出异常")
//            throw StudentError.nameEmpty
//        }
//        self.name = name
//    }
//}
//
//do {
//    let _ = try Student(name: "")
//} catch StudentError.nameEmpty {
//    print("空名字")
//}catch {
//    print(error)
//}
//
//
//public enum APINetError : Error {
//    case requestError(RequestError)
//    case responseError(ResponseError)
//
//    public enum RequestError {
//        case invalidUrl(url: URL)
//        case invalidParams
//    }
//
//    public enum ResponseError {
//        case dataFileNil
//        case missingContentType
//        case unacceptableStatusCode
//        case dataFileReadFaild
//    }
//}
//
//func requestUrl(url: URL) throws {
//    if url.absoluteString.contains("http") {
//        throw APINetError.requestError(.invalidUrl(url: url))
//    }
//}
//
////let params: [String : Any] = ["key": 123456]
////guard let filter = CIFilter(name: "CIGaussianBlur", withInputParameters: params) else {
////    print("吼吼吼")
////    fatalError()
////}
//
//
//
///*
// 当你在一个或者类中使用@obj 创建类方法或者属性时,会被系统知道,认为它是AnyClass 的方法
// */
//func getDefaultValue(c: AnyClass) -> Int? {
//    return c.getDefaultValue?()
//}
//
//func getDescribeValue(c: AnyClass) -> String? {
//    return c.describe
//}
//
//print(getDefaultValue(c: Person.self))
//
////指定了类型
//let StudentType: Student.Type = Student.self //Person.self
//
////任意类的类型
//var type: AnyClass = Student.self
//type = Person.self
//
//
////let student = try StudentType.init(name: "")
//
//
//extension Notification.Name {
//    /// 使用 命名空间
//    public struct HomeNotification {
//        public static let refreshNotification = Notification.Name(rawValue: "HomeRefreshNotification")
//        public static let requestSuccess = Notification.Name(rawValue: "HomeRequestSuccess")
//    }
//
//}
//
//
//NotificationCenter.default.post(name: NSNotification.Name.HomeNotification.refreshNotification, object: ["errorCode": 400])
//
//
//
////NotificationCenter.default.addObserver(nil, selector: #selector(), name: NSNotification.Name.HomeNotification.refreshNotification, object: nil)
//
//
//
//let a:Int??? = nil
//let b = 4
//let c = a ?? b
//print(a)
//print(c)
//
//
////标签用法 类似goto:
////var start:Int = 0
////var final = 1000
////whileLabel: while start != final {
////    start += Int(arc4random_uniform(100)) // 随机增加一个数字
////    switch start {
////    case final:  // 如果 == 最终值结束循环
////        break whileLabel
////    case let x where x > final: //如果值大于1000 则初始化为0 继续开始循环
////        start = 0
////        continue whileLabel
////    default:
////        break
////    }
////    print(start)
////}
//
//
////断言
//let age = -3
////assert(age >= 0, "年龄不能小于0") // 条件为真,不执行断言
//
////创建对象的时候,会给对象分配一个独一无二的标识
//let x = Student()
//let y = x
//print(ObjectIdentifier(x))
//print(ObjectIdentifier(x) == ObjectIdentifier(y))
//print(x === y)
//let z = Student()
//print(ObjectIdentifier(x) == ObjectIdentifier(z))
//print(x === z)
//
//if #available(iOS 10, macOS 10.12, *) {
//
//}


var letters = Set<Character>()
@objc protocol firstDelegate : NSObjectProtocol {
    @objc optional func test()
}
//swift4 移除了?



class firstConfirm : NSObject, firstDelegate { }


protocol ProtocolA {}
protocol ProtocolB : ProtocolA {
}
protocol ProtocolC  {
    
}

func getProtocolConfirmer(foo: ProtocolA & ProtocolC) {
    
}

//类协议
protocol ClassProtocol : class {
    
}



class Student : NSCopying {
    var name: String
    required init(name: String) {
        self.name = name
    }
    
    func copy(with zone: NSZone? = nil) -> Any {
        let student = Student(name: self.name)
        return student
    }
    //自定义copy
    func copy() -> Self {
        let result = type(of: self).init(name: self.name)
        return result
    }
}

let stu1 = Student(name: "小黑")
//let stu2: Student = stu1.copy() as! Student
let stu2 = stu1.copy()
stu1.name = "改名了"
print(stu1.name)
print(stu2.name)


// 定义一个父类
class Person{
    func describe(s: String){
        print("我是父类人")
    }
}
// 定义一个子类
class Man:Person{
    override func describe(s: String) {
        print("我是子类男人")
    }
}


//动态调用父类方法
// 引用父类的方法
let describe = Person.describe
// 传入实际执行的实例对象
let man = Man()
let describeS = describe(man)
// 执行方法
describeS("vvv")


extension UIButton {
    @nonobjc static var count:Int = 0
}


//
//
//func getName(){
//    #if os(iOS)
//        print("我是iOS")
//    #elseif os(watchOS)
//        print("我是手表")
//    #endif
//}
////
//
//#if os(iOS) || os(watchOS) || os(tvOS)
//    import MobileCoreServices
//#elseif os(macOS)
//    import CoreServices
//#endif
//
//




//字面量实现
public struct Thermometer {
    public var temperature: Double
    public init(temperature: Double) {
        self.temperature = temperature
    }
}

extension Thermometer : ExpressibleByFloatLiteral {
    public init(floatLiteral value: FloatLiteralType) {
        self.init(temperature: value)
    }
}


var thermometer: Thermometer = 56.0




// MARK: - 自定义操作符
//swift2
/*
 infix operator  ^^ {
 associativity right
 precedence 155
 }
 */
//swift3
// 自定义操作符 别名类型
infix operator >>> : ATPrecedence
precedencegroup ATPrecedence {
    //associatedtype 区别于
    associativity: left
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
}






func equalThan<T: Equatable>(a: T, b: T) -> Bool {
    return a == b
}


//泛型 是一直模拟类型，起到安全校验作用
equalThan(a: "nihao", b: "en")
equalThan(a: 1, b: 1)


extension UIView {
    //不能包含存储属性
    //let view: UIView?
    //可以有计算属性
    var view: UIView {
        get {
            return UIView()
        }
    }
}



//闭包是引用类型
typealias Closure = ((_ json: [String: Any]) -> String)

let a = Closure.self
let b = a

enum Test<T,V>{
    case Left(T)
    case Right(V)
}




let negativeInt = -1
//在不改变内存的情况下，改为正数
let nonNegativeInt = UInt.init(bitPattern: negativeInt)





@discardableResult
func discardableResultFunc() -> Int {
    return 100;
}

discardableResultFunc()




struct anyStruct {
    init() {
    }
}



//解包请求参数
func absArray(param:[String:Any])->[String:Any]{
    let res = param.map { (key,value) -> (String,Any?) in
        let newValue = Mirror(reflecting: value)
        if newValue.displayStyle == Mirror.DisplayStyle.optional{
            if let v = newValue.children.first?.value{
                return (key,v)
            }else{
                return (key,nil)
            }
        }
        return (key,value)
    }
    var newParam:[String:Any] = [:]
    res.forEach { (key,v) in
        newParam[key] = v
    }
    return newParam
}



//GCD
DispatchQueue.global(qos: .userInteractive).async {
    print("后台执行")
}


let gcdQueue = DispatchQueue(label: "custom")


//指定优先级和队列
let customQueue = DispatchQueue(label: "custom2", qos: .background, attributes: .concurrent, autoreleaseFrequency: .inherit, target: nil)
customQueue.async {
    print("ceshi")
}


DispatchQueue.main.asyncAfter(deadline: 3.0) {
    print("after")
}




//查找当前view 所在VC
// 查找vc
//cmd + alt + [移动选中
public extension UIView {
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        var next = self.superview
        while next != nil {
            responder = next?.next
            if (responder!.isKind(of: UIViewController.self)){
                return (responder as! UIViewController)
            }
            next = next?.superview
        }
        return (responder as! UIViewController)
    }
}




public protocol UIViewCompatible {
    associatedtype CompatableType
    var xh: CompatableType { get }
}

public extension UIViewCompatible {
    public var xh: Auto<Self> {
        get {
            return Auto(self)
        }
        set {}
    }
}


public struct Auto<Base> {
    public let base: Base
    public init(base: Base) {
        self.base = base
    }
}

public extension Auto where Base: UIView {
    var height: CGFloat {
        set(v) {
            self.base.frame.size.height = v
        }
        get {
            return self.base.frame.size.height
        }
    }
    
    // 查找vc
    func responderViewController() -> UIViewController {
        var responder: UIResponder! = nil
        var next = self.superview
        while next != nil {
            responder = next?.next
            if (responder!.isKind(of: UIViewController.self)){
                return (responder as! UIViewController)
            }
            next = next?.superview
        }
        return (responder as! UIViewController)
    }

}

extension UIView: UIViewCompatible {}



let view = UIView()
view.xh.responderViewController()

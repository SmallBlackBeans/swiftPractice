//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

//: [Next](@next)



var Variable = 42
let Constant = 10

let i: Int = 10


let 🐶🐮 = "dogcow"

var n = "xxx"


var a = 1
a += 3

let range = ...5
range.contains(7)

let lineBreaks = """

This string starts with a line break.\
It also ends with a line break.

"""


for character in "Dog!🐶" {
    print(character)
}



// swift String 是 Unicode 集合(会有 字符集群的存在，一个字符由多个Unicode标量组成),  而 NSString  是UTF-16编码 所以 string.cout 不一定等于NSString.length


/// 递归枚举 (5 + 4) * 2
indirect enum ArithmeticExpression {
    case number(Int)
    case addition(ArithmeticExpression, ArithmeticExpression)
    case multiplication(ArithmeticExpression, ArithmeticExpression)
}

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case let .number(value):
        return value
    case let .addition(left, right):
        return evaluate(left) + evaluate(right)
    case let .multiplication(left, right):
        return evaluate(left) * evaluate(right)
    }
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let product = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

print(evaluate(product))



/// 不能在结构体类型的常量（a constant of structure type）上调用可变方法
//let const = Struct()
//const.mutableMethod()


/// 三态开关
enum TriStateSwitch {
    case Off, Low, High
    mutating func next() {
        switch self {
        case .Off:
            self = .Low
        case .Low:
            self = .High
        case .High:
            self = .Off
        }
    }
}


/*
 override关键字会提醒 Swift 编译器去检查该类的超类（或其中一个父类）是否有匹配重写版本的声明
 你可以将一个继承来的只读属性重写为一个读写属性，只需要在重写版本的属性里提供 getter 和 setter 即可。
 但是，你不可以将一个继承来的读写属性重写为一个只读属性
 */



///// 构造器

/// 指定构造器
//  是纵向的 子类-->父类

/// 便利构造器
//  是横向的 只能调用本类的其他构造器，最终调用指定构造器，不能调用父类的便利构造器

/// 必要构造器
//  在类的构造器前添加required修饰符表明所有该类的子类都必须实现该构造器



/*
 强引用
 弱引用  其中一个对象可能为nil
 无主引用 两个对象的生命周期相同 如闭包和实例
 */




//// 访问级别
/// open 比 public 多了一层模块可以继承

/// public

/// file private


/// private


/// 使用 @testable 特性，然后在允许测试的编译设置（Build Options -> Enable Testability）下编译这个应用程序模块，
/// 单元测试目标就可以访问应用程序模块中所有内部级别的实体。

///Tips: 一个 public 类型的所有成员的访问级别默认为 internal 级别，而不是 public 级别




//// 位运算
// 或  当任意一位为1 则 为1
// 与  当都为1 时 则为1
// 取反 0-1  1-0
// 异或 只要两个数不相同 就为1

/*
 这个示例使用了一个命名为 pink 的 UInt32 型常量来存储 CSS 中粉色的颜色值。
 该 CSS 的十六进制颜色值  #CC6699，在 Swift 中表示为 0xCC6699。然后利用按位与运算符（&）和按位右移运算符（>>）从这个颜色值中分解出红（CC）、绿（66）以及蓝（99）三个部分。
 
 红色部分是通过对 0xCC6699 和 0xFF0000 进行按位与运算后得到的。
 0xFF0000 中的 0 部分“掩盖”了  OxCC6699 中的第二、第三个字节，使得数值中的 6699 被忽略，只留下 0xCC0000。
 
 然后，再将这个数按向右移动 16 位（>> 16）。
 十六进制中每两个字符表示 8 个比特位，所以移动 16 位后  0xCC0000 就变为 0x0000CC。
 这个数和0xCC是等同的，也就是十进制数值的 204。
 
 同样的，绿色部分通过对 0xCC6699 和 0x00FF00 进行按位与运算得到 0x006600。
 然后将这个数向右移动 8 位，得到 0x66，也就是十进制数值的 102。
 
 最后，蓝色部分通过对 0xCC6699 和 0x0000FF 进行按位与运算得到 0x000099。这里不需要再向右移位，所以结果为 0x99 ，也就是十进制数值的 153。
 */
let pink: UInt32 = 0xCC6699
let redComponent = (pink & 0xFF0000) >> 16  // redComponent 是 0xCC，即 204
let greenComponent = (pink & 0x00FF00) >> 8 // greenComponent 是 0x66， 即 102
let blueComponent = pink & 0x0000FF         // blueComponent 是 0x99，即 153






//// 运算符
struct Vector2D {
    var x = 0.0, y = 0.0
}

extension Vector2D {
    typealias Element = Vector2D
    /// 中缀运算符 infix
    static func + (left: Element, right: Element) -> Element {
        return Element(x: left.x + right.x, y: right.y + left.y);
    }
    /// 前缀prefix
    static prefix func - (right: Element) -> Element {
        return Element(x: -right.x, y: -right.y);
    }
    /// 后缀postfix
    static postfix func  -- (left: Element) -> Int {
        return 0;
    }
    /// 复合赋值 +=（left: inout left, right: right）{left = left + right}
    static func += (left: inout Element, right: Element) {
        left = left + right;
    }
    
    /// 等价运算符
    static func == (left: Element, right: Element) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    static func != (left: Element, right: Element) -> Bool {
        return !(left == right)
    }
    
    

    
}

//// 优先级和结合性
/// 每一个操作符都隶属于某一个优先级组
infix operator +-: AdditionPrecedence   // 相加优先级
extension Vector2D {
    static func +- (left: Element, right: Element) -> Element {
        return Element(x: left.x + right.x, y: left.y - right.y)
    }
}



//// 类型
/// 命名型类型 类 结构体 枚举
/// 复合型类型 元组 函数



//// 表达式
class SomeClass: NSObject {
    @objc let property: String
    @objc(doSomethingWithInt:)
    func doSomething(_ x: Int) { }
    
    init(property: String) {
        self.property = property
    }
}
let selectorForPropertyGetter = #selector(getter: SomeClass.property)

extension SomeClass {
    @objc(doSomethingWithString:)
    func doSomething(_ x: String) { }
}
let anotherSelector = #selector(SomeClass.doSomething(_:) as (SomeClass) -> (String) -> Void)





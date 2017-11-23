//: [Previous](@previous)

import Foundation

//函数参数默认都是常量

//inout修饰的参数只是被传递给函数，被修改后，再替换了初始值而已


/*
 对于&  swift 中不是传递变量地址或引用，而是 只是变量被传递给函数，被修改后替换初始值。
 */

/*
 哪些类型可以作为inout参数
 只有左值（l-value）才可以当作inout参数使用
 左值需要用一块内存来表达，它的值就是内存区域中存放的内容，例如之前我们使用的变量i就需要一个4字节的内存空间；
 右值则仅仅表示值本身，通常它们不需要特定的内存空间存储，编译器可以把它们优化成某种形式的符号在程序中被使用。
 
 1.变量可以、常量不行
 2.如果一个自定义类型的属性同时有get和set方法，也可以作为inout参数
 3.只读的计算属性，虽然也是var,但不能被inout修饰
 */
func incremental(_ i: inout Int) -> Int {
    i = i + 1
    return i
}
struct Color {
    var r: Int
    var g: Int
    var b: Int
    //只读计算属性
    var hex: Int {
        return r << 16 + g << 8 + b
    }
    
}

var red = Color(r: 254, g: 0, b: 0)
incremental(&red.r)
//incremental(&red.hex) ❌



//自定义的操作符的inout参数不需要&
prefix func ++(i: inout Int) -> Int {
    i += 3
    return i
}
var i = 1
++i



//可以被修改，但却不能逃逸的inout参数
func doubleIncrement(_ i: inout Int) {
    func increment() {
        i += 1
    }
    [0, 1].forEach {_ in increment()}
}

doubleIncrement(&i)


//❌我们却不能通过内嵌函数，让inout参数逃离函数的作用域：
//func increment(_ i: inout Int) -> () -> Void {
//    return {
//        i += 1
//    }
//}
//原因，返回的是一个闭包，当闭包被调用的时候，修改了传进来的参数，但是如果原始的参数已经不存在了，或者已经修改了，闭包结果就无法重新给原始参数赋值。




//传递对象 的引用
func incrementByReference(_ pointer: UnsafeMutablePointer<Int>) {
    pointer.pointee += 1
}


// UnsafeMutablePointer<Int>理解 Int *

incrementByReference(&i)



//同inout 原理类似 不要让接受指针参数的函数返回另外一个函数。













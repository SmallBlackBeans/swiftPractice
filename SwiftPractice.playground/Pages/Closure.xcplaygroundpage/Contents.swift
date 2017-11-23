//: [Previous](@previous)

import Foundation

/*
 func和closure expression都可以用来定义函数，它们只是形式上的不同
 
 无论是用哪种方式定义了函数
 一旦其捕获了变量，函数和它捕获变量的上下文环境一起，就形成了一个closure
 */



//Closure expression:就是函数的一种简写形式
let squareExpression = { (n: Int) -> Int in
    return n * n
}
let numbers = [1, 2, 3, 4, 5]
numbers.map({ (n: Int) -> Int in
    return n * n
})
numbers.map {
    return $0 * $0
}

// func >(lhs: Int, rhs: Int) -> Bool
numbers.sorted(by: >)

//Closure:一个函数加上它捕获的变量一起，才算一个closure
func makeCounter1() -> () -> Int {
    var value = 0
    return {
        value += 1
        
        return value
    }
}

let counter1 = makeCounter1()
let counter2 = makeCounter1()

(0...2).forEach { _ in print(counter1()) } // 1 2 3
(0...5).forEach { _ in print(counter2()) } // 1 2 3 4 5 6

//函数同样可以是一个Closure
func makeCounter2() -> () -> Int {
    var value = 0
    func increment() -> Int {
        value += 1
        return value
    }
    
    return increment
}




//MARK: - @autoclosure

//函数在执行前，要先评估它的所有参数，使用场景需要延后评估某个表达式的值的时候
/*
 所以当参数存在越界或者访问失败的情况时就已经报错了 
 解决方案就是把参数换做函数，把参数的获取推迟到函数的执行。
 为了和参数调用一样，就是用@autoclosure 把传进来的参数自动打包成函数 + 变量 = 闭包
 */



//MARK: - escaping && capture list
/*
 是否需要capture list
 一个比较简单的准则，就是看我们使用的closure是否会独立存活于它的执行环境之外。
    如果是，那么你通常要考虑正确使用capture list；//逃逸闭包
    如果不是，那你完全可以忽略这个东西。//不可逃逸闭包
 */

//1.当把一个closure用作函数参数时，默认都是non escaping属性的.它们只负责执行逻辑，但不会被外界保存和使用---swift2默认都是可逃逸的闭包

//2.下面这两种情况里，closure默认是escaping属性的：
/*
 首先，所有自定义类型的closure属性，默认是escaping的。例如：我们之前已经使用过的fav.buttonPressed，想想这也自然，毕竟我们把closure单独保存了起来
 
 其次，如果closure被封装在一个optional里，它默认是escaping的
 */

func calc(_ n: Int, by: ((Int) -> Int)?) -> Int {
    guard let by = by else { return n }
    return by(n)
}














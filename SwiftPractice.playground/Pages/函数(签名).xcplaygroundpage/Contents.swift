//: [Previous](@previous)

import Foundation

//swift2参数和返回值放在一起，就形成了它的签名，这是用于描述函数自身属性的一种类型
//swift3参数名称不再是函数类型的一部分


//定义可变长度参数
func mul(_ numbers: Int ...) {
    let arrayArg = numbers.reduce (1, *)
    print("\(arrayArg)")
}



//副作用改变一个值
//函数的参数默认是个常量
//1、改变参数
func mulChange(result: inout Int, _ numbers: Int ...) {
    result = numbers.reduce(1, *)
    print("mul: \(result)")
}

var result = 0
mulChange(result: &result, 2, 3, 4, 5)
print(result)



//2、返回一个值
func mulReturn(_ numbers: Int ...) -> Int {
    return numbers.reduce(1, *)
}












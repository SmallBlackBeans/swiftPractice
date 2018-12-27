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



// swift String 是 Unicode 集合(会有 字符集群的存在，一个字符由过个Unicode标量组成),  而 NSString  是UTF-16编码 所以 string.cout 不一定等于NSString.length

//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

fputs("Hello world\n", stdout)

var hellowWorld = "hello world"


//closure里的指针指向的对象是Int8，我们只能按字节来处理指针指向的内存
hellowWorld.withCString { (cPtr: UnsafePointer<Int8>) -> Void in
    debugPrint(cPtr.debugDescription)
}


//Swift中字符和ASCII码的转换
let asciiOfA  = UInt8(ascii: "A")


let charA = Character(UnicodeScalar(65))

let stringA = String(describing: UnicodeScalar(65))

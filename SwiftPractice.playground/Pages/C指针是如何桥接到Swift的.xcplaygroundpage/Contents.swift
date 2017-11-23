//: [Previous](@previous)

import Foundation
/**
 在C里，指针有两类属性：
 
 一类是指针指向的对象是否是常量，例如：const int *和int *，前者不可以更改指针指向的内容，但后者可以；
 一类是指针自身是否带有类型，例如：int *和void *
 */



//带有类型信息的指针


var ten: CInt = 10

withUnsafeMutablePointer(to: &ten, {
    (ptr: UnsafeMutablePointer<CInt>) -> Void in
    ptr.pointee = 20
})


//指针类型的转换
let rawPointer = malloc(10 * MemoryLayout<Int>.size)!

let intPtr = rawPointer.bindMemory(to: Int.self, capacity: 5 * MemoryLayout<Int>.size)


//重新绑定
let tenPointer = rawPointer.assumingMemoryBound(to: CInt.self)

let intConvertPtr = UnsafeMutablePointer<Int32>.allocate(capacity: 1)
intConvertPtr.initialize(to: 0x12345678)

intConvertPtr.withMemoryRebound(to: Int8.self, capacity: 4) { (ptr: UnsafeMutablePointer<Int8>) -> Void in
    print(ptr[0])
    print(ptr[1])
    print(ptr[2])
    print(ptr[3])
}




























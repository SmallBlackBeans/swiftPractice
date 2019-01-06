//: [Previous](@previous)

import Foundation


/**
 Managed：表示指针指向的内容由ARC统一管理，指针只负责内容的访问，不负责内存的管理；
 Unsafe：表示指针指向的内容需要开发者自行管理，所谓自行管理，是指从申请资源、init、deinit到资源回收这一揽子事情，都需要开发者自己来。因此，managed和unsafe是互斥的，它们不会同时出现在一个指针类型的名称中；
 Buffer：表示一段内存地址的view，它可以让我们用不同的形式看待同一块内存地址，稍后我们会看到它的用法；
 Raw：表示指针指向的内存没有类型信息，也就是C中的void *。不带raw的指针类型都会通过泛型参数的形式表示自己指向的内存中包含的对象类型；
 Mutable：表示指针指向的内容可修改，否则指针指向的内存是只读的
 */


//内存分配和回收
var intPtr = UnsafeMutablePointer<Int>.allocate(capacity: 10)
intPtr.initialize(to: 0, count: 10)

intPtr.deinitialize()
intPtr.deallocate(capacity: 10)



//指针的移动
intPtr.predecessor()//移动到intPtr的上一个位置；
intPtr.successor()  //移动到intPtr的下一个位置；
intPtr.advanced(by: 2)//移动到intPtr的下两个位置。但实际上，advanced(by:)的参数也可以是负数，表示移动到之前的位置，甚至可以是0，就表示当前位置；

/**
 .size表示对象自身的大小，
 .stride表示对象在内存中移动一个步进的大小
 .alignment表示对象在内存中的对齐边界
 */
MemoryLayout<Int>.size      // 8
MemoryLayout<Int>.stride    // 8
MemoryLayout<Int>.alignment




/**
 Buffer会以对应类型的MemoryLayout<T>.stride为单位，把内存空间看成是一个集合，进而让我们用类似处理集合的方式访问底层内存
 */

var head = UnsafeMutablePointer<Int>.allocate(capacity: 10)
head.initialize(to: 1, count: 10)

var buffer = UnsafeMutableBufferPointer(start: head, count: 10)


buffer.isEmpty
buffer.count

buffer.max(by: >)
buffer.max()


buffer.min(by: <)
buffer.min()

//用于初始化buffer的start参数 只读的
buffer.baseAddress


let m = buffer[0]

let n = buffer[0..<5]//buffer的一个“切片”


for i in n {
    print("s: \(i)")
}



let first = buffer.first
let last = buffer.last


let six = buffer.first(where: {
    $0 > 5
})


/**
 修改buffer元素的方法
 */
buffer[0] = 0


/**
 排序
 没有ed后缀的，表示直接在buffer原地排序
 有ed后缀的，则会按照buffer中的值排序之后，返回一个[Int]，表示排序的结果，而不会修改buffer自身
 */
buffer.sort(by: >)


buffer.sorted()




/**
 逆序
 */
buffer.reverse()

//和sorted不同，返回的是原buffer逆序排列的view
let reversed = buffer.reversed();
//取出对应的[Int]
let reversedArray = [Int](reversed)



/**
 迭代器
 */
var iter = buffer.makeIterator()

while let value = iter.next() {
    print("Iter: \(value)")
}



let doubleArray = buffer.map { $0 * 2 }

let evenArray = buffer.filter { $0 % 2 == 0 }

let sum = buffer.reduce(0) {
    $0 + $1
}


//在Swift 4中，UnsafeMutableBufferPointer就加入了这些API，在Xcode 9里，我们可以不用借助迭代器来遍历buffer了。



















//: [Previous](@previous)

import Foundation

var array1: Array<Int> = Array<Int>()
var array2: [Int] = []
var array3 = array2


var threeInts = [Int](repeating: 3, count: 3)
var sixInts = threeInts + threeInts
var fiveInts = [1, 2, 3, 4, 5]


fiveInts.count
array1.isEmpty


//Access element
//索引 不被推荐，要确保索引安全
fiveInts[2]



//ArraySlice
type(of:fiveInts[0...2])
Array(fiveInts[0...2])



fiveInts.forEach{ print($0) }


array1.append(1)

array1 += [2, 3, 4]

array1.insert(0, at: array1.startIndex)

//安全性要自己负责
array1.remove(at: 4)
array1.removeLast()//空数组会有问题




//NSArray

var a = [1, 2, 3]
let copyA = a



//Array 是一个泛型类型，所以方法也应该是泛型函数
func getBufferAddress<T>(array: [T]) -> String {
    return array.withUnsafeBytes {
        return String(describing: $0)
    }
}

// copy on write
getBufferAddress(array: a)

getBufferAddress(array: copyA)

a.append(4)//只有修改的时候才会不指向同一个内存


getBufferAddress(array: a)

getBufferAddress(array: copyA)

//copyA.append(4)❌ let

// NSArray & NSMutableArray

let b = NSMutableArray(array: [1, 2, 3])

let copyB: NSArray = b

//值语义的copy
let deepCopyB = b.copy() as! NSArray

b.insert(0, at: 0)
copyB
//内存指针copy,引用类型
deepCopyB



a.filter { $0 > 2}

a.removeLast()//删除
a.popLast()//可选，栈的操作



//MARK: - closure参数化
var fibonacci = [0, 1, 1, 2, 3, 5]
var squares = [Int]()

let constSquares = fibonacci.map {$0 * $0}




extension Array {
    func myMap<T>(_ transform: (Element) -> T) -> [T] {
        var tem: [T] = []
        tem.reserveCapacity(count)
        
        for value in self {
            tem.append(transform(value))
        }
        return tem
    }
}

fibonacci.myMap { $0 * $0 }

fibonacci.elementsEqual([0, 1, 2], by: { $0 == $1 })
fibonacci.starts(with: [0, 1, 1], by: { $0 == $1 })

fibonacci.forEach { print( $0 ) }

fibonacci.sorted(by: > )

//partition 会重新排序
let pivot = fibonacci.partition(by: { $0 > 2 })
fibonacci[0..<pivot]
fibonacci[pivot..<fibonacci.endIndex]
pivot
fibonacci

fibonacci.reduce(0, +) // { $0 + $1 }


//map 副作用
var sum = 0
let constSquares2 = fibonacci.map { (fib: Int) -> Int in
    sum += fib
    return fib * fib
}
sum


extension Array {
    func accumulate<T>(_ initial: T, _ nextAccumulate: (T, Element) -> T) -> [T] {
        var sum = initial
        return map {
            sum = nextAccumulate(sum, $0)
            return sum
        }
    }
}

fibonacci.accumulate(0, +)




//MARK: api

//filter
print(fibonacci.filter { $0 % 2 == 0 })
extension Array {
    func myFilter(_ predicate: (Element) -> Bool) -> [Element] {
        var tmp: [Element] = []
        for value in self where predicate(value) {
            tmp.append(value)
        }
        return tmp
    }
    
    func reject(_ predicate: (Element) -> Bool) -> [Element] {
        return filter { !predicate($0) }
    }
    
    func allMatch(_ predicate: (Element) -> Bool) -> Bool {
        return !contains { !predicate($0) }
    }
    func myReduce<T>(_ initial: T, _ next: (T, Element) -> T) -> T {
        var tmp = initial
        for value in self {
            tmp =  next(tmp, value)
        }
        return tmp
    }
    
    func myFilter2(_ predicate: (Element) -> Bool) -> [Element] {
        return  reduce([], { predicate($1) ? $0 + [$1] : $0 })
    }
    
    func myMap2<T>(_ transform: (Element) -> T) -> [T] {
        return reduce([], { $0  + [transform($1)] }) //O(n^2)
    }
    
    
    
    func myFlatMap<T>(_ transform: (Element) -> [T]) -> [T] {
        var tmp: [T] = []
        for value in self {
            tmp.append(contentsOf:  transform(value))
        }
        return tmp
    }
    
    
}
[2, 4, 6, 8].allMatch { $0 % 2 == 0}
fibonacci.myReduce("") { $0 + "\($1)"}//尾参闭包

fibonacci.myReduce(0, +)
print(fibonacci.myFilter { $0 % 2 == 0 })
print(fibonacci.reject { $0 % 2 == 0 })//不包含满足条件的



let animals = ["🐱", "🐶", "🐰", "🐼"]
let ids = [1, 2, 3, 4]


print(animals.myFlatMap {animal in
    return ids.map {id in
        (animal, id)
    }
})





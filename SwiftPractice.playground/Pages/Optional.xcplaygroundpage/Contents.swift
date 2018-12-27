//: [Previous](@previous)

import Foundation
import UIKit


var number:Int? = 11
if let number = number, number % 2 != 0 {
    print(number)
}


//MARK: - if let
let imageUrl = "xxx"
if let url = URL(string: imageUrl), url.pathExtension == "jpg",
    let data = try? Data(contentsOf: url),
    let image = UIImage(data: data) {
    
    let view = UIImageView(image: image)
}


//MARK: - while let
let numbers = [1, 2, 3, 4, 5, 6]
var iterator = numbers.makeIterator()

while let element = iterator.next() {
    print(element)
}



//MARK: - guard let
//Never，表示这类方法直到程序执行结束都不会返回
func toDo(item: String?) -> Never {
    guard let item = item else {
        fatalError("Nothing to do")
    }
    fatalError("Implement \(item) later")
}


//模拟伪装的optional
func arrayProcess(array: [Int]) -> String? {
    let firstNumber: Int
    
    if let first = array.first {
        //延迟初始化的方式，在if let中，才初始化常量firstNumber；
        firstNumber = first
    } else {
        return nil
    }
    // `firstNumber` could be used here safely
    return String(firstNumber)
}



//optional chaining


let numbers2 = ["fibo6": [0, 1, 1, 2, 3, 5]]
numbers2["fibo6"]?[0] // 0


// ??     nil coalescing操作符
var userInput: String? = nil
let username = userInput ?? "Mars"




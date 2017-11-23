//: Playground - noun: a place where people can play

import UIKit
import Foundation

var str = "Hello, playground"
// MARK: - 对指定的指针数据进行指定的编码
var validUTF8: [UInt8] = [67, 97, 102, 195, 0]
validUTF8.withUnsafeBufferPointer { ptr  in
    //2.参数repairingInvalidCodeUnits 设置为true的意思,表示如果出现编码错误可以使用"\u{FFFD}" 进行替换,如果为false ,一旦出现错误的编码,则直接返回nil
    let s = String.decodeCString(ptr.baseAddress,as: UTF8.self,
                                 repairingInvalidCodeUnits: true)
    print(s!)
}


var strname = "nihao xiaoheidou 黑豆"
//strname.characters.count swift3.2过期
strname.count

strname.utf8.count
strname.utf16.count
strname.unicodeScalars.count

//条件查询索引
let nums = "1,3,5,7,9,11"
let index = nums.index { (char) -> Bool in
    if let num = Int(char.description) {
        if num % 3 == 0 {
            return true
        }
        return false
    }
    return false
}

print(nums[index!])


//判断字符串是不是符合ascii编码
let str2 = "werwer我"
print((str2.unicodeScalars.first?.isASCII)!)

//字符串反向输出
let word = "Backwards"

for char in word.reversed() {
    print(char)
    //print(char, separator: ",", terminator: "")
}

//1.第一步 让对象遵守协议 CustomStringConvertible
class Student : CustomStringConvertible{
    var name = "大🤓"
    var age  = 23
    //2.第二步实现协议
    var description: String{
        return name + "\(age)"
    }
}


let studentReflecting = String(reflecting: Student())
print(Student())
print(studentReflecting)


for char in strname {
    print(char)
}

//字符串分割
var  strSplit = "🐱,🐶,🐀,🐇,🐒, 🐲,🐦,🐥"
let characters = strSplit.split { (c) -> Bool in
    c == ","
}
let array = characters.map { (s) -> String in
    return String(s)
}


let simpleArray = strSplit.split(whereSeparator: { $0 == "," }).map(String.init)



//剔除掉非ascii码的字符 有问题
let favemoji = "My favorite 🎉emoji is 🎉"
if let i = favemoji.utf16.index(where: { $0 >= 128 }) {
    let asciiPrefix = String(favemoji.utf16.prefix(upTo: i))
    print(asciiPrefix as Any)
}



let line = "BLANCHE:   I don't want realism. I want magic!"
print(line.split(whereSeparator: { $0 == " " }) .map(String.init))
// Prints "["BLANCHE:", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"
//  指定最大的分割次数
print(
    line.split(
        maxSplits: 1, whereSeparator: { $0 == " " }
        ).map(String.init))
// Prints "["BLANCHE:", "  I don\'t want realism. I want magic!"]"

//是否不计算空字符（空格）
print(line.split(omittingEmptySubsequences: true, whereSeparator: { $0 == " " }) .map(String.init))
// Prints "["BLANCHE:", "", "", "I", "don\'t", "want", "realism.", "I", "want", "magic!"]"





//获取数据类型占的字节数
//oc
//int size = sizeof(float)
// swift
let size = MemoryLayout<UInt8>.size


HOST_NULL

//let host = Host.current()
//print(host.name)
//print(host.address)
//print(host.localizedName)






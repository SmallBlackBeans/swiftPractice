//: [Previous](@previous)
import Foundation
import UIKit

//自定义类型作为字典key

//不要用引用类型的值作为dictionary的key,因为引用的对象被修改的时候，key也会修改，那么就找不到以前的hash值了
struct Account {
    var type: Int
    var alias: String
    var createdAt: Date
    
    let INT_BIT = (Int)(CHAR_BIT) * MemoryLayout<Int>.size
    func bitwiseRotate(hashValue: Int, bits: Int) -> Int {
        return (hashValue << bits) | (hashValue >> (INT_BIT - bits))
    }
}


extension Account: Hashable {
    var hashValue: Int {//性能
        //异或操作有可交换性，容易碰撞，所以就让它按位旋转后或运算
        // a ^ b == b ^ a
        return bitwiseRotate(hashValue: type.hashValue, bits: 10) ^ alias.hashValue ^ createdAt.hashValue
    }
}


extension Account: Equatable {
    //==
    static func == (lhs: Account, rhs: Account) -> Bool {
        return lhs.type == rhs.type &&
            lhs.alias == rhs.alias &&
            lhs.createdAt == rhs.createdAt
    }
}


var data: [Account: Int]?
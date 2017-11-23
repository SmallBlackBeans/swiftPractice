//: [Previous](@previous)

import Foundation

// 无序，不重复的值，理解为只包含key 没有value

//本质上，Set也是一个哈希表，因此它有着和Dictionary诸多类似的地方。

// type annotation
var vowel: Set<Character> = ["a", "e", "i", "o", "u"]
var vowelSet: Set = ["a", "e", "i", "0", "u"]


//MARK: - Set的常用属性和方法
vowel.count
vowel.isEmpty
vowel.contains("a")
type(of: vowel.remove("a"))
vowel.insert("a")
//vowel.removeAll()

//遍历 无序->有序sorted()
for character in vowel.sorted() {
    print(character)
}

vowel.forEach { print($0) }



//MARK: - 常用的Set方法
var setA: Set = [1, 2, 3, 4, 5, 6]
var setB: Set = [4, 5, 6, 7, 8, 9]

//交集
let insertSectAB = setA.intersection(setB)
//并集
let unionAB = setA.union(setB)
//对称差
let sysmetricDiffAB = setA.symmetricDifference(setB)
//集合a中减去集合b的内容
let aSubtractB = setA.subtracting(setB)
//以上都是返回新的集合
type(of: insertSectAB)


//在自身上修改
setA.formIntersection(setB)
setA.formUnion(setB)




extension Sequence where Iterator.Element : Hashable {
    func unique() -> [Iterator.Element] {
        var tmp: Set<Iterator.Element> = []
        return filter {
            if tmp.contains($0) {
                return false
            }
            else {
                tmp.insert($0)
                return true
            }
        }
    }
}

[1, 1, 2, 2, 4, 4, 3, 3].unique()



//SetAlgebra 代数
//IndexSet 表示1...6 优于下面的
// Set<Int>会保存这个范围内的所有整数 1, 2, 3, 4, 5, 6
let oneToSix: IndexSet = [1, 2, 3, 4, 5, 6]

//CharacterSet
let hw = "hello world"

let numbers = CharacterSet(charactersIn: "123456789")
let letters = CharacterSet.letters//Unicode 字符

hw.rangeOfCharacter(from: letters)//是否包含unicode字符
hw.rangeOfCharacter(from: numbers)//是否包含数字

print(hw.rangeOfCharacter(from: letters) ?? "")









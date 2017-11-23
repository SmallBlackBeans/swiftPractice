//: [Previous](@previous)

import Foundation

let origin = (x: 0, y: 0)

let skills: [String?] = ["Swift", nil, "PHP", "JavaScript", nil]

for case let skill? in skills {
    print(skill)
}

if case (0, 0) = origin {
    print("@origin")
}



let someValues: [Any] = [1, 1.0, "one"]
for value in someValues {
    switch value {
    case let v as Int:
        print("Integer:\(v)")
    case let v as Double:
        print("")
    case let v as String:
        print("")
    default:
        print("Invalid value")
    }
}

switch origin {
case (0, 0):
    print("@origin")
case (_, 0):
    print("is on x axis")
case (0, let y):
    print("(0,\(y))is on y axis")
case (-1...1, -1...1):
    print("is on y axis")
default:
    break
}


enum Direction {
    case north, south, east, west(abbr: String)
}

let west = Direction.west(abbr: "W")
if case .west(let direction) = west {
    print(direction)
}


/////////// 高级样式匹配
enum Power {
    case fullyCharged, outOfPower
    case normal(percentage: Double)
}

let battery = Power.normal(percentage: 0.1)

switch battery {
case .normal(let percentage) where percentage <= 0.1:
    print("Almost out of power")
case .normal(let percentage) where percentage >= 0.8:
    print("Almost fully charged")
case .fullyCharged, .outOfPower:
    print("Fully charged or out of power")
default:
    print("Normal bettery status")
}
/*
 alt + X  ≈
 alt + 5  ∞
 alt + =  ≠
 alt + V  √
 alt + W  ∑
 alt + P  ∏
 alt + >  ≥
 alt + <  ≤
 alt + /  ÷
 shift + alt + 8  °
 shift + alt + =  ±
 
 shift + alt + k  
 alt + G  ©
 alt + R  ®
 alt + 4  ¢美分
 alt + 3  £
 alt + Y ¥日元
 shift + alt + 2 €
 alt + 2 ™
 
 alt + ; …
 alt + - – 短破折
 shift + alt + - — 长破折
 */



//如果样式和要匹配的变量类型不同，或对应类型没有实现Equaltable protocol时，Swift会使用~=操作符进行比较
if case .normal(let percentage) = battery,
    case 0 ... 0.1 = percentage {//Range≈Value range 在左边的原因
    print("Almost out of power")
}

func ~=<T>(value: T, pattern: ClosedRange<T>) -> Bool {
    return pattern.contains(value)
}

//if case .normal(let percentage) = battery,
//    case percentage = 0...0.1 {//定义≈后
//    print("Almost out of power")
//}


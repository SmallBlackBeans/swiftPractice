//: [Previous](@previous)

import Foundation
// Comparable(不可迭代的） 1.0...5.0
//Range
//ClosedRange


//Strideable(可以迭代的)1...5
//CountableRange
//CountableClosedRange

for i in stride(from: 1.0, to: 5.0, by: 1.0) {
    print(i)
}

for i in stride(from: 1.0, through: 5.0, by: 1.0) {
    print(i)
}

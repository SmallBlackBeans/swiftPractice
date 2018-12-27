//: [Previous](@previous)

import Foundation

import UIKit



var swift = "swift 很有趣"


if let index = swift.characters.index(of: "很") {
    swift.insert(contentsOf: "3.0".characters, at: index)
}





if let cnIndex = swift.characters.index(of: "很") {
    swift.replaceSubrange(cnIndex ..< swift.endIndex, with: " is Interesting!")
}

String(swift.characters.suffix(12).dropLast())



swift.characters.split(separator: " ").map(String.init)




var i = 0
swift.characters.split { _ in
    if i > 0 {
    i  = 0
        return true
    }
    else {
    i += 1
        return false
    }
}.map(String.init)
		
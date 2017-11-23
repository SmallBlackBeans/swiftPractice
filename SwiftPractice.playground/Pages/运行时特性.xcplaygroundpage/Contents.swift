//: [Previous](@previous)

import Foundation

//实际应该选择struct
final class Episode: NSObject {
    var title: String
    var type: String
    var length: Int
    
    override var description: String {
        return title + "\t" + type + "\t" + String(length)
    }
    
    init(title: String, type: String, length: Int) {
        self.title = title
        self.type = type
        self.length = length
    }
}

print("title\t\t"  + "type" + "\t" + "length")


let episodes = [
    Episode(title: "title 1", type: "Free", length: 520),
    Episode(title: "title 4", type: "Paid", length: 500),
    Episode(title: "title 2", type: "Free", length: 330),
    Episode(title: "title 5", type: "Paid", length: 260),
    Episode(title: "title 3", type: "Free", length: 240),
    Episode(title: "title 6", type: "Paid", length: 390),
]


let typeDescriptor = NSSortDescriptor(
    key: #keyPath(Episode.type),
    ascending: true,
    selector: #selector(NSString.localizedCompare(_:)))


var descriptors = [ typeDescriptor ]

var sortedEpisodes = (episodes as NSArray).sortedArray(using: descriptors)
sortedEpisodes.forEach { print($0 as! Episode) }
print("=========================================")
let lengthDescriptor = NSSortDescriptor(
    key: #keyPath(Episode.length),
    ascending: true)

descriptors = [ typeDescriptor, lengthDescriptor ]

sortedEpisodes = (episodes as NSArray).sortedArray(using: descriptors)
sortedEpisodes.forEach { print($0 as! Episode) }





// swift 版本 👀
typealias SortDescriptor<T> = (T, T) -> Bool

let stringDescriptor: SortDescriptor<String> = {
    $0.localizedCompare($1) == .orderedAscending
}

let lengthDescriptor2: SortDescriptor<Episode> = {
    $0.length < $1.length
}


func makeDescriptor<Key, Value>(key: @escaping (Key) -> Value, _ isAscending: @escaping (Value, Value) -> Bool) -> SortDescriptor<Key> {
    return {
        isAscending(key($0), key($1))
    }
}

let lengthDescriptorSwift: SortDescriptor<Episode> =
    makeDescriptor(key: { $0.length }, <)

let typeDescriptorSwift: SortDescriptor<Episode> =
    makeDescriptor(key: { $0.type }, {
        $0.localizedCompare($1) == .orderedAscending
    })

/**
 合并多个descriptors呢？核心思想有三条，在合并[SortDescriptor]的过程中：
 
 如果某个descriptor可以比较出大小，那么后面的所有descriptor就都不再比较了；
 只有某个descriptor的比较结果为相等时，才继续用后一个descriptor进行比较；
 如果所有的descriptor的比较结果都相等，则返回false；
 */
func combine<T>(rules: [SortDescriptor<T>]) -> SortDescriptor<T> {
    return { l, r in
        for rule in rules {
            if rule(l, r) {
                return true
            }
            if rule(r, l) {
                return false
            }
        }
        return false
    }
}

let mixDescriptor = combine(rules:
    [typeDescriptorSwift, lengthDescriptorSwift])
print("=========================================")
episodes.sorted(by: mixDescriptor)
    .forEach { print($0) }



//改进
func shift<T: Comparable>(_ compare: @escaping (T, T) -> Bool) -> (T?, T?) -> Bool {
    return { l, r in
        switch (l, r) {
        case (nil, nil):
            return false
        case (nil, _):
            return false
        case (_, nil):
            return true
        case let (l?, r?):
            return compare(l, r)
        default:
            fatalError()
        }
    
    }
}
let intDescriptor: SortDescriptor<String> =
    makeDescriptor(key: { Int($0) }, shift(<))


//定义优先级 https://github.com/apple/swift-evolution/blob/master/proposals/0077-operator-precedence.md
precedencegroup ComparisonPrecedence {
    associativity: left
    higherThan: LogicalConjunctionPrecedence
}

infix operator |>: LogicalDisjunctionPrecedence

func |><T>(l: @escaping SortDescriptor<T>,
        r: @escaping SortDescriptor<T>) -> SortDescriptor<T> {
    return {
        if l($0, $1) {
            return true
        }
        if l($1, $0) {
            return false
        }
        
        if r($0, $1) {
            return true
        }
        return false
    }
}

episodes.sorted(by: typeDescriptorSwift |> lengthDescriptorSwift)


class MyClass {
    //https://github.com/apple/swift-evolution/blob/master/proposals/0160-objc-inference.md
    dynamic func foo() {}//有提案要必须强制@objc
    @objc dynamic func bar() {}
}










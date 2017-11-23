//: [Previous](@previous)

import Foundation

enum RecordType {
    case bool(Bool)
    case number(Int)
    case text(String)
}


var record1: [String: RecordType] = [
    "uid": .number(11),
    "exp": .number(100),
    "favourite": .bool(true),
    "title": .text("Dictionary basics")
]

record1["uid"]
record1["exp"]
record1["title"]

record1["invalid"]


//索引级不同于array
//dictionary hash 表，不代表查找的值就是字典中的某个值
record1.count
record1.isEmpty
//record1.keys.forEach { print($0) }
record1.values


var record2 = record1
record2["favourite"] = .bool(false)
record1["favourite"]


record1.updateValue(.bool(false), forKey: "favourite")
record1["title"] = nil

for (k, v) in record1 {
    print("\(k) \(v)")
}

record1.forEach { print("\($0)  \($1)") }



let defaultRecord: [String: RecordType] = [
    "uid": .number(0),
    "exp": .number(100),
    "favourite": .bool(true),
    "title": .text("")
]

var template = defaultRecord
let recordPatch: [String: RecordType] = [
    "uid": .number(11),
    "title": .text("Common dictionary extensions")
]

extension Dictionary {
    mutating func merge<S>(_ sequence: S) where S : Sequence, S.Iterator.Element == (key: Key, value: Value) {
        sequence.forEach { self[$0] = $1 }
    }
    init<S:Sequence>(_ sequence: S) where S.Iterator.Element == (key: Key, value: Value) {
        self = [:]
        self.merge(sequence)
    }
    
    func mapValue<T>(_ transform: (Value) -> T) -> [Key: T] {
        return Dictionary<Key, T>(map { ($0, transform($1)) })
        //tupleArr -> dictionary
    }
}


template.merge(recordPatch)
print(template)




let record10Patch: [(key: String, value: RecordType)] = [
    (key: "uid", value: .number(10)),
    (key: "title", value: .text("Common dictionary extensions"))
]

var template1 = defaultRecord
template1.merge(record10Patch)
print(template1)



let record11PatcjDic = Dictionary(record10Patch)
print(record11PatcjDic)




let recordSwitch = record11PatcjDic.mapValue { record -> String in
    switch record {
    case .text(let title):
        return title
    case .number(let exp):
        return String(exp)
    case .bool(let favourite):
        return String(favourite)
    }
}

























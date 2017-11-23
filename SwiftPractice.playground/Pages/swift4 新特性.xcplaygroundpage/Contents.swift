//: [Previous](@previous)

import Foundation
import UIKit

let str = "Hello xiaoheidou"

//MARK: 更方便的截取集合切片😁😁😁😁😁😁😁
var i = str.index(of: " ")!

//swift3
let greeting = str.prefix(upTo: i)
i = str.index(i, offsetBy: 1)
let name = str.suffix(from: i)


//swift4 添加了range😁😁😁😁😁😁😁
i = str.index(of: " ")!
let hello  = str[..<i]
let helloWithSpace = str[...i]

i = str.index(i, offsetBy: 1)
let names = str[i...]


//MARK: - 更方便的表达无穷序列😁😁😁😁😁😁😁
Array(str.enumerated())

Array(zip(1..., str))
Array(zip(str, 1...))


//MARK: - 更方便的模式匹配😁😁😁😁😁😁😁
let n = 10
switch n {
case 6...:
print(">= 6")
default:
    break
}



//MARK: - String 又是一个集合类型Collection😁😁😁😁😁😁😁
str.count

let spaceIndex = str.index(of: " ")!

let subString = str[..<spaceIndex]

//str.forEach { s in
//     print(s)
//}



let xmlInfo = """
<?xml version="1.0"?>
<episode id="1">
<title>String is a collection again</title>
<author>11</author>
<created_at>2017-05-18</created_at>
</episode>
"""

let jsonInfo = """
{
"episode": {
"title": "String is a collection",
"author": "11",
"created_at": "2017-05-18"
}
}
"""

//print(xmlInfo)
//print(jsonInfo)


//MARK: - 改进的private访问权限😁😁😁😁😁😁😁
class Robot {
    private var battery: Double = 0.5
}
extension Robot {
    func charge() {
        // This will sucess in Swift 4
        battery = 1.0
    }
}


let root = Robot()
//不过这个仍然是不行的
//root.battery = 0.5


//MARK: - 更智能安全的Key Value Coding😁😁😁😁😁😁😁
class Foo: NSObject {
    @objc var bar = "bar"
    @objc var baz = [1, 2, 3, 4]
}
var foo = Foo()
//print(foo.bar)
foo.bar = "BAR"


var bar = foo.value(forKeyPath: #keyPath(Foo.bar))
foo.setValue("BAR", forKeyPath: #keyPath(Foo.bar))

class FooClass {
    var bar = "bar"
    var baz = [1, 2, 3, 4]
}

struct FooStruct {
    var bar = "bar"
    var baz = [1, 2, 3, 4]
}

//swift4 新的keyPath 无需foo必须是NSObject了,Class struct都可以
let barKeyPath = \Foo.bar
bar = foo[keyPath: barKeyPath]
foo[keyPath: barKeyPath] = "Bar"
//下标还没有实现
//foo[keyPath: \Foo.baz[1]]


//MARK: - Dictionary初始化以及常用操作的诸多改进😁😁😁😁😁😁😁
let numberDictionary = ["one": 1, "two": 2, "three": 3, "four": 4]
//evenColl的类型是LazyFilterCollection<Dictionary<String, Int>>
let evenColl = numberDictionary.lazy.filter { $0.1 % 2 == 0}
//转回标准Dictionary的方法 还没有实现
//let evenDictionary = Dictionary(uniqueKeysWithValues: evenColl)
//临时解决方案
let evenDictionary = Dictionary(uniqueKeysWithValues: evenColl.map { (key: $0.0, value: $0.1) })

var numbers = ["ONE", "TWO", "THREE"]
var numberDict = Dictionary(uniqueKeysWithValues: numbers.enumerated().map { ($0.0 + 1, $0.1) })

numberDict = Dictionary(uniqueKeysWithValues: zip(1..., numbers))



//重复key
let duplicates = [("a", 1), ("b", 2), ("a", 3), ("b", 4)]
let letters = Dictionary(duplicates, uniquingKeysWith: max)


let recordNames = ["Aaron", "Abe", "Bain", "Bally", "Bald", "Mars", "Nacci"]

//按起始字母分类所有人名
let groupedNames = Dictionary(grouping: recordNames, by: { $0.first! })
//print(groupedNames)


//MARK: - 带有默认值的下标操作符😁😁😁😁😁😁😁
let characters = "aaabbbcc"
var frequencies: [Character: Int] = [:]
characters.forEach {
    frequencies[$0, default: 0] += 1
}
frequencies

let filtered = numberDictionary.filter { $0.value % 2 == 0 }
// Array<(Key, Value)> in Swift 3
// Dictionary<String, Int> in Swift 4
type(of: filtered)


//仅希望对Dictionary中的Value进行某种变换
let mapped = numberDict.mapValues { $0.lowercased() }
mapped // [2: "two", 3: "three", 1: "one"]


//MARK: - 新增一个swapAt方法
var intNumbers = [0, 1, 2, 3, 4, 5]
intNumbers.swapAt(0, 5)
// [5, 1, 2, 3, 4, 0]

//swift3
//已过期，之前的swap方法违背了Swift Ownership Manifesto中的约定，在一个函数里，同一个变量不能传递给两个inout参数
//swap(&intNumbers[0], &intNumbers[5])


//MARK: - 使用泛型下标操作符
struct JSON {
    private var data: [String: Any]
    
    init(data: [String: Any]) {
        self.data = data
    }
    
    subscript(key: String) -> Any? {
        return data[key]
    }
    //swift 4
    subscript<T>(key: String) -> T? {
        return data[key] as? T
    }
}

let json = JSON(data: [
    "title": "Generic subscript",
    "duration": 300
    ])
//swift3
let title: String? = json["title"] as? String
//swift4
let duration: Int? = json["duration"]






//MARK: - 用AnyObject约束任意遵从protocol的类 (protocol-constraints)
protocol P {}
struct S : P {}
class C : P {}
class D { }
//AnyObject表示任意一个class （sturct会报编译错误）
let u: AnyObject & P = C()
let v: P & AnyObject = C()

//用具体的类名约束遵从protocol的类以及派生类
class E : D, P {}
let w: D & P = E()


//同时使用了AnyObject和具体的类名，则具体的类名会覆盖AnyObject
let k: D & P = E()
//等价于
let m: AnyObject & D & P = E()


//MARK: - 使用Codable解析JSON
let response = """
{
"title": "How to parse JSON in Swift 4",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": 1.23,
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
"""


struct Episode : Codable {
    var title: String
    var series: String
    //var creator: String
    var type: EpisodeType
    //处理日期
    let createdAt: Date
    //自定义key
    let createdBy: String
    //浮点数
    let duration: Float
    //处理JSON中的base64编码
    var origin: Data
    //处理URL
    let url: URL
    enum CodingKeys: String, CodingKey {
        case title
        case series
        case type
        case createdAt = "created_at"
        case createdBy = "created_by"
        case duration
        case origin
        case url
    }
    
    enum EpisodeType: String, Codable {
        case free
        case paid
    }
}

var data = response.data(using: .utf8)!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601
decoder.dataDecodingStrategy = .base64
decoder.nonConformingFloatDecodingStrategy = .convertFromString(positiveInfinity: "+Infinity", negativeInfinity: "-Infinity", nan: "NaN")
let episode = try! decoder.decode(Episode.self, from: data)

episode
//dump(String(data: episode.origin, encoding: .utf8)!)
//dump(episode.duration)


let customEpisode = Episode(
    title: "haha",
    series: "nicai",
    type: .free,
    createdAt: Date(),
    createdBy: "hanhan",
    duration: 6.5,
    origin: Data(),
    url: URL(fileURLWithPath: "www.baidu.com")
)
let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted
encoder.dateEncodingStrategy = .iso8601
data = try! encoder.encode(customEpisode)
//print(String(data: data, encoding: .utf8)!)




//MARK: - 如何处理常见的JSON嵌套结构
//1.对象封装数组
let listJson = """
{
"list": [
{
"title": "How to parse JSON in Swift 4 - I",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
},
{
"title": "How to parse JSON in Swift 4 - II",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
]
}
"""
struct EpisodeList : Codable {
    let list: [Episode]
}

data = listJson.data(using: .utf8)!
let list = try! decoder.decode(EpisodeList.self, from: data)
//dump(list)


//2.数组作为JSON根对象
let arrayJson = """
[
{
"title": "How to parse JSON in Swift 4 - I",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
},
{
"title": "How to parse JSON in Swift 4 - II",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
]
"""
data = arrayJson.data(using: .utf8)!
let listArr = try! decoder.decode([Episode].self, from: data)
//dump(listArr)

//3.纯数组中的对象带有唯一Key [Dictionary<String: Episode>]
let arrayKeyJson = """
[
{
"episode": {
"title": "How to parse JSON in Swift 4 - I",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
},
{
"episode": {
"title": "How to parse JSON in Swift 4 - I",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
}
]
"""
data = arrayKeyJson.data(using: .utf8)!
let listKeyArr = try! decoder.decode([[String: Episode]].self, from: data)
//dump(listKeyArr)


//4.复杂model
let complexResponse = """
{
"meta": {
"total_exp": 1000,
"level": "beginner",
"total_duration": 120
},
"list": [
{
"title": "How to parse JSON in Swift 4 - I",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
},
{
"title": "How to parse JSON in Swift 4 - II",
"series": "What's new in Swift 4",
"created_by": "Mars",
"type": "free",
"created_at": "2017-08-23T01:42:42Z",
"duration": "NaN",
"origin": "Ym94dWVpby5jb20=",
"url": "boxueio.com"
}
]
}
"""

struct EpisodeMeta : Codable {
    let total_exp: Int
    let level: EpisodeLevel
    let total_duration: Int
    
    enum EpisodeLevel : String, Codable {
        case beginner
        case intermediate
        case advanced
    }
}


struct EpisodePage : Codable{
    let meta: EpisodeMeta
    let list: [Episode]
}
   

//MARK: - 如何自定义model对象的编码过程😁😁😁😁😁😁😁
struct Customer : Codable {
    let title: String
    let createAt: Date
    let comment: String?//可选类型，如果为nil，将不会被编码进去，如果想要看到它，我们需要强行编码
    let duration: Int
    let slices: [Float]
    enum CodingKeys : String, CodingKey {
        case title
        case createAt = "created_at"
        case comment
        case duration
        case slices
    }
}
extension Customer {
    func encode(to encoder: Encoder) throws {
        //先创建一个容器用了存储,容器叫做Keyed Container
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(title, forKey: .title)
        try container.encode(createAt, forKey: .createAt)
        //自定义Optional对象的编码，强行编码进去
        try container.encode(comment, forKey: .comment)
        
        var unkeyedContainer = container.nestedUnkeyedContainer(forKey: .slices)
        try slices.forEach {//更加duration，设置切片时间点
            try unkeyedContainer.encode(Float(duration) * $0)
        }
    }
}


let customer = Customer(title: "How to parse a JSON",
                        createAt: Date(),
                        comment: nil,
                        duration: 500,
                        slices: [0.25, 0.5, 0.75])
let encoderC = JSONEncoder()
encoderC.outputFormatting = .prettyPrinted

var dataC = try! encoderC.encode(customer)
//print(String(data: dataC, encoding: .utf8)!)

//要定制Date的编码方式，为此，我们得使用另外一种容器，叫做Single Value Container：
encoderC.dateEncodingStrategy = .custom({ (date, encoder) in
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd hh:mm:ss"
    let stringData = formatter.string(from: date)
    var container = encoder.singleValueContainer()
    try container.encode(stringData)
})
dataC = try! encoderC.encode(customer)
//print(String(data: dataC, encoding: .utf8)!)




//MARK: - 如何自定义JSON的解码过程😁😁😁😁😁😁😁
struct DecoderModel : Codable {
    var title: String
    var comment: String?
    var createdAt: Date
    var duration: Int
    var slices: [Float]
    enum CodingKeys : String, CodingKey {
        case title
        case createdAt = "created_at"
        case comment
        case duration
        case slices
    }
    //一旦我们自定义了init，编译器便不再为我们合成memberwise init方法了
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let title = try container.decode(String.self, forKey: .title)
        let createdAt = try container.decode(Date.self, forKey: .createdAt)
        let duration = try container.decode(Int.self, forKey: .duration)
        let comment = try container.decodeIfPresent(String.self, forKey: .comment)
        var unkeyedContainer = try container.nestedUnkeyedContainer(forKey: .slices)
        var percentages: [Float] = []
        while (!unkeyedContainer.isAtEnd) {
            let sliceDuration = try unkeyedContainer.decode(Float.self)
            percentages.append(sliceDuration / Float(duration))
        }
        self.init(title: title, createdAt: createdAt, comment: comment, duration: duration, slices: percentages)
    }
    //memberwise init
    init(title: String, createdAt: Date, comment: String?, duration: Int, slices: [Float]) {
        self.title = title
        self.createdAt = createdAt
        self.comment = comment
        self.duration = duration
        self.slices = slices
    }
}


let responseJ = """
{
"title": "How to parse a json - IV",
"comment": "null",
"created_at": "2017-08-24 00:00:00 +0800",
"duration": 500,
"slices": [125, 250, 375]
}
"""
let dataJ = responseJ.data(using: .utf8)!
let decoderJ = JSONDecoder()
decoderJ.dateDecodingStrategy = .custom({ (decoder) -> Date in
    let date = try decoder.singleValueContainer().decode(String.self)
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
    return formatter.date(from: date)!
})
let decoderM = try decoderJ.decode(DecoderModel.self, from: dataJ)
dump(decoderM)




//: [Next](@next)

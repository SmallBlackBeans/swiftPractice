import Foundation
import UIKit
//class NamedShape {
//    var numberOfSides: Int = 0
//    var name: String
//
//    init(name: String) {
//        self.name = name
//    }
//
//    func simpleDescription() -> String {
//        return "A shape with \(numberOfSides) sides."
//    }
//}
//
//class Square: NamedShape {
//    var sideLength: Double
//
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numberOfSides = 4
//    }
//
//    func area() ->  Double {
//        return sideLength * sideLength
//    }
//
//    override func simpleDescription() -> String {
//        return "A square with sides of length \(sideLength)."
//    }
//}
//
//class EquilateralTriangle: NamedShape {
//    var sideLength: Double = 0.0
//
//    init(sideLength: Double, name: String) {
//        self.sideLength = sideLength
//        super.init(name: name)
//        numberOfSides = 3
//    }
//
//    var perimeter: Double {
//        get {
//            return 3.0 * sideLength
//        }
//        set {
//            sideLength = newValue / 3.0
//        }
//    }
//
//    override func simpleDescription() -> String {
//        return "An equilateral triagle with sides of length \(sideLength)."
//    }
//}
//
//class TriangleAndSquare {
//    var triangle: EquilateralTriangle {
//        willSet {
//            square.sideLength = newValue.sideLength
//        }
//    }
//    var square: Square {
//        willSet {
//            triangle.sideLength = newValue.sideLength
//        }
//    }
//    init(size: Double, name: String) {
//        triangle = EquilateralTriangle(sideLength: 20, name: name)
//        square = Square(sideLength: size, name: name)
//    }
//}
//var triangleAndSquare = TriangleAndSquare(size: 10, name: "another test shape")
//triangleAndSquare.square.sideLength
//triangleAndSquare.triangle.sideLength
//triangleAndSquare.square = Square(sideLength: 50, name: "larger square")
//triangleAndSquare.triangle.sideLength
//
//
//
//
//
//enum Rank: Int {
//    case Ace = 1
//    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten
//    case Jack, Queen, King
//    func simpleDescription() -> String {
//        switch self {
//        case .Ace:
//            return "ace"
//        case .Two:
//            return "Two"
//        case .Jack:
//            return "jack"
//        case .Queen:
//            return "queen"
//        case .King:
//            return "king"
//        default:
//            return String(self.rawValue)
//        }
//    }
//}
//let ace = Rank.Ace
//let aceRawValue = ace.rawValue
//if let convertedRank = Rank.init(rawValue: 2) {
//    let threeDescription = convertedRank.simpleDescription()
//}
//
//
//
//enum Suit{
//    case Spades, Hearts, Diamonds, Clubs
//    func simpleDescription() -> String {
//        switch self {
//        case .Spades:
//            return "spades"
//        case .Hearts:
//            return "hearts"
//        case .Diamonds:
//            return "diamonds"
//        case .Clubs:
//            return "clubs"
//        }
//    }
//
//}
//let hearts = Suit.Hearts
//let heartsDescription = hearts.simpleDescription()
//
//
//
//
//
//protocol ExampleProtocol {
//    var simpleDescription: String { get }
//    mutating func adjust()
//}
//
//
//let protocolValue: ExampleProtocol
////protocolValue.simpleDescription
//// protocolValue.anotherProperty
//// Uncomment to see the error
//
//
//for i in 1...10 {
//
//}
//
//func repeatFuc<ItemType>(item: ItemType, times: Int) -> [ItemType] {
//    var result = [ItemType]()
//    for _ in 0..<times {
//        result.append(item)
//    }
//    return result
//}
//repeatFuc(item: "knock", times: 4)
//repeatFuc(item: 100, times: 4)
//
//
//
//
//func anyCommonElements <T, U> (lhs: T, rhs: U) -> Bool where T: Sequence, U: Sequence, T.Iterator.Element: Equatable, T.Iterator.Element == U.Iterator.Element  {
//    for lhsItem in lhs {
//        for rhsItem in rhs {
//            if lhsItem == rhsItem {
//                return true
//            }
//        }
//    }
//    return false
//}
//anyCommonElements(lhs: [1, 2, 3], rhs: [3])
//
//
//
//func curry<T, U, O>(_ f:@escaping (T, U) -> O) -> (T) -> (U) -> O {
//    return { a in return { b in return f(a, b) } }
//}
//
//let users = [["id":1, "name":"Noah"], ["id":2, "name":"Kell"]]
//
//let get = curry{ (key:String, dict:[String:Any]) in
//    return dict[key]
//}
//
//let get2 = curry { (key: String, value: String)  in
//    return "2";
//}
//
//let names = users.flatMap(get("name"))
//
//
//
//
//
//func strDemo() {
//    let str: String = "我们一起飞"
//    let ocStr = str as NSString
//    ocStr.substring(with: NSRange(location: 2, length: 3))
//
//    str.substring(from: "我们".endIndex )
//    ocStr.substring(to: 3)
//    guard let range = str.range(of: "一起") else {
//        print("没有找到")
//        return
//    }
//}
//
//
//var x: Double = 0
//for i in 0..<72 {
//    x = sin(M_PI / 18 * Double(i))
//}
//
//let btn = UIButton()
//btn.setTitle("haha", for: .normal)
//
//
//let min = 3
//let seconds = 4
//let time = String.init(format: "%02d:%02d", arguments: [min, seconds])
//print(time)
//
//
//var arrMutable: Array? = [String]()
//arrMutable = nil
//let arrsd: [Any] = [1,3,3,"nihao"]
//
//let url: URL? = URL(string:"")
//
//
//func mutalFun(number: Double...) {
//
//}
//class Person : NSObject {
//    // 结构体或者类的类型,必须是可选类型.因为不能保证一定会赋值
//    var name: String?
//    override init() {
//        self.name = ""
//    }
//
//    //计算属性
//    var totalScore: String {
////        get {
////            return "hahha"
////        }
//        //等价于只读属性
//        return "只读属性"
//    }
//
//    //存储属性
//    var score: String = "" {
//        willSet(new) {
//
//        }
//        didSet(old) {
//
//        }
//    }
//
//    init(name: String, score: String = "") {
//        self.name = name
//        self.score = score
//        super.init()
//    }
//    // 自定义构造函数,会覆盖init()函数
//    init(dict : [String : NSObject]) {
//        //必须先初始化对象
//        super.init()
//        // 调用对象的KVC方法字典转模型
//        setValuesForKeys(dict)
//    }
//}
//
//let per = Person()
//print(per.totalScore)

////闭包
//public class HttpTool : NSObject {
//
//    var callBack: (() -> ())?
//
//    func loadRequest(callBack: @escaping () -> ()) {
//        DispatchQueue.global().async {
//            print("耗时操作\(Thread.current)")
//            DispatchQueue.main.async {
//                callBack()
//                print("主线程更新UI")
//            }
//        }
//        //循环引用
//        self.callBack       = callBack;
//    }
//
//    deinit {
//        print("我销毁了")
//    }
//}
//
//let httpTool        = HttpTool()
////    httpTool.loadRequest() {[weak self] () -> () in
////        print("回到主线程")
////    }
////    httpTool.loadRequest { [unowned self] () -> () in
////        print("回到主线程")
////    }
//
//
//// 1.定义字符串数组
//let animals         = ["DRAGON", "CAT", "TIGER"]
//
//// 2.使用函数映射
//let animalEmojis    = animals.map { (str : String) -> Character in
//    let tmp             = "\\N{\(str)}"
//    let emojiStr =
//        tmp.applyingTransform(
//            StringTransform.toUnicodeName,
//            reverse: true)
//    return emojiStr!.first!
//}
//
//// 3.打印结果
//print(animalEmojis)
//
//
//func send(job: Int, toPrinter printerName: String) throws -> String {
//    if printerName == "Never Has Toner" {
//        throw PrinterError.noToner
//    }
//    return "Job sent"
//}
//
//enum PrinterError: Error {
//    case outOfPaper
//    case noToner
//    case onFire
//}
////异常分类处理
////do {
////    let printerResponse = try send(job: 1440, toPrinter: "Gutenberg")
////    print(printerResponse)
////} catch PrinterError.onFire {
////    print("I'll just put this over here, with the rest of the fire.")
////} catch let printerError as PrinterError {
////    print("Printer error: \(printerError).")
////} catch {
////    print(error)
////}
//
//
//let (code, errorMsg) = (404, "nicuole")
//
//print(code)
//print(errorMsg)
//
//let errorStatus = (code: 404, errMsg: "nicuole")
//print(errorStatus.code)
//print(errorStatus.errMsg)
//
//
//
//
//protocol Player{  // 定义协议
//    func play()
//}
//
//extension Player {
//    func play() {
//        print("默认实现")
//    }
//}
//
//func playMusicWithPlayer(player: Player){
//    player.play()
//}

//struct VideoPlayer: Player {
//
//}
//
//let player = VideoPlayer()
//
//playMusicWithPlayer(player: player)
//
//
////交叉
//func swap<T>(arr: inout [T], a: Int, b: Int) {
//    (arr[a], arr[b]) = (arr[b], arr[a])
//}
//
//
//var arr = [1, 2, 3, 4]
//swap(arr: &arr, a: 2, b: 3)
//
//
//func serve(customer customerProvider: () -> String) {
//    print(customerProvider())
//}
//
//
//serve(customer: {"haohao"})
//
//
//var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
//var customerProvider1: (() -> String)!
//func serve(customer customerProvider: @autoclosure @escaping() -> String) {
//    customerProvider1 = customerProvider
//    print (customerProvider())
//}
//serve(customer:  customersInLine.remove(at: 0))

/// 定义一个查询学生成绩的接口
///
///     let score =  getScoreStudentName(name: "酷走天涯", nums: "111111111")
///
/// - Parameters:
///     - name:  学生姓名
///     - nums:  学号
/// - Returns: 返回学生成绩
//func getScoreStudentName(name:String,nums:String)->Double{
//    return 0.0
//}


//struct num {
//    lazy var nums: String = "nihao"
//    var num2: String
//
//    var m: String {
//        get {
//            return self.num2
//        }
//    }
//    //访问lazy属性需要mutating
//    var n: String {
//        mutating get {
//            return self.nums
//        }
//    }
//
//    mutating func accessNums() {
//        print(self.nums)
//    }
//}
//
//
// MARK: - strong weak unowned
class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
    deinit {
        print("\(name)销毁了")
    }
}

/*
 1.强引用的对象,不会被释放
 2.weak 或者unowned 引用的对象,当没有强引用的时候,会被立即释放
 3.weak 修饰的变量和常量必须为可选类型,但是unowned刚好和其相反必须为非可选类型
 */
var p1: Person = Person(name: "小黑豆1号")

weak var p2: Person? = Person(name: "小黑2号")

weak var p3 = Person(name: "小黑3号")

//unowned var p4 = Person(name: "小黑4号")

class HTMLElement  {
    let name: String
    let text: String?

//    lazy var asHTML: () -> String = {
//        [weak self] in
//        if let text = self?.text {
//            return "<\(self?.name)>\(text)</\(self?.name)>"
//        } else {
//            return "<\(self?.name) />"
//        }
//    }

    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }

    init?(name: String, text: String) {
        self.name = name
        self.text = text
    }

    deinit {
        print("\(name) is being deinitialized")
    }
}

weak var x: HTMLElement? = HTMLElement(name: "title", text: "haha")
x?.asHTML()
x = nil






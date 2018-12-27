
import Foundation
import UIKit
import XCPlayground
var str = "Hello, playground"


//状态机
struct HTNTransition<S: Hashable, E: Hashable> {
    let event: E
    let fromState: S
    let toState: S
    
    init(event: E, fromState: S, toState: S) {
        self.event = event
        self.fromState = fromState
        self.toState = toState
    }
}


protocol HTNState {
    associatedtype StateType//关联类型
    func add(_ item: StateType)
}


//关联类型也能够享受泛型的好处
struct states<T>: HTNState {
    func add(_ item: T) {
        
    }
    
    
    
    //where 对泛型进行约束 要求他们的 StateType 具有相同类型
    func stateFilter<FromState:HTNState, ToState:HTNState>(_ from:FromState, _ to:ToState) where FromState.StateType == ToState.StateType {
        //...
    }
}


//泛型和 Any 类型
// 区别在于 Any 类型会避开类型的检查，所以尽量少用最好不用
func add<T>(_ input: T) -> T {
    //...
    return input;
}
func anyAdd(_ input: Any) -> Any {//入参和返回值可能不一样，失去控制
    //...
    return input;
}


//Mark: - 集合
//GeneratorType 协议 有个遍历的功能  用迭代器调 next 就可以得到全部元素
//Sequence协议 的多次遍历 如 forEach，elementsEqual，contains，minElement，maxElement，map，flatMap，filter，reduce 等功能
// Collection协议 因为 Sequence 无法确定集合里的位置而在 Sequence 的基础上实现了 Indexable 协议




//map 和 flatMap
//swift/stdlib/public/core/SequenceAlgorithms.swift.gyb
//element -> sequence
let numbers = [1, 2, 3, 4]
let mapped = numbers.map { Array(repeatElement($0, count: $0))}
// [[1], [2, 2], [3, 3, 3], [4, 4, 4, 4]]

let flatMapped = numbers.flatMap { Array(repeatElement($0, count: $0))}
// [1, 2, 2, 3, 3, 3, 4, 4, 4, 4]

//element -> element 则可以用来去除nil
let possibleNumbers = ["1", "2", "three", "///4///", "5"]

let mapped2: [Int?] = possibleNumbers.map { str in Int(str) }
// [1, 2, nil, nil, 5]

let flatMapped2: [Int] = possibleNumbers.flatMap { str in Int(str) }
// [1, 2, 5]



//弱引用的 Swift 数组
let strongArr = NSPointerArray.strongObjects()
let weeakArr = NSPointerArray.weakObjects()


let strongDict = NSMapTable<AnyObject, AnyObject>.strongToStrongObjects()
let weakDict = NSMapTable<AnyObject, AnyObject>.weakToStrongObjects()


let weakSet = NSHashTable<AnyObject>.weakObjects()




//消息派发

class canoverideClass {
    //1.final：让类里的函数使用直接派发
    //2.默认是函数表派发
    //3.dynamic 消息机制派发
    @objc dynamic func test() {}
}



//内存管理
MemoryLayout<Int>.size      //8
MemoryLayout<Int16>.size    //2
MemoryLayout<Bool>.size     //1
MemoryLayout<Float>.size    //4
MemoryLayout<Double>.size   //8

//////Struct 内存管理 编译器就确定了大小
//优化内存对齐，大对象写前面 ，小对象写后面
struct DragonFirePosition {
    var x:Int64 //8 Bytes
    var y:Int32 //4 Bytes
    //8 + 4
    func land() {}
}
MemoryLayout<DragonFirePosition>.size       //12
MemoryLayout<DragonFirePosition>.alignment  //8 按照 8 Bytes 来对齐的
MemoryLayout<DragonFirePosition>.stride     //16 实际占用大小 8 * 2


struct DragonFirePosition2 {
    var y:Int32 //4 Bytes + 对齐内存(4 Bytes)
    var x:Int64 //8 Bytes
    //4 + 4 + 8
    func land() {}
}
MemoryLayout<DragonFirePosition2>.size       //16
MemoryLayout<DragonFirePosition2>.alignment  //8 按照 8 Bytes 来对齐的
MemoryLayout<DragonFirePosition2>.stride     //16 实际占用大小 8 * 2



















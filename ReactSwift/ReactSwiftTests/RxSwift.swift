//
//  RxSwift.swift
//  ReactSwiftTests
//
//  Created by 韩承海 on 2017/11/28.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest


//https://github.com/ReactiveX/RxSwift/blob/f639ff450487340a18931a7dbe3d5c8a0976be7b/CHANGELOG.md
class RxSwift: XCTestCase {
    
    static let disposeBag = DisposeBag()
    
    /*
     Observable 可观察的信号源 事件源 管道pipe sequence 被观察者
     Observer 观察者，即订阅者
     Event 即事件 信号
     */
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    // MARK: - 创建一个空的序列。它仅发送 .Completed 消息
    func testEmpty() {
        /// empty
        example("empty") {
            let emptySequence = Observable<Int>.empty()
            emptySequence.subscribe { (event) in
                print(event)
                }.disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - never 创建一个序列，该序列永远不会发送消息，.Completed 消息也不会发送
    func testNever() {
        example("never") {
            let neverSequence = Observable<Int>.never()
            neverSequence.subscribe({ (_) in
                print("this block is never called.")
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - 代表只包含一个元素的序列。它将向订阅者发送两个消息，第一个消息是其中元素的值，另一个是 .Completed
    func testJust() {
        example("just") {
            let singleElement = Observable.just(32)
            singleElement.subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: -  通过固定数目的元素创建一个序列
    func testSequenceOf() {
        example("sequence") {
            let sequenceOfElements: Observable<Int> = Observable.of(0, 1, 2, 3, 4, 5, 6, 7,  8, 9)
            sequenceOfElements.subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - 在一个数组的基础上创建一个序列
    func testtoObservable() {
        example("Observable.from") {
            //toObservable 过期
            let sequenceFromArray = Observable.from([1, 2, 3, 4])
            sequenceFromArray.subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - create 使用 Swift 闭包来创建一个序列。该例子中，创建了 just 操作符的自定义版本
    func testCreate() {
        example("create") {
            let myJust = {(singleElement: Int) -> Observable<Int> in
                return Observable.create({ (observer) -> Disposable in
                    observer.on(.next(singleElement))
                    observer.onCompleted()
                    return Disposables.create()
                })
            }
            myJust(5).subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    
    // MARK: - generate 创建的序列可以自己生成它的值，并且在之前值的基础上来判断什么时候结束。
    func testGenerate() {
        example("generate") {
            let generated = Observable.generate(initialState: 0, condition: {
                $0 < 3
            }, iterate: { $0 + 1 })
            generated.subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - 创建一个不发送任何 item 的 Observable，以 error 终止
    func testError() {
        example("error") {
            let error = NSError.init(domain: "test", code: 999, userInfo: nil)
            let erroredSuquence = Observable<Int>.error(error)
            erroredSuquence.subscribe({ (event) in
                print(event)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    // MARK: - 直到 observer 订阅之后才创建 Observable，并且为每一个 observer 创建一个全新的 Observable
    func testDeferred() {
        example("deferred") {
            let deferredSequence: Observable<Int> = Observable.deferred({ () -> Observable<Int> in
                print("createing")
                return Observable.create({ (observer) -> Disposable in
                    print("emmiting")
                    observer.on(.next(0))
                    observer.on(.next(1))
                    observer.on(.next(2))
                    
                    return Disposables.create()
                })
            })
            
            _ = deferredSequence.subscribe({ (event) in
                print(event)
            })
            _ = deferredSequence.subscribe({ (event) in
                print(event)
            })
        }
    }
    
    
    // MARK: - PublishSubject 只会把在订阅发生的时间点之后来自原始Observable的数据发射给观察者
    func testPublishSubject() {
        example("PublishSubject") {
            let disposeBag = DisposeBag()
            let subject = PublishSubject<String>()
            writeSequenceToConsole(name: "1", sequence: subject).disposed(by: disposeBag)
            subject.on(.next("a"))
            subject.onNext("b")
            writeSequenceToConsole(name: "2", sequence: subject).disposed(by: disposeBag)
            subject.onNext("c")
            subject.onNext("d")
        }
    }
    
    func testReplaySubject() {
        example("replaySubject") {
            let disposeBag = DisposeBag()
            let subject = ReplaySubject<String>.create(bufferSize: 1)
            writeSequenceToConsole(name: "1", sequence: subject).disposed(by: disposeBag)
            subject.onNext("1")
            subject.onNext("2")
            writeSequenceToConsole(name: "2", sequence: subject)
            subject.onNext("3")
            subject.onNext("4")
        }
    }
    
    
    
    
    // MARK: - 当观察者订阅 BehaviorSubject 时，它开始发射原始 Observable 最近发射的数据（如果此时还没有收到任何数据，它会发射一个默认值），然后继续发射其它任何来自原始Observable的数据
    func testBehaviorSubject() {
        example("behaviorSubject") {
            let disposeBag = DisposeBag()
            
            let subject = BehaviorSubject<String>.init(value: "z")//默认值
            writeSequenceToConsole(name: "1", sequence: subject).disposed(by: disposeBag)
            subject.onNext("1")
            subject.onNext("2")
            writeSequenceToConsole(name: "2", sequence: subject).disposed(by: disposeBag)
            subject.onNext("3")
            subject.onNext("4")
            subject.onCompleted()
        }
    }
    
    
    // MARK: - Variable 封装了 BehaviorSubject。使用 variable 的好处是 variable 将不会显式的发送 Error 或者 Completed。在 deallocated 的时候，Variable 会自动的发送 complete 事件
    func testVariable() {
        example("variable") {
            let disposeBag = DisposeBag()
            let variable = Variable("z")
            writeSequenceToConsole(name: "1", sequence: variable.asObservable()).disposed(by: disposeBag)
            variable.value = "a"
            variable.value = "b"
            writeSequenceToConsole(name: "2", sequence: variable.asObservable()).disposed(by: disposeBag)
            variable.value = "c"
            variable.value = "d"
        }
    }
    
    
    /// 变换操作
    func testMap() {
        example("map") {
            let originalSequence = Observable<Int>.of(1, 2, 3)
            
            _ = originalSequence.map({ (i) -> Int in
                i * 2
            }).subscribe({ (e) in
                print(e)
            })
        }
    }
    
    
    // MARK: - 将每个 Obserable 发射的数据变换为 Observable 的集合，然后将其 “拍扁”（降维 flatten）成一个 Observable
    func testFlatMap() {
        example("flatMap") {
            let sequenceInt = Observable<Int>.of(1, 2, 3)
            
            let sequenceString = Observable<String>.of("A", "B", "C", "D", "E", "--")
            _ = sequenceInt.flatMap({ (i) -> Observable<String> in
                print("from sequenceInt \(i) ")
                return sequenceString
            }).subscribe({ (e) in
                print(e)
            })
        }
    }
    
    // MARK: - 对 Observable 发射的每一项数据应用一个函数，然后按顺序依次发射每一个值
    func testScan() {
        example("scan") {
            let sequenceToSum = Observable<Int>.of(0, 1, 2, 3, 4, 5)
            
            _ = sequenceToSum.scan(0, accumulator: { (acum, elem) -> Int in
                acum + elem
            })
                .subscribe({ (e) in
                    print(e)
                })
        }
    }
    
    
    // MARK: - 只发送 Observable 中通过特定测试的数据
    func testFilter() {
        example("filter") {
            let subscription = Observable.of(0, 1, 2, 3, 4, 5, 6, 7, 8, 9).filter({ (i) -> Bool in
                i > 5
            }).subscribe({ (e) in
                print(e)
            })
            subscription.disposed(by: RxSwift.disposeBag)
        }
    }
    
    
    // MARK: - 过滤掉连续重复的数据
    func testDistinctUntilChanged() {
        example("distinctUntilChanged") {
            let sequence = Observable.of(0, 1, 1, 2, 3, 4, 4, 5, 6, 7)
            sequence.distinctUntilChanged().subscribe({ (e) in
                print(e)
            }).disposed(by: RxSwift.disposeBag)
        }
    }
    
    
    // MARK: - 仅发送 Observable 的前 n 个数据项
    func testTake() {
        example("take") {
            let subscription = Observable<Int>.of(1, 2, 3, 4, 5, 6, 7)
                .take(3)
                .subscribe({ (e) in
                    print(e)
                })
            subscription.disposed(by: RxSwift.disposeBag)
        }
    }
    
    
    ///Combination 结合操作 将多个 Observable 结合成一个 Observable
    // MARK: - 在数据序列的开头增加一些数据
    func testStartWith() {
        example("startWith") {
            let subscription = Observable<Int>.of(4, 5, 6, 7, 8)
                .startWith(0, 1, 2, 3)
                .subscribe({ (e) in
                    print(e)
                })
            subscription.disposed(by: RxSwift.disposeBag)
        }
    }
    
    
    // MARK: - 当两个 Observables 中的任何一个发射了一个数据时，通过一个指定的函数组合每个Observable发射的最新数据（一共两个数据），然后发射这个函数的结果
    func testCombineLatest() {
//        example("combineLatest") {
//            let stringObj = PublishSubject<String>()
//            let intObj = PublishSubject<Int>()
//
//            _ = Observable.combineLatest(intObj, stringObj, resultSelector: {
//                "\($0) \($1)"
//            }).subscribe({ (e) in
//                print(e)
//            })
//
//            intObj.onNext(1)
//            stringObj.onNext("A")
//            stringObj.onNext("B")
//            intObj.onNext(2)
//        }
        
        
        example("combineLatest Array") {
            let intOb1 = Observable<Int>.just(2)
            let intOb2 = Observable<Int>.of(0, 1, 2, 3)
            let intOb3 = Observable<Int>.of(0, 1, 2, 3, 4)
            let arr: Array = [intOb1, intOb2, intOb3]
            Observable.combineLatest(arr, { (e) -> Int in
                let intArr = e
                return Int((intArr[0] + intArr[1]) * intArr[2])
            }).subscribe({ (e) in
                print(e)
            }).disposed(by: RxSwift.disposeBag)
        }
        
    }
    
    
    // MARK: - 将两个 Observable 序列合并为一个。每当 self 队列发射一个元素时，从第二个序列中取出最新的一个值。
    func testWithLatestFrom() {
        example("withLatestFrom") {
            let subjectA = PublishSubject<String>()
            let subjectB = PublishSubject<String>()
            
            subjectA.withLatestFrom(subjectB).subscribe { (data) in
                print(data)
            }
            
            subjectA.onNext("a1")
            subjectB.onNext("b1")
            subjectA.onNext("a2")
            subjectA.onNext("a3")
            subjectB.onNext("b2")
            subjectA.onNext("a4")
        }
    }
    
    
    
    // MARK: - 使用一个函数组合多个Observable发射的数据集合，然后再发射这个结果(从序列中依次取数据)
    func testZip() {
        example("zip") {
            let intObj = PublishSubject<String>()
            let intObj2 = PublishSubject<Int>()
            
            Observable.zip(intObj, intObj2, resultSelector: {
                "\($0) \($1)"
            }).subscribe({ (e) in
                print(e)
            })
            
            
            intObj.onNext("a")
            intObj2.on(.next(1))
            intObj.onNext("b")
            intObj.onNext("c")
            intObj2.onNext(2)
            intObj2.onNext(3)
        }
    }
    
    
    
    // MARK: - 合并多个 Observables 的组合成一个
    func testMerge() {
        
        example("merge ") {
            let subject1 = PublishSubject<Int>()
            let subject2 = PublishSubject<Int>()
            
            _ = Observable.of(subject1, subject2)
                .merge(maxConcurrent: 2)
                .subscribe {
                    print($0)
            }
            
            subject1.on(.next(20))
            subject1.on(.next(40))
            subject1.on(.next(60))
            subject2.on(.next(1))
            subject1.on(.next(80))
            subject1.on(.next(100))
            subject2.on(.next(1))
        }
    }
    
    // MARK: - 收到 Error 通知之后，转而发送一个没有错误的序列。
    func testCatchError() {
        let sequenceThatFails = PublishSubject<Int>()
        let recoverySequence = Observable.of(100, 200, 300, 400)
        
        sequenceThatFails.catchError { (error) -> Observable<Int> in
            return recoverySequence
            }.subscribe { (e) in
                print(e)
        }
        
        sequenceThatFails.onNext(1)
        sequenceThatFails.onNext(2)
        sequenceThatFails.onNext(3)
        sequenceThatFails.onNext(4)
        sequenceThatFails.onError(NSError.init(domain: "test", code: 0, userInfo: nil))
    }
    
    
    
    
    // MARK: - 合并两个或者以上的 Observable 的消息，并且这些消息的发送时间不会交叉。（队列先后顺序不会交叉）
    func testConcat() {
        example("concat") {
            
            
            
            
        }
    }
    
    
    // MARK: - reduce
    func testReduce() {
        example("reduce") {
            _ = Observable.of(0, 1, 2, 3, 4, 5, 6, 7, 8, 9)
                .reduce(0, accumulator: +)
                .subscribe {
                    print($0)
            }
        }
    }
    
    
    
    @discardableResult
    private func writeSequenceToConsole<O: ObservableType>(name: String, sequence: O) -> Disposable {
        return sequence.subscribe({ (e) in
            print("Subscription: \(name),event:\(e)")
        })
    }
    
    
    
    
    
    private func example(_ str: String, _ block:()->()){
        print("----\(str)example----")
        block()
        print("-------\(str)-------")
    }
}

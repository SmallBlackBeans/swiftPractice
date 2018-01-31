//
//  TodoSwiftTests.swift
//  TodoSwiftTests
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
enum E: Error {
    case demo
}
@testable import TodoSwift

class TodoSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        example(description: "test") {
            let disposeBag = DisposeBag()
            let queueA = PublishSubject<Any>()
            let queueB = PublishSubject<Any>()
            
            //            let sequence = Observable.concat([queueA.asObservable(),queueB.asObservable()])
            //            sequence.subscribe(onNext: {
            //                dump($0)
            //            }).disposed(by: disposeBag)
            
            
            
            //            let sequence1 = Observable.of(queueA.asObservable(),queueB.asObservable()).merge(maxConcurrent: 1)
            //            sequence1.subscribe(onNext: {
            //                dump($0)
            //            }, onError: {
            //                print($0)
            //            }, onCompleted: {
            //                print("Completed")
            //            },onDisposed:  {
            //                print("Disposed")
            //            }).addDisposableTo(disposeBag)
            //            queueA.onNext("A1")
            //            queueA.onNext("A2")
            //            queueB.onNext("B1")
            //            queueA.onCompleted()
            
            let sequence = Observable.zip([queueA.asObservable(),queueB.asObservable()])
            sequence.subscribe(onNext: {
                dump($0)
            }, onError: {
                print($0)
            }, onCompleted: {
                print("Completed")
            },onDisposed:  {
                print("Disposed")
            }).disposed(by:disposeBag)
            
            queueA.onNext("A1")
            queueA.onNext("A2")
            queueB.onNext("B1")
            queueA.onError(E.demo)
            queueB.onNext("B2")
        }
    }
    
    
    
    func testForm() {
        example(description: "表单提交") {
            let disposeBag = DisposeBag()
            let textfield = BehaviorSubject(value: "haha")
            let submitBtn = PublishSubject<Any>()
            
            submitBtn.withLatestFrom(textfield)
                .subscribe(onNext: {
                    dump($0)
                }).disposed(by: disposeBag)
            submitBtn.onNext("")
            textfield.onNext("boxue")
            submitBtn.onNext("")
        }
    }
    
    func testCodeToTest() {
        example(description: "提测过程") {
            let disposeBag = DisposeBag()
            let coding = PublishSubject<Any>()
            let testing = PublishSubject<Any>()
            let working = PublishSubject<Observable<Any>>()
            
            working.switchLatest()
                .subscribe(onNext: {
                    dump($0)
                }).disposed(by: disposeBag)
            
            working.onNext(coding)
            coding.onNext("version1")
            
            working.onNext(testing)
            testing.onNext("FAILED")
            
            working.onNext(coding)
            coding.onNext("version1")
            
            working.onNext(testing)
            testing.onNext("PASS")
            
        }
    }
    
    
    func testConnect() {
        example(description: "共享") {
            let interval = Observable<Int>.interval(1, scheduler: MainScheduler.instance).publish()
            
            _ = interval.subscribe(onNext: {
                print("subscriber 1: \($0)")
            })
            
            _ = interval.connect()
            
            delay(2, {
                _ = interval.subscribe(onNext: {
                    print("subscriber 2: \($0)")
                })
            })
            
            dispatchMain()
        }
    }
}



func example(description: String?,action:()->()) {
    print("======== example " + description! + "========");
    action()
}


func delay(_ delay: Double, _ closure: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
        closure()
    }
}


public func stamp() -> String {
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateFormat = "HH:mm:ss"
    let result = formatter.string(from: date)
    return result
}

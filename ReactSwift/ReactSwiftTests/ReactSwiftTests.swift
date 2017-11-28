//
//  ReactSwiftTests.swift
//  ReactSwiftTests
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import XCTest
import ReactiveSwift
import SwiftyJSON
import Result

enum error: Error {
    case netError
    case requestError
}

@testable import ReactSwift

class ReactSwiftTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
  
    func testReactive() {
        let (signal, observer) = Signal<String, NoError>.pipe()
        signal.map { (string) -> String in
                string.uppercased()
            }.observe { (next) in
                print(next)
        }
        observer.send(value: "a")
        observer.send(value: "b")
    }
    
    func testReduce() {
        let (signal, observer) = Signal<Int, NoError>.pipe()
        
        signal.reduce(1) {
            $0 * $1
            }.observe { (next) in
                print(next)
        }
        observer.send(value: 1)
        observer.send(value: 2)
        observer.send(value: 3)
        observer.sendCompleted()
    }
    
    func testCollect() {
        //collect操作可以将一个事件流的值聚合为一个单个的数组值，在输入流结束后发送
        let (signal, observer) = Signal<Int, NoError>.pipe()
        
        signal.collect().observe { (next) in
            print(next)
        }
        
        observer.send(value: 1)
        observer.send(value: 2)
        observer.send(value: 3)
        observer.sendCompleted()
    }
    
    
    

    
    
    
    
}

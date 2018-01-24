//
//  RxSwiftWhyUse.swift
//  ReactSwiftTests
//
//  Created by 韩承海 on 2018/1/23.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa


class User: NSObject {
    @objc var name: String?
}


class RxSwiftWhyUse: XCTestCase {
    
    let disposeBag = DisposeBag()
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    

}

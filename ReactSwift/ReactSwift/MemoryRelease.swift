//
//  MemoryRelease.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
class MTModel: NSObject {
    @objc dynamic var title: String
    init(_ title: String) {
        self.title = title
    }
}

class MemoryRelease: NSObject {
    
    
    func test() {
        let model = MTModel("nihao")
        Observable.just(model)
            .flatMap {
                $0.rx.observe(String.self, "title")
            }
            .takeUntil(rx.deallocated)
            .subscribe(onNext: { value in
                if let value = value {
                    print("title is \(value)")
                }
            }, onCompleted: {
                print("completed")
            }, onDisposed:  {
                print("disposed")
            })
        
        Disposables.create {
            
        }

        model
            .rx
            .deallocated
            .subscribe {
                print("dealloc")
        }
        
        model.title = "111"
        model.title = "w22"
    }
    
}

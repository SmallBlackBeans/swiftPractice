//
//  OperatorViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/24.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import SwiftyJSON

import Foundation
// MARK: - 操作符
class OperatorViewController: UIViewController {

    
    let disposeBag = DisposeBag()
    let firstSubject = PublishSubject<Any>()
    let secondSubject = PublishSubject<String>()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        

        
        
        ////zip 有一个错，序列接不再继续了，这就是要么都成功，负责就失败
        Observable.zip(firstSubject,secondSubject).subscribe(onNext: { (any, string) in
            print("any + string", any, string)
        }, onError: { (error) in
            print(error)
        }).disposed(by: disposeBag);
    }
    
    
    
    
    
    // MARK: - 调度 GCD
    let url: URL? = nil
    func gcd() {
        DispatchQueue.global(qos: .userInitiated).async {
            let data = try? Data(contentsOf: self.url!)
            DispatchQueue.main.async {
                
            }
        }
        
        
        let rxData: Observable<Data>? = nil
        rxData?
            //决定数据序列的构建函数在哪个 Scheduler 上运行
            .subscribeOn(ConcurrentDispatchQueueScheduler(qos: .userInitiated))
            //决定在哪个 Scheduler 监听这个数据序列
            .observeOn(MainScheduler.init())
            .subscribe(onNext: { (data) in
                
            })
            .disposed(by: disposeBag)
        
        
        
        
        
        
        
        // MARK: - retryWhen  5秒后重试 重试4次
        let rxJson: Observable<JSON>? = nil
        rxJson?
            .retryWhen { (rxError: Observable<Error>) -> Observable<Int> in
                return rxError.enumerated().flatMap({ (index, error) -> Observable<Int> in
                    guard index < 4 else {
                        return Observable.error(error)
                    }
                    return Observable.timer(5, scheduler: MainScheduler.instance)
                })
        }
            .subscribe(onNext: { (json) in
                
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
        
    }
    
    
    
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let random = arc4random() % 2
        if random == 1 {
            firstSubject.onError(NSError(domain: "", code: 404, userInfo: nil))
            secondSubject.onNext("s2")
        }else {
            firstSubject.onNext("f1")
            secondSubject.onNext("s2")
        }
    }
    
    
    
}

//
//  FunctionViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/23.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import Alamofire
import SwiftyJSON



enum DataError : Error {
    case cantParseJSON
    case formatError(json: Any)
}

private class Student: NSObject {
    
}




class FunctionViewController: UIViewController {
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var taps: Observable<Void>?
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "函数式编程 & 响应式编程 = 函数响应式编程"
        taps =  button.rx.tap.asObservable()
        taps?.subscribe(onNext: { (_) in
            print("haha")
        }).disposed(by: disposeBag)

        
        //数据绑定
        //可被监听的序列
        let image: Observable<UIImage> = Observable.just(UIImage.init())// 可以使网络加载也可以是同步设置
        //观察者
        image.bind(to: imageView.rx.image)
        
        
        
        
        
        
        
        //核心

        //Observable
        let temperature: Observable<Double> = Observable.create { (observer) -> Disposable in
            observer.onNext(0)
            observer.onNext(2)
            observer.onNext(5)
            observer.onNext(7)
            observer.onNext(9)
            observer.onCompleted()
            return Disposables.create()
        }
        
        temperature.subscribe(onNext: { (value) in
          print(value)
        }).disposed(by: disposeBag)
        
        
    }
    
    
    
    typealias JSON = Any
    
    let json: Observable<JSON> = Observable.create { (observer) -> Disposable in
        
        let task = URLSession.shared.dataTask(with: URL.init(string: "http:www.baidu.com")!) { (data, _, error) in
        
            guard error == nil else {
                observer.onError(error!)
                return
            }
            
            guard let data = data, let jsonObject = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves)
                else {
                    observer.onError(DataError.cantParseJSON)
                return
            }
            
            observer.onNext(jsonObject)
            observer.onCompleted()

        }
     
        task.resume()
        
        return Disposables.create {
            task.cancel()
        }
    }
    
    
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: <#T##((SingleEvent<[String : Any]>) -> ()) -> Disposable#>)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    


}

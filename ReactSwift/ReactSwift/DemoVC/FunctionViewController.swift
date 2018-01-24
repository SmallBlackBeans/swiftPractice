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
    
    @IBOutlet weak var usernameOutlet: UITextField!
    
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
        
        
        
        
        getRepo("ReactiveX/RxSwift")
            .subscribe(onSuccess: { (json) in
                print("json:",json)
            }) { (error) in
                print("Error:",error)
        }.disposed(by: disposeBag)
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
    
    
    // MARK: - 它要么只能发出一个元素，要么产生一个 error 事件
    func getRepo(_ repo: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create(subscribe: { (singleObserver) -> Disposable in
            let  url = URL.init(string: "http://api.github.com/repos/\(repo)")!
            
            let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, _, error) in
                if let error = error {
                    singleObserver(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableLeaves),
                    let result = json as? [String: Any] else {
                        singleObserver(SingleEvent<[String : Any]>.error(DataError.cantParseJSON))
                        return
                }
                singleObserver(SingleEvent<[String : Any]>.success(result))
            })
            task.resume()
            return Disposables.create()
        })
    }
    
    
    
    // MARK: - Drive  是一个精心准备的特征序列
    /*
     不会产生 error 事件
     一定在 MainScheduler 监听（主线程监听）
     共享状态变化
     */
    
    
    // MARK: - Observer 观察者
    func observer() {
        let tap = self.button.rx.tap//ControlEvent
        //观察者就是由后面的 onNext，onError，onCompleted的这些闭包构建出来的。
        //ControlEvent 专门用于描述 UI 控件所产生的事件，不会产生 error 事件
        tap.subscribe(onNext: { [weak self] in
    
            }, onCompleted: {

        })
        
        
        
        // MARK: - AnyObserver 任意观察者
        let url = URL(string: "http")!
        URLSession.shared.rx.data(request: URLRequest(url: url))
            .subscribe(onNext: { (data) in
                
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
        
        //等价于
        let observer: AnyObserver<Data> = AnyObserver { (event) in
            switch event {
            case .next(let data):
                print("data", data)
            case .error(let error):
                print("error", error)
            default:
                break
            }
        }
        URLSession.shared.rx.data(request: URLRequest(url: url))
        .subscribe(observer)
        .disposed(by: disposeBag)
        
        
        
        
        // MARK: - Binder 特征观察者
        /*
         不会处理错误事件
         确保绑定都是在给定 Scheduler 上执行（默认 MainScheduler）
         一旦产生错误事件，在调试环境下将执行 fatalError，在发布环境下将打印错误信息
         */
        
        let userNameValid = usernameOutlet.rx
            .text.orEmpty
            .map { (text) -> Bool in
                text.count >= minimalUsernameLength
            }.share(replay: 1, scope: .whileConnected)
        
        
        let binderObserver: Binder<Bool> = Binder(button) { (button, isHidden) in
            button.isHidden = isHidden
        }
        userNameValid.bind(to: binderObserver).disposed(by: disposeBag)
        //等价
        userNameValid.bind(to: button.rx.isEnabled)
            .disposed(by: disposeBag)
        
    }
    

}

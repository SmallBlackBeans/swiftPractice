//
//  SubjectViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/24.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa


struct Model {}

class SubjectViewController: UIViewController {
    
    //1.
    /*
     AsyncSubject 将在源 Observable 产生完成事件后，发出最后一个元素（仅仅只有最后一个元素），如果源 Observable 没有发出任何元素，只有一个完成事件。那 AsyncSubject 也只有一个完成事件。
     
     如果源 Observable 因为产生了一个 error 事件而中止， AsyncSubject 就不会发出任何元素，而是将这个 error 事件发送出来
     */
    let disposeBag = DisposeBag()
    let asyncSubject = AsyncSubject<String>().share()

    
    
    
    // MARK: - Variable
    /**
        如果我们声明的变量需要提供 Rx 支持，那就选用 Variable 这个类型 它不会产生 error 事件
        在 deinit 时，会发出一个 completed 事件
     */
    var model: Model? = nil {
        didSet {
            updateUI(with: model)
        }
    }
    
    
    func updateUI(with model: Model?) {
        
    }
    
    func getModel() -> Model? {
        return nil
    }
    
    
    
    var variableModel: Variable<Model?> = Variable(nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        model = getModel()
        
        variableModel.asObservable()
            .subscribe(onNext: { [weak self] (model) in
                self?.updateUI(with: model)
            })
            .disposed(by: disposeBag)
        
        variableModel.value = getModel()
 
    }
    // MARK: - ControlProperty
    /*
     ControlProperty 专门用于描述 UI 控件属性的，它具有以下特征：
     
     不会产生 error 事件
     一定在 MainScheduler 订阅（主线程订阅）
     一定在 MainScheduler 监听（主线程监听）
     共享状态变化
     */


    


}

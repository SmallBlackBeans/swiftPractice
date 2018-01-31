//
//  Todo+Alamofire.swift
//  TodoSwift
//
//  Created by 韩承海 on 2018/1/31.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Alamofire

enum GetTodoListError: Error {
    case cannotConvertServerResoonse
}

extension Todo {
    class func getList(from router: TodoRouter) -> Observable<[[String: Any]]> {
        return Observable.create { (observer) -> Disposable in
            let request = Alamofire.request(router)
                .responseJSON { (response) in
                    guard response.result.error == nil else {
                        observer.on (
                            .error(response.result.error!)
                        )
                        return
                    }
                    
                    guard let todos = response.value as? [[String: Any]] else {
                        observer.on(.error(GetTodoListError.cannotConvertServerResoonse))
                        return
                    }
                    
                    observer.onNext(todos)
                    observer.onCompleted()
            }
            return Disposables.create {
                request.cancel()
            }
        }
    }
}

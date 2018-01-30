//
//  PHPhotoLibrary+Rx.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import Foundation

import Photos

import RxSwift

extension PHPhotoLibrary {
    static var isAuthorized: Observable<Bool> {
        return Observable.create({ (observer) -> Disposable in
            DispatchQueue.main.async {
                if authorizationStatus() == .authorized {
                    observer.onNext(true)
                    observer.onCompleted()
                } else {
                    requestAuthorization {
                        observer.onNext($0 == .authorized)
                        observer.onCompleted()
                    }
                }
            }
            return Disposables.create()
        })
    }
}

//
//  BBExtension.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/24.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {
    public var isHidden: Binder<Bool> {
        return Binder(self.base) {view, isHidden in
            view.isHidden = isHidden
        }
    }
}

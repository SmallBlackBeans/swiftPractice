//
//  UIViewController+Alert.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import Foundation
import UIKit
extension UIViewController {
    func alert(title: String? = nil, message: String? = nil, callback: @escaping (() -> Void)) {
        let alert = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        alert .addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            callback()
        }))
    }
}

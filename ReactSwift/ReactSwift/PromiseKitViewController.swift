//
//  PromiseKitViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import PromiseKit
class PromiseKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        fetchData()
    }


    
    func fetchData() {
        Promise<Data> { (fulfill, reject) in
            URLSession.shared
                .dataTask(with: URL.init(string: "http://www.baidu.com")!, completionHandler: { (data, _, error) in
                    if let data = data {
                        fulfill(data)
                    } else if let error = error {
                        reject(error)
                    }
                })
            .resume()
        }
            .then { (data) in
                Promise<Any> { (fulfill, reject) in
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        fulfill(json)
                    } catch {
                        fulfill(error)
                    }
                }
        }
            .then { (json) in
                print(json)
        }
    }

}

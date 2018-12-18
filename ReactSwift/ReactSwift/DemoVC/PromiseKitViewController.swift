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
        Promise<Data> {result in
            URLSession.shared
                .dataTask(with: URL.init(string: "http://www.baidu.com")!, completionHandler: { (data, _, error) in
                    if let data = data {
                        result.fulfill(data)
                    } else if let error = error {
                        result.reject(error)
                    }
                })
                .resume()
            }
            .then { (data) in
                Promise<Any> { result in
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                        result.fulfill(json)
                    } catch {
                        result.fulfill(error)
                    }
                }
            }
            .then({ json -> Promise<Void>  in
                print(json)
                return Promise()
            })
    }

}

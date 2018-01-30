//
//  ViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import Foundation

import RxSwift
import RxCocoa
import RxOptional
import RxDataSources


class ViewController: UITableViewController {
    
    let items:[[String: String]] = [
        ["SearchViewController": "haha"],
        ["SimpleValidationViewController": "用户登录校验"],
        ["FunctionViewController": "函数响应式编程"],
        ["OperatorViewController": "操作符"],
        ["RxDataSourcesViewController": "dataSources"]
    ]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "测试"

        
    }
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView .dequeueReusableCell(withIdentifier: "cell")
        if cell == nil {
            cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        }
        cell?.textLabel?.text = self.items[indexPath.row].keys.first
        cell?.detailTextLabel?.text = self.items[indexPath.row].values.first
        return cell!
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let module = Bundle.main.infoDictionary!["CFBundleExecutable"] as! String
        let vc = (NSClassFromString(module + "." + self.items[indexPath.row].keys.first!) as! UIViewController.Type).init()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


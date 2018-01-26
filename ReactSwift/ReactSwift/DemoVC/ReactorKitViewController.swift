//
//  ReactorKitViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/26.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

//行为
enum Action {
    case query(String?)
    case loadNextPage
}

//状态变更 --> 驱动状态变化
enum Mutation {
    case setQuery(String?)
    case setRepos([String], nextPage: Int?)
    case setLoadingNextPage(Bool)
}

//状态 --> 更新UI
struct State {
    var query: String?
    var repos: [String] = []
    var nextPage: Int?
    var isLoadingNextPage: Bool = false
}




class ReactorKitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    //func mutate(action: Action) ->

}

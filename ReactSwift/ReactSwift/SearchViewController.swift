//
//  SearchViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


enum APIStatus {
    case empty
    case error(String)
    case result(json: String)
}



class SearchViewController: UIViewController {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

    
    func bindViewModel() {
        let searchResult = searchBar.rx.text.orEmpty.asDriver()
        .throttle(0.3)
        .distinctUntilChanged()
            .flatMapLatest { (query) -> Driver<APIStatus> in
                if query.isEmpty {
                    return Driver.just(APIStatus.empty)
                } else {
                    //网络请求
                    return Observable.just(APIStatus.result(json: "json")).asDriver(onErrorJustReturn: APIStatus.empty)
                }
        }
        
        let loadNextPageTrigger = self.tableView.rx.contentOffset
            .flatMap {_ in
                return self.tableView.isNearBottomEdge(edgeOffset: 20.0) ? Observable.just(()) : Observable.empty()
        }
    }
}


extension UIScrollView {
    func isNearBottomEdge(edgeOffset: CGFloat = 20.0) -> Bool {
        return self.contentOffset.y + self.frame.size.height + edgeOffset > self.contentSize.height
    }
}

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



struct Repository {
    let name: String? = ""
    let url: URL? = nil
}

class User: NSObject {
    @objc var name: String?
}


class UserInfo: NSObject {
    
}

class Teacher: NSObject {
    
}

struct Comment {
    let commentId: Int?
    let comment: String?
}


enum Api {
    static func token(username: String, password: String,
                      success: (String) -> Void,
                      failure: (Error) -> Void) {
    }
    
    static func userInfo(token: String,
                         success: (UserInfo) -> Void,
                         failure: (Error) -> Void) {
        
    }
    
    
    static func rx_token(username: String, password: String) -> Observable<String> {
        return Observable.empty()
    }
    
    static func rx_userInfo(token: String) -> Observable<UserInfo> {
        return Observable.empty()
    }
    
    
    static func teacher(teacherId: Int) -> Observable<Teacher> {
        return Observable.empty()
    }
    
    
    static func teachertComments(teacherId: Int) -> Observable<[Comment]> {
        return Observable.just([])
    }
    
    
    
    
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIColor.white
        // Do any additional setup after loading the view.
    }
    

    
    func searchGitHUb(query: String) -> Observable<[Repository]> {
        return Observable.just([])
    }
    
    
    
    func bindViewModel() {
        // MARK: - 通知
        NotificationCenter.default.rx.notification(.UIApplicationWillEnterForeground)
            .subscribe(onNext: { (notification) in
                
            }).disposed(by: disposeBag)
        
        
        
        // MARK: - KVO
        let user = User()

        user.rx.observe(String.self, #keyPath(User.name))
            .subscribe { (newValue) in
                
            }.disposed(by: disposeBag)
        
        
        
        // MARK: - 依赖
        Api.token(username: "hanxiaocu", password: "123456", success: { (token) in
            Api.userInfo(token: token, success: { (userInfo) in
                
            }, failure: { (error) in
                
            })
        }) { (error) in
            
        }
        
        Api.rx_token(username: "hanxiaocu", password: "123456")
            .flatMapLatest(Api.rx_userInfo)
            .subscribe(onNext: { (userInfo) in
                
            }, onError: { (error) in
                
            }).disposed(by: disposeBag)
        
        
        
        
        // MARK: - 并发任务
        let teacherId = 123456
        Observable.zip(
            Api.teacher(teacherId: teacherId),
            Api.teachertComments(teacherId: teacherId)
            ).subscribe(onNext: { (teacher, comments) in
                
            }, onError: { (error) in
                
            })
            .disposed(by: disposeBag)
        
        
        
        
        
        let searchResults = searchBar.rx.text.orEmpty
            .throttle(0.3, scheduler:  MainScheduler.instance)
            .distinctUntilChanged()
            .flatMapLatest { query -> Observable<[Repository]> in
                if query.isEmpty {
                    return .just([])
                } else {
                    //网络请求
                    return self.searchGitHUb(query: query)
                        .catchErrorJustReturn([])
                }
        }
        searchResults.bind(to: tableView.rx.items(cellIdentifier: "cell")) {
            (index, repository: Repository, cell) in
            cell.textLabel?.text  = repository.name
            cell.detailTextLabel?.text = repository.url?.absoluteString
            }.disposed(by: disposeBag)
        
        let originalSequence = Observable.of(Character("A"), Character("B"), Character("C"))
        _ = originalSequence
            .map { char in
                char.hashValue
            }
            .subscribe { print($0) }
        
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

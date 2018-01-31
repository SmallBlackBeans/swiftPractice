//
//  TodoListViewController.swift
//  TodoSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import UIKit
import RxSwift
import Alamofire

class TodoListViewController: UITableViewController {
    
    var todoList = [Todo]()
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        let todoId: Int? = nil
        
        Observable.of(todoId)//Observable
            .map {
                return TodoRouter.get($0)
            }
            .flatMap { router in//flatMap会把原序列中的每一个事件，变成一个新的Observable
                return Todo.getList(from: router)
            }
            .subscribe(onNext: { (todos: [[String: Any]]) in
                //使用Array的flatMap方法，去掉了数组中所有的nil
                self.todoList = todos.flatMap {
                    Todo.init(json: $0)
                }
                self.tableView.reloadData()
            }, onError: { (error) in
                print(error.localizedDescription)
            })
            .disposed(by: disposeBag)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.todoList.count
    }
    
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = self.todoList[indexPath.row].title
        return cell
    }
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
    
}

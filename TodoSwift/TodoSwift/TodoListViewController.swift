//
//  TodoListViewController.swift
//  TodoSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import UIKit
import Alamofire

class TodoListViewController: UITableViewController {
    
    var todoList = [Todo]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Alamofire.request(TodoRouter.get(nil))
            .responseJSON { (response) in
                guard response.result.error == nil  else {
                    print(response.result.error!)
                    return
                }
                
                guard let todos = response.result.value as? [[String: Any]] else {
                    print("Cannot read the Todo list from the server.")
                    return
                }
                todos.reversed().forEach {
                    guard let todo = Todo.init(json: $0) else {
                        return
                    }
                    self.todoList.append(todo)
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
        }
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

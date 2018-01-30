//
//  Todo.swift
//  TodoSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import Foundation


class Todo {
    var id: UInt?
    var title: String?
    var completed: Bool
    init(id: UInt, title: String, completed: Bool) {
        self.id = id
        self.title = title
        self.completed = completed
    }
    
    required convenience init?(json: [String: Any]) {
        guard let todoId = json["id"] as? UInt,
            let title = json["title"] as? String,
            let completed = json["completed"] as? Bool else {
                return nil
        }
        self.init(id: todoId, title: title, completed: completed)
    }
    
}



//方便调试
extension Todo: CustomStringConvertible {
    var description: String {
        return "ID: \(self.id ?? 0), " +
            "title: \(String(describing: self.title)), " +
        "completed: \(self.completed)"
    }
}

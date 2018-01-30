//
//  TodoRouter.swift
//  TodoSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import Foundation
import Alamofire
//用来路由所有到/todos的REST请求
enum TodoRouter {
    static let baseURL: String = "https://jsonplaceholder.typicode.com/"
    
    case get(Int?)//为nil时，表示要获取所有todo的列表；为Int时，表示要获取某一个具体的todo信息
    
    //case post([String: Any])
}


extension TodoRouter: URLRequestConvertible {
    func asURLRequest() throws -> URLRequest {
        var method: HTTPMethod {
            switch self {
            case .get:
                return .get
            }
        }
        
        var params: [String: Any]? {
            switch self {
            case .get:
                return nil
                ///TODO: add other http methods here
            }
        }
        
        var url: URL {
            var relativeUrl: String = "todos"
            switch self {
            case .get(let todoId):
                if todoId != nil {
                    relativeUrl = "todos/\(todoId!)"
                }
                /// TODO: Add other HTTP methods here
            }
            let url = URL.init(string: TodoRouter.baseURL)!.appendingPathComponent(relativeUrl)
            return url
        }
        
        
        var request = URLRequest.init(url: url)
        request.httpMethod = method.rawValue
        let encoding = JSONEncoding.default
        return  try encoding.encode(request, with: params)
    }
}

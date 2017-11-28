//
//  BBURLProtocol.swift
//  URLCache
//
//  Created by BlackBean on 2017/11/28.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit
import Foundation
//预防http劫持 可以使用https
//预防DNS劫持  把域名替换为ip访问
class BBURLProtocol: URLProtocol {
    
    private struct BBURLProtocolKey {
        var tagKey = "BBURLProtocolTagKey"
    }
    
    fileprivate var dataTask: URLSessionDataTask?
    fileprivate var urlResponse: URLResponse?
    fileprivate var receivedData: NSMutableData?
    
    
    // MARK: - URLProtocol 虚方法实现
    // MARK: - 是否处理响应的请求
    override class func canInit(with request: URLRequest) -> Bool {
        if URLProtocol.property(forKey: BBURLProtocol.PropertyKey.tagKey, in: request) != nil {
            return false
        }
        return true
    }
    

    //返回请求 在此方法中可以修改请求
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        var newRequest = request
        //实际需要服务器下发，或者本地存储一份 domain list
        let originHost = request.url?.host
        if "baidu.com" == originHost {
            let originURL = request.url?.absoluteString
            let newURL = originURL?.replacingOccurrences(of: originHost!, with: "ip-xxx.xxx.xxx.xx")
            newRequest.url = URL.init(string: newURL!)
        }
        return newRequest
    }
    
    
    // MARK: - 开始加载
    override func startLoading() {
        guard let newRequest = (request as NSURLRequest).mutableCopy() as? NSMutableURLRequest else { return }
        URLProtocol.setProperty(true, forKey: BBURLProtocol.PropertyKey.tagKey, in: newRequest)
        let sessionConfig = URLSessionConfiguration.default
        let urlSession = URLSession.init(configuration: sessionConfig, delegate: self, delegateQueue: nil)
        self.dataTask = urlSession.dataTask(with: self.request)
        self.dataTask?.resume()
    }
    
    // MARK: - 停止加载
    override func stopLoading() {
        self.dataTask?.cancel()
        self.dataTask = nil
        self.receivedData = nil
        self.urlResponse = nil
    }

    
    // MARK: - 判断两个请求是否相等，相等则考虑使用缓存，此方法不是必须实现
    override class func requestIsCacheEquivalent(_ a: URLRequest, to b: URLRequest) -> Bool {
        return super.requestIsCacheEquivalent(a, to: b)
    }
    
}

extension BBURLProtocol {
    struct PropertyKey {
        static var tagKey = "BBURLProtocolTagKey"
    }
}



// MARK: - 实际开发中应该尽可能处理所有的self.client?.urlProtocol 回传方法，避免客户端有些方法无法响应
extension BBURLProtocol: URLSessionTaskDelegate, URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        self.client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)
        self.urlResponse = response
        self.receivedData = NSMutableData()
        
        completionHandler(.allow)
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        self.client?.urlProtocol(self, didLoad: data)
        self.receivedData?.append(data)
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        if error != nil {
            self.client?.urlProtocol(self, didFailWithError: error!)
        }else {
            self.client?.urlProtocolDidFinishLoading(self)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

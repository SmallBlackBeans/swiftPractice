//
//  ViewController.swift
//  NSURLSession
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

let baidu = "http://baidu.com"


class ViewController: UIViewController {

    
    var activeDownLoads = [String: Download]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }


    
    lazy var defaultSession = URLSession.init(configuration: .default)
    var dataTask: URLSessionDataTask?
    
    func doTask() {
        guard let url = URL.init(string: "http://www.baidu.com") else {
            return
        }
        dataTask = defaultSession.dataTask(with: url)
        //只有调用下面语句才会开始请求
        dataTask?.resume()
    }
    
    //自定义配置
    func dataTask2() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 10
        configuration.requestCachePolicy = .useProtocolCachePolicy //缓存策略
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        
        let customSession = URLSession.init(configuration: configuration)
        var dataTask: URLSessionDataTask?
        
        guard let url = URL.init(string: "http://baidu.com") else {
            return
        }

        let request = NSMutableURLRequest.init(url: url)
        request.httpMethod = "GET"
        dataTask = customSession.dataTask(with: request  as URLRequest, completionHandler: { (data, response, error) in
            //操作数据
        })
        dataTask?.resume()

    }
    
    lazy var downloadSession: URLSession = {
        let configuration = URLSessionConfiguration.default
        //自动创建一个串行队列
        return URLSession.init(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    func dowload() {
        guard let url = URL.init(string: baidu) else { return }
        let downloadTask = downloadSession.downloadTask(with: url)
        downloadTask.resume()
    }
}


extension ViewController: URLSessionDownloadDelegate {
 
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("下载完成")
        if let originalUrl = downloadTask.originalRequest?.url?.absoluteString {
            let destinationUrl: URL! = URL.init(string: "haha")
            print("本地临时地址：\(destinationUrl)")
            let fileManager = FileManager.default
            do {
                try fileManager.removeItem(at: destinationUrl)
            } catch let error as NSError {
                print("error: \(error.localizedDescription)")
            }
            
            do {
                try fileManager.copyItem(at: location, to: destinationUrl)
            } catch {
                print("Error: \(error.localizedDescription)")
            }
        }
    }
    
    /// 监控下载进度
    ///
    /// - Parameters:
    ///   - session:
    ///   - downloadTask:
    ///   - bytesWritten:
    ///   - totalBytesWritten:
    ///   - totalBytesExpectedToWrite:
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        if let downloadUrl = downloadTask.originalRequest?.url?.absoluteString, var download = activeDownLoads[downloadUrl] {
            download.progress = Float(totalBytesWritten)/Float(totalBytesExpectedToWrite)
            let totalSize = ByteCountFormatter.string(fromByteCount: totalBytesExpectedToWrite, countStyle: .binary)
            
        }
    }
    
    
}


struct Download {
    var progress: Float?
}

















//
//  Controllers.swift
//  DragMacApp
//
//  Created by BBS on 2018/2/1.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import Cocoa
import Qiniu
import SwiftyJSON
import CryptoSwift

import PromiseKit

class DragUploadManager {
    static let share = DragUploadManager()
    private init() {}
    //https://developer.qiniu.com/kodo/manual/1208/upload-token
    func createQiniuToken(filename: String) -> String {
        let accessKey = "InfH3C262bywrAeDYs2145mmcZgrBrHEqLU3piJB"
        let secretKey = "w2ngjcYeM3cvYdNabEPKGV4-aedrQcGN_pm1-7-m"
        let bucket = "meihao-image"//存储空间
        
        //上传凭证需要的 deadline 参数
        let deadline = round(NSDate(timeIntervalSinceNow: 3600).timeIntervalSince1970)
        let putPolicyDict: JSON = [
            "scope": "\(bucket):\(filename)",
            "deadline": deadline
        ]
        
        //上传凭证构造第二步，用 Base64 编码数据
        let b64PutPolicy = QNUrlSafeBase64.encode(putPolicyDict.rawString()!)!
        
        //上传凭证第三步，用 secretKey 将上面 Base64 编码后的数据使用 HMAC sha1 算法加密
        let secretSign = try! HMAC(key: secretKey.utf8.map({$0}), variant: .sha1).authenticate(b64PutPolicy.utf8.map({$0}))
        
        //上传凭证第四步，将加密后的数据在用 Base64 编码
        let b64SecretSign = QNUrlSafeBase64.encode(Data.init(bytes: secretSign))!
        
        //最后，按照七牛的格式构造成上传凭证
        let putPolicy: String = [accessKey, b64SecretSign, b64PutPolicy].joined(separator: ":")
        return putPolicy
    }
    
    
    func uploadFile(filePath: String) -> Promise<String> {
        return Promise { fulfill, reject in
            let filename = NSURL.fileURL(withPath: filePath).lastPathComponent
            
            let token = createQiniuToken(filename: filename)
            let qiniu = QNUploadManager()
            qiniu?.putFile(filePath, key: filename, token: token, complete: { (info, key, resp) in
                switch info?.statusCode {
                case Int32(200)?:
                    print("upload success")
                    fulfill("upload success")
                default:
                    print("upload failed")
                    reject((info?.error)!)
                }
            }, option: nil)
            
        }
    }
    
    
    func uploadFiles(filePaths: Array<String>) {
        var uploadFiles: [Promise<String>] = []
        
        for path in filePaths {
            uploadFiles.append(uploadFile(filePath: path))
        }
        when(fulfilled: uploadFiles).then { (filenames) -> Void in
            print("all upload success")
            }.catch { (error) in
                print(error)
        }
    }
}

















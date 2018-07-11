//
//  Show.swift
//  YogaKitDemo
//
//  Created by BBS on 2018/7/11.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import Foundation


struct Show {
    let title: String
    let length: String
    let detail: String
    let image: String
}


extension Show {
    static func loadShows() -> [Show] {
        return loadMixersFrom("Shows")
    }

    static func loadMixersFrom(_ plistName: String) -> [Show] {
        guard
            let path = Bundle.main.path(forResource: plistName, ofType: "plist"),
            let dictArray = NSArray(contentsOfFile: path) as? [[String: AnyObject]]
            else {
                fatalError("reading \(plistName).plist Error")        }
        var shows: [Show] = [Show]()

        for dict in dictArray {
            guard
                let title = dict["title"] as? String,
                let length = dict["length"] as? String,
                let detail = dict["detail"] as? String,
                let image = dict["image"] as? String
                else {
                    fatalError("\(dict) 解析错误")
            }
            let show = Show(title: title, length: length, detail: detail, image: image)
            shows.append(show)
        }
        return shows
    }
}

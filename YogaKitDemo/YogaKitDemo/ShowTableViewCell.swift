//
//  ShowTableViewCell.swift
//  YogaKitDemo
//
//  Created by BBS on 2018/7/11.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import UIKit

class ShowTableViewCell: UITableViewCell {
    static let showCellIdentifier = "ShowTableViewCell"

    var show: Show! {
        didSet {
            self.textLabel?.text = show.title
            self.detailTextLabel?.text = show.length
            self.imageView?.image = UIImage.init(named: show.image)
        }
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont.systemFont(ofSize: 14.0)
        self.textLabel?.numberOfLines = 2
        self.textLabel?.adjustsFontSizeToFitWidth = true
        self.textLabel?.minimumScaleFactor = 0.8
        self.detailTextLabel?.textColor = UIColor.lightGray
        let accessoryView: UIImageView = UIImageView.init(frame: CGRect.init(x: 0, y: 0, width: 25, height: 25))
        accessoryView.image = UIImage.init(named: "download")
        self.accessoryView = accessoryView;
        self.backgroundColor = .clear
        self.separatorInset = .zero
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }


}

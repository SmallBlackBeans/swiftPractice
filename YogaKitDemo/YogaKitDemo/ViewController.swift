//
//  ViewController.swift
//  YogaKitDemo
//
//  Created by BBS on 2018/7/11.
//  Copyright © 2018年 韩小醋. All rights reserved.
//  简书:       https://www.jianshu.com/u/40e1253a9808
//  Macros:    https://help.apple.com/xcode/mac/9.0/index.html?localePath=en.lproj#/dev7fe737ce0
//  Github地址: https://github.com/SmallBlackBeans
//

import UIKit
import YogaKit

class ViewController: UIViewController {

    private let paddingHorizontal: YGValue = 8.0
    private let padding: YGValue = 8.0
    private let backgroundColor: UIColor = .black

    fileprivate var  shows = [Show]()

      
    /// 容器
    fileprivate let contentView: UIScrollView = UIScrollView.init(frame: .zero)

    private let showPopilarity = 5
    private let showYear = "2018"
    private let showRating = "TV-14"
    private let showLength = "3 Series"
    private let showCast = "hanxiaocu black beans small"
    private let showCreators = "韩承海"

    private let showSelectedIndex = 2
    private let selectedShowSeriesLabel = "S3:E3"

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        var contentViewRect: CGRect = .zero
        for view in contentView.subviews {
            contentViewRect = contentViewRect.union(view.frame)
        }
        contentView.contentSize = contentViewRect.size
    }



    fileprivate func initSubViews() {
        contentView.backgroundColor = backgroundColor
        contentView.configureLayout { (layout) in //默认是纵向排列 符合scrollView  排列
            layout.isEnabled = true
            layout.height = YGValue(self.view.bounds.size.height)
            layout.width = YGValue(self.view.bounds.size.width)
            layout.justifyContent = .flexStart //
        }
        view.addSubview(contentView)
        contentView.yoga.applyLayout(preservingOrigin: true)//保留原始约束
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        shows = Show.loadShows()

        initSubViews()
    }

}


private extension ViewController {
    func ShowLableFor(text: String,
                      font: UIFont = UIFont.systemFont(ofSize: 14.0)) -> UILabel {
        let label = UILabel.init(frame: .zero)
        label.font = font
        label.textColor = .lightGray
        label.text = text
        label.configureLayout { (layout) in
            layout.isEnabled = true
            layout.marginBottom = 5.0
        }
        return label
    }
}


extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShowTableViewCell = tableView.dequeueReusableCell(withIdentifier: ShowTableViewCell.showCellIdentifier, for: indexPath) as! ShowTableViewCell
        cell.show = shows[indexPath.row]
        return cell
    }
}


extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("select row \(indexPath.row)")
    }

}

























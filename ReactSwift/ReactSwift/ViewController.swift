//
//  ViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

class ViewController: UITableViewController {
    
    var dataArray = Observable.just([1, 2, 3, 4, 5, 6, 7, 8, 9])
    let disposeBag = DisposeBag()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    
    private func setUpTableView() {
        dataArray.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "cellId", cellType: UITableViewCell.self)) {
                    (row, element, cell) in
                    cell.textLabel?.text = "\(element) row \(row)"
            }.disposed(by: disposeBag)
    }
    
    
    
    private func setUpCellAction() {
        tableView.rx.modelSelected(Int.self).subscribe(onNext: { (i) in
            
        }, onError: { (err) in
            
        }, onCompleted: {
            
        }) {
            
            }.disposed(by: disposeBag)
        
    }
    
    
    private func setupArrayObservver() {
        dataArray.asObservable().subscribe(onNext: { (i) in
            
        }).disposed(by: disposeBag)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}


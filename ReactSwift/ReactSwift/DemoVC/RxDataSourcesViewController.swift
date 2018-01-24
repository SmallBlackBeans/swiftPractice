//
//  RxDataSourcesViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/24.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources


class RxDataSourcesViewController: UITableViewController {
    let disposeBag = DisposeBag()
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String, Double>>.init(configureCell: { (_, tb, ip, item) -> UITableViewCell in
        let cell = tb.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = "\(item) @ row \(ip.row)"
        return cell
    }, titleForHeaderInSection: { (dataSource, sectionIndex) in
        return dataSource[sectionIndex].model
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataSource = self.dataSource
        
        
        let items = Observable.just([
            SectionModel(model: "first section", items: [
                1.0, 2.0, 3.0
                ]),
            SectionModel(model: "second section", items: [
                1.0, 2.0, 3.0
                ]),
            SectionModel(model: "third section", items: [
                1.0, 2.0, 3.0
                ])
            ])
        
        
        items
            .bind(to: tableView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.asObservable()
            .map { (indexPath)  in
                return (indexPath, dataSource[indexPath])
            }
            .subscribe(onNext: { (tuple) in
                print("selected \(tuple.0) \(tuple.1)")
            }).disposed(by: disposeBag)
        
        
    
    }
    
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
}

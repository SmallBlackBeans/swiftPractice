//
//  ViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2017/11/24.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit
import Foundation

import RxSwift
import RxCocoa
import RxOptional
import RxDataSources




public enum TScheduler {
    case main
    case serial(DispatchQoS)
    case concurrent(DispatchQoS)
    case operation(OperationQueue)
    
    
    public func schedule() -> ImmediateSchedulerType {
        switch self {
        case .main:
            return MainScheduler.instance
        case .serial(let Qos):
            return SerialDispatchQueueScheduler.init(qos: Qos)
        case .concurrent(let Qos):
            return ConcurrentDispatchQueueScheduler.init(qos: Qos)
        case .operation(let queue):
            return OperationQueueScheduler(operationQueue: queue)
        }
        
    }
}


extension ObservableType {
    //@warn_unused_result(message="http://git.io/rxs.uo") 默认
    @discardableResult
    public func observeOn(schedule: TScheduler) -> Observable<Self.E> {
        return observeOn(schedule.schedule())
    }
}



//MARK: - safe
public struct SafeCollection<Base: Collection> {
    private var _base: Base
    public init(_ base: Base) {
        _base = base
    }
    
    
    private func distance(from startIndex: Base.Index) -> Base.IndexDistance {
        return _base.distance(from: startIndex, to: _base.endIndex)
    }
    
    
    private func distance(to endIndex: Base.Index) -> Base.IndexDistance {
        return _base.distance(from: _base.startIndex, to: endIndex)
    }
    
    public subscript(index: Base.Index) -> Base.Iterator.Element? {
        if distance(to: index) >= 0 && distance(from: index) >= 0 {
            return _base[index]
        }
        return nil
    }
    
    public subscript(bounds: Range<Base.Index>) -> Base.SubSequence? {
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) >= 0 {
            return _base[bounds]
        }
        return nil
    }
    
    public subscript(bounds: ClosedRange<Base.Index>) -> Base.SubSequence? {
        if distance(to: bounds.lowerBound) >= 0 && distance(from: bounds.upperBound) > 0 {
            return _base[bounds]
        }
        return nil
    }
}

public extension Collection {
    var safe: SafeCollection<Self> {
        return SafeCollection(self)
    }
}


protocol Reusable: class {//这个协议只能用在class
    static var nib: UINib? { get }
    static var reuseIdentifier: String { get }
}

extension Reusable {
    static var reuseIdentifier: String {
        //使用类名作为标识符
        return String(describing: Self.self)
    }
    static var nib: UINib? { return nil }
}


//Swift 的类型在编译时刻就确定了
extension UITableView {
    func registerReusableCell<T:UITableViewCell>(_ : T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    func dequeueReusable<T: UITableViewCell>(indexPath: IndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as! T
    }
    
    func registerReusableHeaderFooterView<T: UITableViewHeaderFooterView>(_: T.Type) where T: Reusable{
        if let nib = T.nib {
            self.register(nib, forCellReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellReuseIdentifier: T.reuseIdentifier)
        }
    }
    
    
    func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>() -> T? where T: Reusable{
        return self.dequeueReusableHeaderFooterView(withIdentifier: T.reuseIdentifier) as? T
    }
}
extension UICollectionView {
    func registerReusableCell<T: UICollectionViewCell>(_: T.Type) where T: Reusable {
        if let nib = T.nib {
            self.register(nib, forCellWithReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forCellWithReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableCell<T: UICollectionViewCell>(indexPath: NSIndexPath) -> T where T: Reusable {
        return self.dequeueReusableCell(withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
    func registerReusableSupplementaryView<T: Reusable>(elementKind: String, _: T.Type) {
        if let nib = T.nib {
            self.register(nib, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        } else {
            self.register(T.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: T.reuseIdentifier)
        }
    }
    func dequeueReusableSupplementaryView<T: UICollectionViewCell>(elementKind: String, indexPath: NSIndexPath) -> T where T: Reusable {
        return self.dequeueReusableSupplementaryView(ofKind: elementKind, withReuseIdentifier: T.reuseIdentifier, for: indexPath as IndexPath) as! T
    }
}




public struct BB<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

public extension NSObjectProtocol {
    public var bb: BB<Self> {
        return BB(self)
    }
}

extension BB where Base: UIView {
    
}






class ViewController: UITableViewController {
    var bView: UIView?
    
    
    let array = [String]()
    
    
    
    var dataArray = Observable.just([1, 2, 3, 4, 5, 6, 7, 8, 9])
    let disposeBag = DisposeBag()
    
    let button = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
        array.lazy.map {
            return $0 + "nihao"
        }
        
        bView?.bb.base.frame = CGRect()
    }
    
    
    func bind() {
        tableView.rx.contentOffset.map{
            $0.y
            }.subscribe { [unowned self] in
                self.title = "contentOffset.x = \($0)"
            }.disposed(by: disposeBag)
        
        //按钮点击
        button.addTarget(self, action: "tapButton", for: .touchUpInside)
        button.rx.tap.subscribe {
            print("tap")
            }.disposed(by: disposeBag)
    }
    
    
    private func setUpTableView() {
        
        dataArray.asObservable()
            .bind(to: tableView
                .rx
                .items(cellIdentifier: "cellId", cellType: UITableViewCell.self)) {
                    (row, element, cell) in
                    cell.textLabel?.text = "\(element) row \(row)"
            }.disposed(by: disposeBag)
        
        
        tableView.rx.itemSelected.subscribe { indexPath in
            
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


//
//  PhotoCollectionViewController.swift
//  ReactSwift
//
//  Created by 韩承海 on 2018/1/30.
//  Copyright © 2018年 韩承海. All rights reserved.
//

import UIKit
import Photos
import RxSwift
private let reuseIdentifier = "Cell"

class PhotoCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        var disposebag = DisposeBag()
        // Register cell classes
        self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        
        let isAuthorized = PHPhotoLibrary.isAuthorized
        
        //授权成功的情况
        isAuthorized
            .skipWhile { $0 == false }
            .take(1)
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: {
                [weak self] _ in
                if let `self` = self {
                    self.collectionView?.reloadData()
                }
            })
            .disposed(by: disposebag)
        
        //失败情况
        isAuthorized
            .distinctUntilChanged()
            .takeLast(1)
            .filter { $0 == false }
            .subscribe({
                [weak self] _ in
                self?.alert(title: "Cannot access your photo library",
                            message: "You can authrize access from the settring",
                            callback: { [weak self]  in
                                self?.navigationController?.popViewController(animated: true)
                })
            })
            .disposed(by: disposebag)
    }
    
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        
        // Configure the cell
        
        return cell
    }
    
    
}

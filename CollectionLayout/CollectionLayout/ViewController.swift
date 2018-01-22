//
//  ViewController.swift
//  CollectionLayout
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cell")
    }
    
    func selectedCell() -> CollectionViewCell? {
        if let indexPath = collectionView?.indexPathForItem(at: CGPoint(x: (collectionView?.contentOffset.x)! + (collectionView?.bounds.width)! / 2, y: (collectionView?.bounds.height)! / 2)) {
            if let cell = collectionView?.cellForItem(at: indexPath) as? CollectionViewCell {
                return cell
            }
        }
        return nil
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}


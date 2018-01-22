//
//  CollectionViewCell.swift
//  CollectionLayout
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.brown
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

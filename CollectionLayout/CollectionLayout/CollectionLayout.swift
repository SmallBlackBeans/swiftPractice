//
//  CollectionLayout.swift
//  CollectionLayout
//
//  Created by 韩承海 on 2018/1/22.
//  Copyright © 2018年 韩小醋. All rights reserved.
//

import UIKit
private let pageWidth: CGFloat = 320.0
private let pageHeight: CGFloat = 568.0
class CollectionLayout: UICollectionViewFlowLayout {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        scrollDirection = .horizontal
        itemSize = CGSize(width: pageWidth, height: pageHeight)
        minimumLineSpacing = 10
    }
    
    
    // MARK: - 在处理每个 cell 的布局信息前，预先处理一些布局的计算
    override func prepare() {
        super.prepare()
        
        collectionView?.decelerationRate = UIScrollViewDecelerationRateFast
        
        collectionView?.contentInset = UIEdgeInsets(top: 0,
                                                    left: (collectionView?.bounds.width)! * 0.5 - pageWidth * 0.5,
                                                    bottom: 0,
                                                    right: (collectionView?.bounds.width)! * 0.5 - pageWidth * 0.5)
        
    }
    
    
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        //调用父类的layoutAttributesForElementsInRect获取每个 cell 的默认布局属性的数组。
        let array = super.layoutAttributesForElements(in: rect)

        //遍历数组中的每个属性特征
        for attributes in array! {
            let frame = attributes.frame
            let distance = abs((collectionView?.contentOffset.x)! + (collectionView?.contentInset.left)! - frame.origin.x)
            let scale = 0.7 * min(max(1 - distance / (collectionView?.bounds.width)!, 0.75), 1)
            attributes.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        return array
    }
    
    
    //强迫每次集合视图的视图范围的改变时，都去重新计算每个 cell 的布局属性
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    
    //用手指滑动一下，书的封面所预期停止的位置
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        var newOffset = CGPoint()
        
        var layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        
        var width = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = proposedContentOffset.x + (collectionView?.contentInset.left)!
        
        if velocity.x > 0 {//说明用户是在向右滑动
            offset = width * ceil(offset / width)
        }else if velocity.x == 0 {
            offset = width * round(offset / width)
        }else if velocity.x < 0 {
            offset = width * floor(offset / width)
        }
        
        newOffset.x = offset - (collectionView?.contentInset.left)!
        newOffset.y = proposedContentOffset.y
        return newOffset
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

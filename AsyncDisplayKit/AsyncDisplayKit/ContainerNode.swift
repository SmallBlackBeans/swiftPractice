//
//  ContainerNode.swift
//  AsyncDisplayKit
//
//  Created by 韩承海 on 2017/12/21.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class ContainerNode: ASDisplayNode {
    let nodeA = ASDisplayNode()
    let nodeB = ASDisplayNode()
    override init() {
        super.init()
        addSubnode(nodeA)
        addSubnode(nodeB)
    }
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let spacer1 = ASLayoutSpec()
        let spacer2 = ASLayoutSpec()
        let spacer3 = ASLayoutSpec()
        spacer1.stlye.flexGrow = 2
        spacer2.stlye.width = ASDimensionMake(100)
        spacer3.stlye.flexGrow = 1
        
        return ASStackLayoutSpec(direction: .horizontal, spacing: 0, justifyContent: .start, alignItems: .start, children: [spacer1, nodeA,spacer2, nodeB, spacer3])
    }
}

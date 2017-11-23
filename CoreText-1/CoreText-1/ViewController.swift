//
//  ViewController.swift
//  CoreText
//
//  Created by 韩承海 on 2017/11/22.
//  Copyright © 2017年 韩承海. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    private let Width = UIScreen.main.bounds.size.width
    private let Height = UIScreen.main.bounds.size.height
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //initUI()
        //view.addSubview(ctView)
        //view.addSubview(picText)
        view.addSubview(linkView)
    }
    
    lazy var linkView: CTLinkView = {
        let ctLinkView = CTLinkView()
        ctLinkView.frame = CGRect.init(x: 10, y: 10, width: SCREEN_WIDTH, height: 400)
        ctLinkView.backgroundColor = UIColor.gray
        let mutableAttrStr = NSMutableAttributedString(string: ctLinkView.str)
        let size = ctLinkView.sizeForText(mutableAttrStr)
        ctLinkView.frame.size = size
        return ctLinkView
    }()
    
    lazy var picText: CTPicTxtView  = {
        let pic = CTPicTxtView()
        pic.frame = CGRect.init(x: 0, y: 300, width: self.view.bounds.size.width, height: 400)
        pic.backgroundColor = UIColor.white
        return pic
    }()
    
     lazy var ctView: CTView = {
        let ct = CTView()
        ct.frame = CGRect.init(x: 10, y: 400, width: self.view.bounds.size.width, height: 200)
        ct.backgroundColor = UIColor.white
        return ct
    }()
    
    func initUI() {
        /*
         NSLigatureAttributeName 连体属性
         NSKernAttributeName 字间距
         NSStrikethroughStyleAttributeName 删除线
         NSStrikethroughColorAttributeName 删除线颜色
         NSUnderlineStyleAttributeName 下划线
         NSUnderlineColorAttributeName
         NSStrokeWidthAttributeName 笔画宽度 负值填充效果，正值中空效果
         NSShadowAttributeName 阴影效果
         NSObliquenessAttributeName 倾斜度
         NSExpansionAttributeName 横向拉伸 正值拉伸
         NSWritingDirectionAttributeName 书写方向
         NSVerticalGlyphFormAttributeName 排版方向
         NSLinkAttributeName 链接
         NSAttachmentAttributeName 图文混排
         NSParagraphStyleAttributeName 段落排版 NSParagraphStyle
         */
        let shadow = NSShadow()
        shadow.shadowOffset = CGSize(width: 2, height: 2)
        shadow.shadowBlurRadius = 8.0
        shadow.shadowColor = UIColor.gray
        let str = "这是一段用来测试的字符串， this is a string for test"
        let dic  = [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 50),
                    NSAttributedStringKey.foregroundColor: UIColor.red,
                    NSAttributedStringKey.verticalGlyphForm: 1] as [NSAttributedStringKey : Any]
        let attr = NSMutableAttributedString.init(string: str)
        attr.addAttributes(dic, range: NSMakeRange(0, 2))
        attr.addAttributes([NSAttributedStringKey.font: UIFont.systemFont(ofSize: 80),
                            NSAttributedStringKey.underlineStyle: 1,
                            //NSAttributedStringKey.backgroundColor: UIColor.green,
            NSAttributedStringKey.shadow:shadow,
            NSAttributedStringKey.obliqueness: 0.5,
            //NSAttributedStringKey.writingDirection:UITextWritingDirection.leftToRight,
            NSAttributedStringKey.link: 1,
            NSAttributedStringKey.strokeWidth: 2], range: NSMakeRange(2, 8))
        
        label.attributedText = attr
    }
    
    
    
    
    
    ///  CoreText 直接和 Quartz (Core Graphics)来交互
    func coretext() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}


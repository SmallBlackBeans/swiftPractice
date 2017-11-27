//
//  ImageTextView.swift
//  Swift3-4
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

@IBDesignable open class ImageTextView: UIView {
    fileprivate let imageView = UIImageView.convenienceInit()
    fileprivate lazy var textLable = UILabel()
    @IBInspectable
    open var textSize: UInt = 17 {//储存属性
        didSet {
            textLable.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        #if !TARGET_INTERFACE_BUILDER
            translatesAutoresizingMaskIntoConstraints = false
        #endif
        prepareView()
    }
    
    
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        prepareView()
    }
    
    
    open override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 3.0
    }
    
    
    // MARK: - 布局
    func prepareView() {
        textLable.translatesAutoresizingMaskIntoConstraints = false
        textLable.font = UIFont.systemFont(ofSize: CGFloat(textSize))
        
        addSubview(textLable)
        addSubview(imageView)
        
        //抗压缩
        imageView.setContentCompressionResistancePriority(UILayoutPriority.defaultHigh, for: UILayoutConstraintAxis.horizontal)
        //iOS9 后支持的
        NSLayoutConstraint.activate([
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 10),
            imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLable.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 2),
            textLable.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLable.rightAnchor.constraint(equalTo: rightAnchor, constant: -10)
            ])
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5
        layer.cornerRadius = 3
    }
    
}


extension ImageTextView {
    
    @IBInspectable
    open var image: UIImage? { //extension 可以添加计算属性
        get {
            return imageView.image
        }
        set {
            imageView.image = newValue
        }
    }
    
    @IBInspectable
    open var text: String? {
        get {
            return textLable.text
        }
        set {
            textLable.text = newValue
        }
    }
    
    @IBInspectable
    open var textColor: UIColor? {
        get {
            return textLable.textColor
        }
        set {
            textLable.textColor = newValue
        }
    }
}


extension UIImageView {
    class func convenienceInit() -> UIImageView {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }
}


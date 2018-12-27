import UIKit
import XCPlayground
//: [To CAGradientLayer](CAGradientLayer)
/*
 #if os(iOS)
 import UIKit
 #else
 import Cocoa
 #endif
 
 // UIKit/Cocoa Classes
 #if os(OSX)
 public typealias View = NSView
 public typealias Font = NSFont
 public typealias Color = NSColor
 public typealias Image = NSImage
 public typealias BezierPath = NSBezierPath
 public typealias ViewController = NSViewController
 #else
 public typealias View = UIView
 public typealias Font = UIFont
 public typealias Color = UIColor
 public typealias Image = UIImage
 public typealias BezierPath = UIBezierPath
 public typealias ViewController = UIViewController
 #endif
 */

class myVc: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let mySwitch: UISwitch = {
            view.addSubview($0)
            return $0
        }(UISwitch())
       mySwitch.isOn = true
    }
    
    
}


/// Center view in superview
public func CenterViewInSuperview(view: UIView, horizontal: Bool, vertical: Bool) {
    view.translatesAutoresizingMaskIntoConstraints = false
    var c: NSLayoutConstraint
    if vertical {
        c = NSLayoutConstraint(item: view, attribute: .centerY, relatedBy: .equal, toItem: view.superview, attribute: .centerY, multiplier: 1.0, constant: 0.0)
        c.isActive = true
    }
    
    if horizontal {
        c = NSLayoutConstraint(item: view, attribute: .centerX, relatedBy: .equal, toItem: view.superview, attribute: .centerX, multiplier: 1.0, constant: 0.0)
        c.isActive = true
    }
}

import UIKit
import XCPlayground
//: # CAGradientLayer
var gradientLayer : CAGradientLayer!

var view = UIView(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
view.backgroundColor = UIColor.white
gradientLayer = CAGradientLayer()
gradientLayer.colors = [UIColor.red.cgColor,UIColor.gray.cgColor,UIColor.yellow.cgColor];
gradientLayer.frame  = view.bounds
view.layer .addSublayer(gradientLayer)
view

var colorSet = [[CGColor]]()
var currentColorSet: Int!

colorSet.append([UIColor.red.cgColor, UIColor.yellow.cgColor])
colorSet.append([UIColor.magenta.cgColor, UIColor.green.cgColor])
colorSet.append([UIColor.gray.cgColor, UIColor.lightGray.cgColor])
currentColorSet = 0

gradientLayer.colors = colorSet[0]
view
gradientLayer.colors = colorSet[1]
view
gradientLayer.colors = colorSet[1]
view


let colorChangeAnimation = CABasicAnimation(keyPath: "colors")
colorChangeAnimation.duration = 2.0
colorChangeAnimation.toValue = colorSet[currentColorSet]
colorChangeAnimation.fillMode = kCAFillModeForwards
colorChangeAnimation.isRemovedOnCompletion = false
gradientLayer.add(colorChangeAnimation, forKey: "colorChange")
view












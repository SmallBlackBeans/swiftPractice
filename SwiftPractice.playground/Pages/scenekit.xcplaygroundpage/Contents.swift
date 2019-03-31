//: [Previous](@previous)

import UIKit
import Foundation
import SceneKit
import PlaygroundSupport
import XCPlayground

import SpriteKit

for i in 0...10 {
     i * i
}


var fibonacci = 0
var temp1 = 1
var temp2 = 0

print(fibonacci)
for j in 0...10 {
    temp2 = fibonacci
    fibonacci += temp1
    temp1 = temp2
    print(fibonacci)
}

let view = UIView.init(frame: CGRect(x: 0, y: 0, width: 200, height: 300))
view.backgroundColor = UIColor.green
let scnView = SCNView(frame: view.bounds);
scnView.scene = SCNScene()
view.addSubview(scnView);

PlaygroundPage.current.liveView = view


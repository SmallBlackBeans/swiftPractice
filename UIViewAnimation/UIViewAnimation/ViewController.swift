//
//  ViewController.swift
//  UIViewAnimation
//
//  Created by 韩承海 on 2017/11/27.
//  Copyright © 2017年 韩小醋. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var button: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var animationView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func animationAction(_ sender: UIButton) {
//      self.transitionsAnimation()
//        self.transitionText()
        self.buttonAnimation()
    }
    
    
    
    func translateAnimation() {
        UIView.animate(withDuration: 1.2, animations: {
            self.animationView.transform = CGAffineTransform.identity
                .translatedBy(x: -100, y: 0)
                .rotated(by:CGFloat(Double.pi/4))
                .scaledBy(x: 0.5, y: 0.5)
        }) { (flag) in
            self.animationView.transform = CGAffineTransform.identity
        }
    }
    
    func keyframesAnimation() {
        var p = self.animationView.center
        let dur = 0.25
        var start = 0.0
        let dx: CGFloat = -100
        let dy: CGFloat = 50
        var dir: CGFloat = 1
        
        UIView.animateKeyframes(withDuration: 4, delay: 0, options: [], animations: {
            UIView.addKeyframe(withRelativeStartTime: start , relativeDuration: dur , animations: {
                p.x += dx*dir
                p.y += dy
                self.animationView.center = p
            })
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start , relativeDuration: dur , animations: {
                p.x += dx*dir
                p.y += dy
                self.animationView.center = p
            })
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start , relativeDuration: dur , animations: {
                p.x += dx*dir
                p.y += dy
                self.animationView.center = p
            })
            start += dur
            dir *= -1
            UIView.addKeyframe(withRelativeStartTime: start , relativeDuration: dur , animations: {
                p.x += dx*dir
                p.y += dy
                self.animationView.center = p
            })
        }, completion: nil)
    }
    
    func transitionsAnimation() {
        UIView.transition(with: self.imageView, duration: 0.6, options: .transitionFlipFromLeft, animations: {
            if self.imageView.image == #imageLiteral(resourceName: "girl") {
                self.imageView.image = #imageLiteral(resourceName: "header")
            }else {
                self.imageView.image = #imageLiteral(resourceName: "girl")
            }
        }, completion: nil)
    }
    
    func transitionText() {
        let lab2 = UILabel(frame: self.label1.frame)
        lab2.text = self.label1.text == "Hello" ? "World" : "Hello"
        lab2.textColor = UIColor.white
        lab2.sizeToFit()
        UIView.transition(from: self.label1 , to: lab2 , duration: 0.8 , options: .transitionFlipFromLeft , completion: { _ in
            self.label1 = lab2
        })
    }
    
    
    func buttonAnimation() {
        var arr = [UIImage]()
        let w : CGFloat = 18
        for i in 0 ..< 6 {
            UIGraphicsBeginImageContextWithOptions(CGSize(width: w, height: w), false, 0)
            let context = UIGraphicsGetCurrentContext()!
            context.setFillColor(UIColor.red.cgColor)
            let ii = CGFloat(i)
            let rect = CGRect(x: ii, y:ii, width: w-ii*2, height: w-ii*2)
            context.addEllipse(in: rect)
            context.fillPath()
            let im = UIGraphicsGetImageFromCurrentImageContext()!
            UIGraphicsEndImageContext()
            arr.append(im)
        }
        let im = UIImage.animatedImage(with: arr, duration: 0.5)
        self.button.setImage(im, for: .normal)
        self.button.sizeToFit()
    }
}


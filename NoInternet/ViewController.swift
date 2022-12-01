//
//  ViewController.swift
//  NoInternet
//
//  Created by amit sahu on 16/12/16.
//  Copyright © 2016 tpcg. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var cycleReturnLayer: UIImageView!
    @IBOutlet weak var cycleLayer: UIImageView!
    @IBOutlet weak var signalLayer: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        animateCycle()
        animateSignal()
        self.cycleReturnLayer.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func animateCycle(){
        let animationGroup =  CAAnimationGroup.init()
        animationGroup.duration = 4
        
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = -100
        animation.toValue = self.view.frame.width + 100
        animation.duration = 2
        animation.setValue("cycleone", forKey: "animate_first")
        animation.delegate = self
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.8,0.8,0.8,0.9)
        animationGroup.animations = [animation]
        
        cycleLayer.layer.add(animation, forKey: "cycleone")
        cycleLayer.layer.position = CGPoint(x: CGFloat(455), y: CGFloat( (self.view.frame.height / 2) + 68))
    }
    
    func animateCycleReturn(){
        
        let animationReturn =  CAAnimationGroup.init()
        animationReturn.repeatCount = Float.infinity
        animationReturn.duration = 3.75
        animationReturn.beginTime = CACurrentMediaTime() + 1.8
        
        let animation = CABasicAnimation()
        animation.keyPath = "position.x"
        animation.fromValue = self.view.frame.width + 100
        animation.toValue = -100
        animation.duration = 1.5
        
        animation.setValue("cycletwo", forKey: "animate_second")
        animation.delegate = self

        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        animation.timingFunction = CAMediaTimingFunction(controlPoints: 0.5,0.8,0.9,0.9)
        animation.delegate = self
        
        animationReturn.animations = [animation]

        cycleReturnLayer.layer.add(animation, forKey: "cycletwo")
        cycleReturnLayer.layer.position = CGPoint(x: CGFloat(self.view.frame.width + 100), y: CGFloat( (self.view.frame.height / 2) + 30))
    }
    
  
    
    func animateSignal(){
        
        let pulseAnimation = CABasicAnimation(keyPath: "opacity")
        pulseAnimation.duration = 1
        pulseAnimation.fromValue = 0
        pulseAnimation.toValue = 1
        pulseAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        pulseAnimation.autoreverses = true
        pulseAnimation.repeatCount = .greatestFiniteMagnitude
        
        signalLayer.layer.add(pulseAnimation, forKey: "animateOpacity")
    }
}

extension ViewController: CAAnimationDelegate {
    
     func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        if let animationID: AnyObject = anim.value(forKey: "animate_first") as AnyObject? {
            if animationID as! NSString == "cycleone" {
                // execute code
                self.animateCycleReturn()
                self.cycleReturnLayer.isHidden = false
            }
        }
        
        if let animationID: AnyObject = anim.value(forKey: "animate_second") as AnyObject? {
            if animationID as! NSString == "cycletwo" {
                // execute code
                self.animateCycle()
            }
        }
    }

}


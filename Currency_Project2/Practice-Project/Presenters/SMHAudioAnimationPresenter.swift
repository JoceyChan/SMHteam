//
//  SMHAudioAnimationPresenter.swift
//  Practice-Project
//
//  Created by Alex Roman on 5/4/22.
//

import Foundation
import UIKit

class PulseAnimation: CALayer {
    
    var animationGroup = CAAnimationGroup()
    var animationDuration: TimeInterval = 1.5
    var radius: CGFloat = 200
    var numberOfPulses: Float = 10
    
    
    override init(layer: Any) {
        super.init(layer: (Any).self)
    }
    
    init(numberOfPulses: Float = 10, radius: CGFloat, position: CGPoint){
        super.init()
        
        self.backgroundColor = UIColor.systemOrange.cgColor
        self.contentsScale = UIScreen.main.scale
        self.opacity = 0
        self.radius = radius
        self.numberOfPulses = numberOfPulses
        self.position = position
        
        //define bounds of pulse
        self.bounds = CGRect(x: 0, y: 0, width: radius*2, height: radius*2)
        self.cornerRadius = radius
        
        DispatchQueue.global(qos: DispatchQoS.QoSClass.default).async {
            self.setupAnimationGroup()
            DispatchQueue.main.async {
                self.add(self.animationGroup, forKey: "pulse")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func scaleAnimation() -> CABasicAnimation {
        let scaleAnimation = CABasicAnimation(keyPath: "transform.scale.xy")
        scaleAnimation.fromValue = NSNumber(value: 0)
        scaleAnimation.toValue = NSNumber(value: 1)
        
        scaleAnimation.duration = animationDuration
        return scaleAnimation
    }
    
    func createOpacityAnimation() -> CAKeyframeAnimation {
        let opacityAnimation = CAKeyframeAnimation(keyPath: "opacity")
        
        opacityAnimation.duration = animationDuration
        opacityAnimation.keyTimes = [0, 0.3, 1]
        opacityAnimation.values = [0.4, 0.8, 0]
        return opacityAnimation
    }
    
    func setupAnimationGroup() {
        self.animationGroup.duration = animationDuration
        self.animationGroup.repeatCount = numberOfPulses
        let defaultCurve = CAMediaTimingFunction(name: .default)
        self.animationGroup.timingFunction = defaultCurve
        self.animationGroup.animations = [scaleAnimation(), createOpacityAnimation()]
        
    }
    
}

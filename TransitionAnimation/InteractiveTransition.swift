//
//  InteractiveTransition.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

class InteractiveTransition: NSObject,UIViewControllerInteractiveTransitioning {
    
    var transitionContext : UIViewControllerContextTransitioning!
    var transitingView : UIView!
    var toView : UIView!

    func startInteractiveTransition(_ transitionContext: UIViewControllerContextTransitioning) {
        self.transitionContext = transitionContext
        
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)!
        let fromViewController = transitionContext.viewController(forKey: .from)!
        
        containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        transitingView = fromViewController.view
        toView = toViewController.view
    }
    
    func updateWithPercent(percent: CGFloat){
        let scale = CGFloat(fabsf(Float(percent - CGFloat(1.0))))
        let transform = CGAffineTransform(scaleX: scale, y: scale)
        transitingView.transform = transform
        toView.alpha = percent
        transitionContext.updateInteractiveTransition(percent)
    }
    
    func finishBy(cancelled: Bool) {
        if cancelled {
            UIView.animate(withDuration: 0.4, animations: { 
                self.transitingView.transform = CGAffineTransform.identity
            }, completion: { (finished) in
                self.transitionContext.cancelInteractiveTransition()
                self.transitionContext.completeTransition(false)
            })
        }else {
            UIView.animate(withDuration: 0.4, animations: { 
                self.transitingView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            }, completion: { (finished) in
                self.transitionContext.finishInteractiveTransition()
                self.transitionContext.completeTransition(true)
            })
        }
    }
}

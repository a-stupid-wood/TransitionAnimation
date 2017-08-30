//
//  ModalAnimation.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

enum ModalPresentingType {
    case present
    case dismiss
}

class ModalAnimation: NSObject,UIViewControllerAnimatedTransitioning {
    
    var modalPresentingType : ModalPresentingType!
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        
        let toViewController = transitionContext.viewController(forKey: .to)
        let fromViewController = transitionContext.viewController(forKey: .from)
        
        var destView : UIView!
        var destTransform = CGAffineTransform.identity
        let screenWidth = UIScreen.main.bounds.size.width
        
        if modalPresentingType == ModalPresentingType.present {
            destView = toViewController?.view
            destView.transform = CGAffineTransform(translationX: screenWidth, y: 0)
            containerView.addSubview((toViewController?.view)!)
        }else if modalPresentingType == ModalPresentingType.dismiss {
            destView = fromViewController?.view
            destTransform = CGAffineTransform(translationX: screenWidth, y: 0)
            containerView.insertSubview((toViewController?.view)!, belowSubview: (fromViewController?.view)!)
        }
//        UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0, options: UIViewAnimationOptions.curveLinear, animations: {
//            destView.transform = destTransform
//        }) { (completed) in
//            /*
//             在动画完成的时候调用completeTransition，告诉transitionContext你的动画已经结束，这是非常重要的方法，必须调用。在动画结束时没有对containerView的子视图进行清理（比如把fromViewController的view移除掉）是因为transitionContext会自动清理，所以我们无须在额外处理。
//             */
//            transitionContext.completeTransition(true)
//        }
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            destView.transform = destTransform
        }) { (finished) in
            /*
             在动画完成的时候调用completeTransition，告诉transitionContext你的动画已经结束，这是非常重要的方法，必须调用。在动画结束时没有对containerView的子视图进行清理（比如把fromViewController的view移除掉）是因为transitionContext会自动清理，所以我们无须在额外处理。
             */
            transitionContext.completeTransition(true)
        }

    }
}

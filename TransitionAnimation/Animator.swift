//
//  Animator.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

class Animator: NSObject,UIViewControllerAnimatedTransitioning {
    
    var navigationOperation : UINavigationControllerOperation!
    var originalView : UIView!
    var originalFrame = CGRect.zero
    //单例
    static let shareAnimator = Animator()

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let toViewController = transitionContext.viewController(forKey: .to)!
        let fromViewController = transitionContext.viewController(forKey: .from)!
        
        var detailVC : DetailViewController!
        var fromView : UIView!
        var alpha : CGFloat = 1.0
        var destTransform : CGAffineTransform!
        
        var snapshotImageView : UIView!
        
        if navigationOperation == UINavigationControllerOperation.push {
            containerView.insertSubview(toViewController.view, aboveSubview: fromViewController.view)
            snapshotImageView = originalView.snapshotView(afterScreenUpdates: false)
            detailVC = toViewController as! DetailViewController
            fromView = fromViewController.view
            alpha = 0
            detailVC.view.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            destTransform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            snapshotImageView.frame = originalFrame
        }else if navigationOperation == UINavigationControllerOperation.pop {
            containerView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
            detailVC = fromViewController as! DetailViewController
            snapshotImageView = detailVC.imageView.snapshotView(afterScreenUpdates: false)
            fromView = toViewController.view
            destTransform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            snapshotImageView.frame = detailVC.imageView.frame
        }
        originalView.isHidden = true
        detailVC.imageView.isHidden = true
        
        containerView.addSubview(snapshotImageView)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            detailVC.view.transform = destTransform
            fromView.alpha = alpha
            if self.navigationOperation == UINavigationControllerOperation.push {
                snapshotImageView.frame = detailVC.imageView.frame
            }else if self.navigationOperation == UINavigationControllerOperation.pop {
                detailVC.view.backgroundColor = UIColor.clear
                snapshotImageView.frame = self.originalFrame
            }
        }) { (finished) in
            self.originalView.isHidden = false
            detailVC.imageView.isHidden = false
            snapshotImageView.removeFromSuperview()
            /*
             在动画完成的时候调用completeTransition，告诉transitionContext你的动画已经结束，这是非常重要的方法，必须调用。在动画结束时没有对containerView的子视图进行清理（比如把fromViewController的view移除掉）是因为transitionContext会自动清理，所以我们无须在额外处理。
             */
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}

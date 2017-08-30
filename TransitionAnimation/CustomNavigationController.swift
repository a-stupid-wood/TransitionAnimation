//
//  CustomNavigationController.swift
//  TransitionAnimation
//
//  Created by zj on 2017/8/28.
//  Copyright © 2017年 zj. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController,UINavigationControllerDelegate {
    
    let animator = Animator.shareAnimator
    var interactivePopTransition : InteractiveTransition?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //添加手势
        let panGesture = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(handlePanGestureRecognizer(panGesture:)))
        panGesture.edges = UIRectEdge.left
        view.addGestureRecognizer(panGesture)
        
        self.delegate = self
    }
    
    func handlePanGestureRecognizer(panGesture : UIScreenEdgePanGestureRecognizer) {
        var progress = panGesture.translation(in: view).x / view.frame.width
        progress = min(1.0, max(0.0, progress))
        
        print(progress)
        switch panGesture.state {
        case .began:
            interactivePopTransition = InteractiveTransition()
            popViewController(animated: true)
        case .changed:
            interactivePopTransition?.updateWithPercent(percent: progress)
        case .ended,.cancelled:
            if progress > 0.5 {
                interactivePopTransition?.finishBy(cancelled: false)
            }else{
                interactivePopTransition?.finishBy(cancelled: true)
            }
            interactivePopTransition = nil
        default:
            break
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationControllerOperation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animator.navigationOperation = operation
        return animator
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactivePopTransition
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
    }
    
    override func popViewController(animated: Bool) -> UIViewController? {
        return super.popViewController(animated: animated)
    }
    
    override func popToRootViewController(animated: Bool) -> [UIViewController]? {
        return super.popToRootViewController(animated: animated)
    }
    
    override func popToViewController(_ viewController: UIViewController, animated: Bool) -> [UIViewController]? {
        return super.popToViewController(viewController, animated: animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

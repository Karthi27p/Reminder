//
//  CustomPresentAnimationController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 10/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class CustomPresentAnimationController: NSObject, UIViewControllerAnimatedTransitioning {

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 2.5
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)!
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)!
        let finalFrame = transitionContext.finalFrame(for: toViewController)
        let container = transitionContext.containerView
        if(AddEventsViewController.schedulePressed == false)
        {
            let bounds = UIScreen.main.bounds
            toViewController.view.frame = finalFrame.offsetBy(dx: 0,dy: bounds.size.height)
            container.addSubview(toViewController.view)
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay : 0.0, usingSpringWithDamping: 0.4, initialSpringVelocity: 0.0, options: .curveLinear, animations: {
                fromViewController.view.alpha = 0.5
                toViewController.view.frame = finalFrame
            }, completion: {
                finished in
                transitionContext.completeTransition(true)
                fromViewController.view.alpha = 1.0
            })
        }
        
        if(AddEventsViewController.schedulePressed == true)
        {
            toViewController.view.frame = finalFrame
            toViewController.view.alpha = 0.5
            container.addSubview(toViewController.view)
            container.sendSubview(toBack: toViewController.view)
            
            let snapshotView = fromViewController.view.snapshotView(afterScreenUpdates: false)
            snapshotView?.frame = fromViewController.view.frame
            container.addSubview(snapshotView!)
            
            fromViewController.view.removeFromSuperview()
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
                snapshotView?.frame = fromViewController.view.frame.insetBy(dx: fromViewController.view.frame.size.width/2,dy: fromViewController.view.frame.size.height/2)
                toViewController.view.alpha = 1
            }, completion: { (yes) in
                snapshotView?.removeFromSuperview()
                transitionContext.completeTransition(true)
            })
        }
    }

    
}

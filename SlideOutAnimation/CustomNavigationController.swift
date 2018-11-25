//
//  CustomNavigationController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 10/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class CustomNavigationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var reverse : Bool = false
    
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval
    {
        return 1.5
    }
    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning)
    {
        let fromViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toViewController = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let fromView = fromViewController?.view
        let toView = toViewController?.view
        let container = transitionContext.containerView
        let direction : CGFloat = reverse ? -1 : 1
        let const : CGFloat = -0.005
        
        toView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 0 : 1, y: 0.5)
        fromView?.layer.anchorPoint = CGPoint(x: direction == 1 ? 1 : 0, y: 0.5)
        var viewFromTransform : CATransform3D = CATransform3DMakeRotation(direction * CGFloat(Double.pi/2), 0.0, 0.1, 0.0)
        var viewToTransform : CATransform3D = CATransform3DMakeRotation(-direction * CGFloat(Double.pi/2), 0.0, 0.1, 0.0)
        viewFromTransform.m34 = const
        viewToTransform.m34 = const
        
        container.transform = CGAffineTransform(translationX: direction * container.frame.size.width/2, y: 0.0)
        toView?.layer.transform = viewToTransform
        container.addSubview(toView!)
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            container.transform = CGAffineTransform(translationX: -direction * container.frame.size.width / 2.0, y: 0)
            fromView?.layer.transform = viewFromTransform
            toView?.layer.transform = CATransform3DIdentity
        }, completion: {
            finished in
            
            container.transform = CGAffineTransform.identity
            fromView?.layer.transform = CATransform3DIdentity
            toView?.layer.transform = CATransform3DIdentity
            fromView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            toView?.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            
            if (transitionContext.transitionWasCancelled) {
                toView?.removeFromSuperview()
            } else {
                fromView?.removeFromSuperview()
            }
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        })
        
    }

}

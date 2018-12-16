//
//  DismissViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 08/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class DismissViewController: NSObject {

}

extension DismissViewController : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard
            let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from),
            let _ = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
            else {
                return
        }
        let containerView = transitionContext.containerView
        let snapshot = containerView.viewWithTag(123)
        
        /*UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
                
        },
            completion: { _ in
                let didTransitionComplete = !transitionContext.transitionWasCancelled
                if didTransitionComplete {
                    containerView.insertSubview(toVC.view, aboveSubview: fromVC.view)
                    snapshot?.removeFromSuperview()
                }
                transitionContext.completeTransition(didTransitionComplete)
        }
        )*/
        UIView.animate(
            withDuration: transitionDuration(using: transitionContext),
            animations: {
                snapshot?.center.x -= UIScreen.main.bounds.width * 0.8
        },
            completion: { _ in
                fromVC.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        )
    }
    
}

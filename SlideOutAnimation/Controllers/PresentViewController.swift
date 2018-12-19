//
//  PresentViewController.swift
//  SlideOutAnimation
//
//  Created by Karthi on 04/08/17.
//  Copyright © 2017 Tringapps. All rights reserved.
//

import UIKit

class PresentViewController: NSObject
{
}


extension PresentViewController : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let fromVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.from)
        let toVC = transitionContext.viewController(forKey: UITransitionContextViewControllerKey.to)
        let container = transitionContext.containerView
        container.insertSubview((toVC?.view)!, belowSubview: (fromVC?.view)!)
        if let snapshot = fromVC?.view.snapshotView(afterScreenUpdates: false) {
            
            snapshot.tag = 123
            snapshot.isUserInteractionEnabled = false
            snapshot.layer.shadowOpacity = 0.7
            
            container.insertSubview(snapshot, aboveSubview: (toVC?.view)!)
            fromVC?.view.isHidden = true
            
            UIView.animate(
                withDuration: transitionDuration(using: transitionContext),
                animations: {
                    snapshot.center.x += UIScreen.main.bounds.width * 0.8
                    
            },
                completion: { _ in
                    fromVC?.view.isHidden = false
                    transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
            )
        }
        
    }

}

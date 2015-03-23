//
//  TaskPresentationController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

//PeteC Github
class TaskPresentationController : UIPresentationController {
    
    var dimmingView: UIView!
    
    override func presentationTransitionWillBegin() {
        dimmingView = UIView(frame: containerView.bounds)
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor(white: 1.0, alpha: 0.75)
        containerView.addSubview(dimmingView)
        containerView.addSubview(self.presentedView())
        
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.alpha = 1.0
            }, completion: nil
        )
    }
    
    override func presentationTransitionDidEnd(completed: Bool) {
        if !completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func dismissalTransitionWillBegin() {
        let transitionCoordinator = presentingViewController.transitionCoordinator()
        transitionCoordinator?.animateAlongsideTransition({(context: UIViewControllerTransitionCoordinatorContext!) -> Void in
            self.dimmingView.alpha  = 0.0
            }, completion:nil)
    }
    
    override func dismissalTransitionDidEnd(completed: Bool) {
        if completed {
            self.dimmingView.removeFromSuperview()
        }
    }
    
    override func frameOfPresentedViewInContainerView() -> CGRect {
        var frame = self.containerView.bounds
        frame = CGRectInset(frame, 50.0, 50.0)
        return frame
    }
}

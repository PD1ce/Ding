//
//  CreateTaskViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

//PeteC Github
class CreateTaskViewController : UIViewController, UIViewControllerTransitioningDelegate {
    
    var skill: Skill!
    
    var cancelButton: UIButton!
    var createButton: UIButton!
    
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.commonInit()
    }
    
    //Likely Unneeded
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: NSBundle!)  {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.commonInit()
    }
    
    init(skill: Skill) {
        super.init()
        self.skill = skill
        self.commonInit()
    }
    
    func commonInit() {
        self.modalPresentationStyle = .Custom
        self.transitioningDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.frame = CGRectInset(view.frame, 50.0, 50.0)
        view.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        view.layer.borderWidth = 5.0
        view.layer.borderColor = tasksColor.CGColor
        
        cancelButton = UIButton(frame: CGRect(x: 5, y: view.frame.height - 55, width: view.frame.width / 2 - 5, height: 50))
        cancelButton.addTarget(self, action: "cancelButtonTapped", forControlEvents: .TouchUpInside)
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        cancelButton.backgroundColor = tasksColor
        cancelButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        cancelButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        cancelButton.layer.borderWidth = 2.0
        cancelButton.layer.borderColor = whiteColor.CGColor
        createButton = UIButton(frame: CGRect(x: 5 + cancelButton.frame.width, y: view.frame.height - 55, width: view.frame.width / 2 - 5, height: 50))
        createButton.addTarget(self, action: "createButtonTapped", forControlEvents: .TouchUpInside)
        createButton.setTitle("Create", forState: .Normal)
        createButton.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        createButton.backgroundColor = tasksColor
        createButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        createButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        createButton.layer.borderWidth = 2.0
        createButton.layer.borderColor = whiteColor.CGColor
        view.addSubview(cancelButton)
        view.addSubview(createButton)
        
    }
    
    
    
    func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func createButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // ---- UIViewControllerTransitioningDelegate methods
    
    func presentationControllerForPresentedViewController(presented: UIViewController!, presentingViewController presenting: UIViewController!, sourceViewController source: UIViewController!) -> UIPresentationController! {
        
        if presented == self {
            return TaskPresentationController(presentedViewController: presented, presentingViewController: presenting)
        }
        
        return nil
    }
    
    func animationControllerForPresentedController(presented: UIViewController!, presentingController presenting: UIViewController!, sourceController source: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if presented == self {
            return TaskPresentationAnimationController(isPresenting: true)
        }
        else {
            return nil
        }
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController!) -> UIViewControllerAnimatedTransitioning! {
        
        if dismissed == self {
            return TaskPresentationAnimationController(isPresenting: false)
        }
        else {
            return nil
        }
    }
}
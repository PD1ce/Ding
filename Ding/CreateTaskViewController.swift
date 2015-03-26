//
//  CreateTaskViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData
//PeteC Github
class CreateTaskViewController : UIViewController, UIViewControllerTransitioningDelegate {
    
    var skill: Skill!
    var parentVC: SkillsViewController!
    
    var cancelButton: UIButton!
    var createButton: UIButton!
    
    var taskNameTF: UITextField!
    var taskExpTF: UITextField!
    var taskDifficultyTF: UITextField!
    
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
        
        //TextFields
        taskNameTF = UITextField(frame: CGRect(x: view.frame.width / 5 - 5, y: 50, width: view.frame.width * 0.6, height: 40))
        taskNameTF.borderStyle = UITextBorderStyle.RoundedRect
        taskNameTF.placeholder = "Task Name"
        taskNameTF.textAlignment = NSTextAlignment(rawValue: 1)!
        taskExpTF = UITextField(frame: CGRect(x: view.frame.width / 5 - 5, y: 100, width: view.frame.width * 0.6, height: 40))
        taskExpTF.borderStyle = UITextBorderStyle.RoundedRect
        taskExpTF.placeholder = "Task Exp"
        taskExpTF.textAlignment = NSTextAlignment(rawValue: 1)!
        taskDifficultyTF = UITextField(frame: CGRect(x: view.frame.width / 5 - 5, y: 150, width: view.frame.width * 0.6, height: 40))
        taskDifficultyTF.borderStyle = UITextBorderStyle.RoundedRect
        taskDifficultyTF.placeholder = "Task Difficulty"
        taskDifficultyTF.textAlignment = NSTextAlignment(rawValue: 1)!
        
        //Buttons
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
        
        view.addSubview(taskNameTF)
        view.addSubview(taskExpTF)
        view.addSubview(taskDifficultyTF)
        view.addSubview(cancelButton)
        view.addSubview(createButton)
        
    }
    
    
    
    func cancelButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func createButtonTapped() {
        
        if taskNameTF.text != "" && taskExpTF.text != "" && taskDifficultyTF.text != "" {
            if saveContext() {
                //UPDATE TASKS IS CALLED AND WORKS!
                parentVC.updateTasks()
                dismissViewControllerAnimated(true, completion: nil)
            } else {
                //Error
            }

        } else {
            // Error
        }
    }
    
    func saveContext() -> Bool {
        let managedContext = skill.managedObjectContext!
        let task = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: managedContext) as Task
        //Set Task Details
        task.taskName = taskNameTF.text
        task.exp = taskExpTF.text.toInt()!
        task.difficulty = Float(taskDifficultyTF.text.toInt()!)
        
        
        //PDAlert: Go over all this! Might be duplicates/leaks
        let skillTasks = skill.tasks.mutableCopy() as NSMutableSet
        skillTasks.addObject(task)
        skill.tasks = skillTasks
        var tempParentArray = NSMutableArray()
        for tempTask in skillTasks {
            //println("Task name: \((tempTask as Task).taskName) + \((tempTask as Task).completed)")
            if (tempTask as Task).completed == 0 {
                tempParentArray.addObject(tempTask as Task)
            }
        }
        parentVC.currentTasks = tempParentArray
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        
        
        return true
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
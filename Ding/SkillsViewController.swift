//
//  SkillsViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SkillsViewController : UIViewController {
    
    var user: User!
    var skill: Skill!
    var tasks: NSMutableArray!
    
    var detailsContainer: UIView!
    var realWidth: Float!
    var currentExp: Float!
    
    var expBarEmpty: UIView!
    var expBarFull: UIView!
    
    var headerView: UIView!
    
    var tasksContainer: UIView!
    var tasksCurrentContainer: UIScrollView!
    var tasksCompletedContainer: UIScrollView!
    
    var tasksCurrent: UIButton!
    var tasksCompleted: UIButton!
    var tasksSearch: UIButton!
    var tasksSort: UIButton!
    var tasksSelectedButton: UIButton!
    
    var createTaskCard: UIView!
    
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    
    
    // PDAlert: Skills needs COUNTERS (miles ran, for instance)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksSelectedButton = tasksCurrent
        
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        tasks = NSMutableArray(array: skill.tasks.allObjects)
        
        detailsContainer = UIView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: 112))
        detailsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = skillsColor
        let backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        backButton.setTitle("< Back", forState: .Normal)
        backButton.setTitleColor(whiteColor, forState: .Normal)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = whiteColor
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "\(skill.skillName)"
        
        headerView.addSubview(backButton)
        headerView.addSubview(headerLabel)
        
        let skillContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
        skillContainerView.backgroundColor = skillsColor
        
        let skillImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: skillContainerView.frame.width - 16, height: 96))
        skillImageView.image = UIImage(named: "philProfile")
        skillImageView.layer.masksToBounds = true
        skillImageView.layer.borderWidth = 3.0
        skillImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        skillImageView.layer.cornerRadius = skillImageView.frame.width / 2
        skillContainerView.addSubview(skillImageView)
        
        let skillNameLabel = UILabel(frame: CGRect(x: skillContainerView.frame.width + 8, y: 8, width: detailsContainer.frame.width - skillContainerView.frame.width - 16, height: skillContainerView.frame.height / 2 - 12))
        skillNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        skillNameLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        skillNameLabel.text = "Level: \(skill.level)"
        //skillNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        skillNameLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        let totalLevelLabel = UILabel(frame: CGRect(x: skillContainerView.frame.width + 8, y: skillNameLabel.frame.height + 16, width: detailsContainer.frame.width - skillContainerView.frame.width - 16, height: skillContainerView.frame.height / 2 - 12))
        totalLevelLabel.font = UIFont(name: "Helvetica", size: 18.0)
        totalLevelLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        
        //Might need this on appear or dynamic
        var expCurrent = Int(skill.expCurrent)
        totalLevelLabel.text = "Exp: \(expCurrent) / \(skill.expTotal)"
        totalLevelLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        
        let expBarContainer = UIView(frame: CGRect(x: 8, y: 20 + headerView.frame.height + 8 + detailsContainer.frame.height, width: detailsContainer.frame.width, height: detailsContainer.frame.height / 2))
        expBarContainer.backgroundColor = whiteColor
        expBarEmpty = UIView(frame: CGRect(x: 8, y: 8, width: expBarContainer.frame.width - 16, height: expBarContainer.frame.height - 16))
        expBarEmpty.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        expBarEmpty.layer.cornerRadius = 10.0
        expBarFull = UIView(frame: CGRect(x: 8, y: 8, width: 0, height: expBarContainer.frame.height - 16))
        expBarFull.layer.cornerRadius = 10.0
        
        expBarContainer.addSubview(expBarEmpty)
        expBarContainer.addSubview(expBarFull)
        
        detailsContainer.addSubview(skillNameLabel)
        detailsContainer.addSubview(totalLevelLabel)
        detailsContainer.addSubview(skillContainerView)
        
        let tasksYPos = 20 + headerView.frame.height + 8 + detailsContainer.frame.height + expBarContainer.frame.height + 8
        tasksContainer = UIView(frame: CGRect(x: 8, y: tasksYPos, width: view.frame.width - 16, height: view.frame.height - tasksYPos - 8))
        tasksContainer.backgroundColor = whiteColor
        tasksContainer.layer.borderColor = tasksColor.CGColor
        tasksContainer.layer.borderWidth = 5.0
        
        //Current Tasks Button
        tasksCurrent = UIButton(frame: CGRect(x: 5, y: 5, width: (tasksContainer.frame.width - 10) * 0.35, height: 30))
        tasksCurrent.addTarget(self, action: "tasksCurrentTapped", forControlEvents: .TouchUpInside)
        tasksCurrent.setTitle("Current", forState: .Normal)
        tasksCurrent.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksCurrent.backgroundColor = tasksColor
        tasksCurrent.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksCurrent.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksCurrent.layer.borderWidth = 2.0
        tasksCurrent.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        //Completed Tasks Button
        tasksCompleted = UIButton(frame: CGRect(x: 5 + tasksCurrent.frame.width, y: 5, width: (tasksContainer.frame.width - 10) * 0.35, height: 30))
        tasksCompleted.addTarget(self, action: "tasksCompletedTapped", forControlEvents: .TouchUpInside)
        tasksCompleted.setTitle("Completed", forState: .Normal)
        tasksCompleted.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksCompleted.backgroundColor = tasksColor
        tasksCompleted.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksCompleted.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksCompleted.layer.borderWidth = 2.0
        tasksCompleted.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        //Sort Tasks Button
        tasksSort = UIButton(frame: CGRect(x: 5 + tasksCurrent.frame.width * 2, y: 5, width: (tasksContainer.frame.width - 10) * 0.15, height: 30))
        tasksSort.addTarget(self, action: "tasksSortTapped", forControlEvents: .TouchUpInside)
        tasksSort.setTitle("So", forState: .Normal)
        tasksSort.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksSort.backgroundColor = tasksColor
        tasksSort.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksSort.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksSort.layer.borderWidth = 2.0
        tasksSort.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        //Search Tasks Button
        tasksSearch = UIButton(frame: CGRect(x: 5 + tasksCurrent.frame.width * 2 + tasksSort.frame.width, y: 5, width: (tasksContainer.frame.width - 10) * 0.15, height: 30))
        tasksSearch.addTarget(self, action: "tasksSearchTapped", forControlEvents: .TouchUpInside)
        tasksSearch.setTitle("So", forState: .Normal)
        tasksSearch.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksSearch.backgroundColor = tasksColor
        tasksSearch.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksSearch.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksSearch.layer.borderWidth = 2.0
        tasksSearch.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        
        // Current Tasks Container - Populate on ViewWillAppear or ButtonPress
        tasksCurrentContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksCurrentContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 750)
        tasksCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        // Completed Tasks Container
        tasksCompletedContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksCompletedContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 750)
        tasksCompletedContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        
        tasksContainer.addSubview(tasksCurrentContainer)
        tasksContainer.addSubview(tasksCompletedContainer)
        tasksContainer.addSubview(tasksCurrent)
        tasksContainer.addSubview(tasksCompleted)
        tasksContainer.addSubview(tasksSort)
        tasksContainer.addSubview(tasksSearch)
        //Set Selected
        tasksSelectedButton = tasksCurrent
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        
        view.addSubview(tasksContainer)
        
        view.addSubview(expBarContainer)
        view.addSubview(detailsContainer)
        view.addSubview(headerView)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tasksCurrentTapped()
        
        //Refresh subviews
        for view in tasksCurrentContainer.subviews {
            view.removeFromSuperview()
        }
        for view in tasksCompletedContainer.subviews {
            view.removeFromSuperview()
        }
        
        //Display Skill's Tasks
        var row = 0
        for task in tasks {
            let taskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 72) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72), task: task as Task)
            tasksCurrentContainer.addSubview(taskCard)
            row++
        }
        //Display New Task Creation
        createTaskCard = UIView(frame: CGRect(x: 4, y: CGFloat(row * 72) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72))
        let taskNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: createTaskCard.frame.width, height: 72))
        createTaskCard.layer.cornerRadius = 5.0
        createTaskCard.layer.borderWidth = 2.0
        createTaskCard.layer.borderColor = tasksColor.CGColor
        createTaskCard.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        //taskNameLabel.layer.borderWidth = 1.0
        //taskNameLabel.layer.cornerRadius = 5.0
        taskNameLabel.text = "Create a new Task"
        taskNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        taskNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
        taskNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        createTaskCard.addSubview(taskNameLabel)
        let tapGR = UITapGestureRecognizer(target: self, action: "createTaskTapped")
        createTaskCard.addGestureRecognizer(tapGR)
        
        
        tasksCurrentContainer.addSubview(createTaskCard)

    }
    
    override func viewDidAppear(animated: Bool) {
        currentExp = Float(skill.expCurrent)
        realWidth = currentExp / Float(skill.expTotal) * Float(expBarEmpty.frame.width)
        self.expBarFull.backgroundColor = UIColor(red: 0.0, green: 0.0, blue: 0.8, alpha: 1.0)
        UIView.animateWithDuration(2.0, animations: {
            self.expBarFull.frame = CGRect(x: self.expBarEmpty.frame.minX, y: self.expBarEmpty.frame.minY, width: CGFloat(self.realWidth), height: self.expBarEmpty.frame.height)
            self.expBarFull.backgroundColor = UIColor(red: 0.645, green: 0.8, blue: 0.2, alpha: 1)
            }, completion: {
                (value: Bool) in
        })
    }
    
    override func viewDidDisappear(animated: Bool) {
        //Set Task back
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        
    }
    
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func createTaskTapped() {
        let createTaskVC = CreateTaskViewController(skill: self.skill)
        presentViewController(createTaskVC, animated: true, completion: nil)
        //let taskPresentationController = TaskPresentationController()
        //let taskPresentationAnimationController = TaskPresentationAnimationController(isPresenting: true)
        
    }
    
    //Task Container Buttons
    func tasksCurrentTapped() {
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
    }
    
    func tasksSortTapped() {
        /*
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksSort
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksSortContainer)
        */
    }
    
    func tasksSearchTapped() {
        /*
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksSearch
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksSearchContainer)
        */
    }
    
    func tasksCompletedTapped() {
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCompleted
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCompletedContainer)
    }
}
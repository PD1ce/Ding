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
    var currentTasks: NSMutableArray!
    var completedTasks: NSMutableArray!
    
    var detailsContainer: UIView!
    var realWidth: Float!
    var currentExp: Float!
    
    var expBarEmpty: UIView!
    var expBarFull: UIView!
    
    var oldExp: Int! // Used to update the number in animations
    var currentExpBeforeLevel: Int!
    var totalExpBeforeLevel: Int!
    var oldSkillLevel: Int!
    
    var particleZero: Int! // Used for particle effects, init in Complete Confirmed
    var taskCardCenter: CGPoint! // Used for particles
    
    var headerView: AniView!
    var expBarContainer: AniView!
    var backButton: UIButton!
    var headerLabel: UILabel!
    
    var skillContainerView: AniView!
    var skillImageView: UIImageView!
    
    var skillNameLabel: AniLabel! // These names should be changed
    var totalLevelLabel: AniLabel!
    
    var tasksContainer: AniView!
    var tasksCurrentContainer: UIScrollView!
    var tasksCompletedContainer: UIScrollView!
    
    var maskView: UIView!
    var congratsView: UIView!
    
    var tasksCurrent: UIButton!
    var tasksCompleted: UIButton!
    var tasksSearch: UIButton!
    var tasksSort: UIButton!
    var tasksSelectedButton: UIButton!
    
    var createTaskCard: UIView!
    
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let blackColor = UIColor(white: 0.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    
    
    // PDAlert: Skills needs COUNTERS (miles ran, for instance)
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasksSelectedButton = tasksCurrent
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        currentTasks = NSMutableArray(array: skill.tasks.allObjects)
        completedTasks = NSMutableArray()
        for task in currentTasks {
            if (task as Task).completed == 1 {
                completedTasks.addObject(task)
                currentTasks.removeObject(task)
            }
        }
        
        detailsContainer = UIView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: 112))
        detailsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        headerView = AniView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = skillsColor
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        backButton.setTitle("< Back", forState: .Normal)
        backButton.setTitleColor(whiteColor, forState: .Normal)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = whiteColor
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "\(skill.skillName)"
        
        headerView.addSubview(backButton)
        headerView.addSubview(headerLabel)
        
        skillContainerView = AniView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
        skillContainerView.backgroundColor = skillsColor
        
        skillImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: skillContainerView.frame.width - 16, height: 96))
        skillImageView.image = UIImage(named: "philProfile")
        skillImageView.layer.masksToBounds = true
        skillImageView.layer.borderWidth = 3.0
        skillImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        skillImageView.layer.cornerRadius = skillImageView.frame.width / 2
        skillContainerView.addSubview(skillImageView)
        
        skillNameLabel = AniLabel(frame: CGRect(x: skillContainerView.frame.width + 8, y: 8, width: detailsContainer.frame.width - skillContainerView.frame.width - 16, height: skillContainerView.frame.height / 2 - 12))
        skillNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        skillNameLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        skillNameLabel.text = "Level: \(skill.level)"
        //skillNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        skillNameLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        totalLevelLabel = AniLabel(frame: CGRect(x: skillContainerView.frame.width + 8, y: skillNameLabel.frame.height + 16, width: detailsContainer.frame.width - skillContainerView.frame.width - 16, height: skillContainerView.frame.height / 2 - 12))
        totalLevelLabel.font = UIFont(name: "Helvetica", size: 18.0)
        totalLevelLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        
        //Might need this on appear or dynamic
        var expCurrent = Int(skill.expCurrent)
        totalLevelLabel.text = "Exp: \(expCurrent) / \(skill.expTotal)"
        totalLevelLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        
        expBarContainer = AniView(frame: CGRect(x: 8, y: 20 + headerView.frame.height + 8 + detailsContainer.frame.height, width: detailsContainer.frame.width, height: detailsContainer.frame.height / 2))
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
        tasksContainer = AniView(frame: CGRect(x: 8, y: tasksYPos, width: view.frame.width - 16, height: view.frame.height - tasksYPos - 8))
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
        tasksCurrentContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 2000)
        tasksCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        // Completed Tasks Container
        tasksCompletedContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksCompletedContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 2000)
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
        
        //*** Place things offscreen or change color ****//
        
        skillContainerView.backgroundColor = goldColor
        expBarContainer.frame = CGRect(x: expBarContainer.frame.minX, y: expBarContainer.frame.minY, width: expBarContainer.frame.width, height: 0)
        tasksContainer.frame.origin = CGPoint(x: tasksContainer.frame.minX, y: view.frame.height + 8)
        skillImageView.alpha = 0.0
        skillNameLabel.frame.origin = CGPoint(x: view.frame.width + 16, y: skillNameLabel.frame.minY)
        totalLevelLabel.frame.origin = CGPoint(x: view.frame.width + 16, y: totalLevelLabel.frame.minY)
        ////////////////////////////////////
        
        //Refresh subviews
        for view in tasksCurrentContainer.subviews {
            view.removeFromSuperview()
        }
        for view in tasksCompletedContainer.subviews {
            view.removeFromSuperview()
        }
        
        //Display Skill's Tasks
        var row = 0
        for task in currentTasks {
            let taskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72), task: task as Task)
            taskCard.backgroundColor = tasksColor
            tasksCurrentContainer.addSubview(taskCard)
            let taskNameLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.20), y: 0, width: CGFloat(taskCard.frame.width * 0.65), height: taskCard.frame.height / 2))
            taskNameLabel.text = taskCard.task.taskName
            taskNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskNameLabel.backgroundColor = whiteColor
            taskNameLabel.layer.borderWidth = 2.0
            taskNameLabel.layer.borderColor = tasksColor.CGColor
            let taskExpLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.20), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.325), height: taskCard.frame.height / 2))
            taskExpLabel.text = "Exp: \(taskCard.task.exp)"
            taskExpLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskExpLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskExpLabel.backgroundColor = whiteColor
            taskExpLabel.layer.borderWidth = 2.0
            taskExpLabel.layer.borderColor = tasksColor.CGColor
            let taskDifficultyLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.525), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.325), height: taskCard.frame.height / 2))
            taskDifficultyLabel.text = "Diff: \(taskCard.task.difficulty)"
            taskDifficultyLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskDifficultyLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskDifficultyLabel.backgroundColor = whiteColor
            taskDifficultyLabel.layer.borderWidth = 2.0
            taskDifficultyLabel.layer.borderColor = tasksColor.CGColor
            
            //Complete or Delete Buttons
            let completeButton = UIButton(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: 0, width: CGFloat(taskCard.frame.width * 0.15), height: taskCard.frame.height / 2))
            completeButton.setTitle("!", forState: .Normal)
            completeButton.setTitleColor(whiteColor, forState: .Normal)
            completeButton.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
            //completeButton.layer.cornerRadius = 10.0
            completeButton.addTarget(self, action: "completeButtonTapped:", forControlEvents: .TouchUpInside)
            completeButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
            completeButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
            let deleteButton = UIButton(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.15), height: taskCard.frame.height / 2))
            deleteButton.setTitle("X", forState: .Normal)
            deleteButton.setTitleColor(whiteColor, forState: .Normal)
            deleteButton.backgroundColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)
            //deleteButton.layer.cornerRadius = 10.0
            deleteButton.addTarget(self, action: "deleteButtonTapped:", forControlEvents: .TouchUpInside)
            deleteButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
            deleteButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
            let buttonDivider = UIView(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: taskCard.frame.height / 2 - 2, width: CGFloat(taskCard.frame.width * 0.15), height: 4))
            buttonDivider.backgroundColor = tasksColor
            
            taskCard.addSubview(taskNameLabel)
            taskCard.addSubview(taskExpLabel)
            taskCard.addSubview(taskDifficultyLabel)
            taskCard.addSubview(completeButton)
            taskCard.addSubview(deleteButton)
            taskCard.addSubview(buttonDivider)
            
            row++
        }
        //Display New Task Creation
        createTaskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72))
        let taskNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: createTaskCard.frame.width, height: 72))
        createTaskCard.layer.cornerRadius = 10.0
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
        self.expBarFull.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
        
        
        // Skill Container Background Color
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.skillContainerView.backgroundColor = self.skillsColor
            }, completion: {
                (value: Bool) in
        })
        //Skill Image View Alpha
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.skillImageView.alpha = 1.0
            }, completion: {
                (value: Bool) in
        })
        // Exp Bar Container Frame
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.expBarContainer.frame = self.expBarContainer.originalFrame
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(2.0, animations: {
                    self.expBarFull.frame = CGRect(x: self.expBarEmpty.frame.minX, y: self.expBarEmpty.frame.minY, width: CGFloat(self.realWidth), height: self.expBarEmpty.frame.height)
                    self.expBarFull.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1)
                    }, completion: {
                        (value: Bool) in
                })
        })
        // Main Tasks Container Frame
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.tasksContainer.frame.origin = self.tasksContainer.originalOrigin
            }, completion: {
                (value: Bool) in
        })
        //Labels
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseInOut, animations: {
            self.skillNameLabel.frame.origin = self.skillNameLabel.originalOrigin
            }, completion: {
                (value: Bool) in
        })
        UIView.animateWithDuration(0.5, delay: 0.7, options: .CurveEaseInOut, animations: {
            self.totalLevelLabel.frame.origin = self.totalLevelLabel.originalOrigin
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
    
    
    func updateTasks() {
        //println("update tasks called!")
        for view in tasksCurrentContainer.subviews {
            view.removeFromSuperview()
        }
        for view in tasksCompletedContainer.subviews {
            view.removeFromSuperview()
        }
        
        //Display Skill's Tasks
        var row = 0
        for task in currentTasks {
            let taskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72), task: task as Task)
            taskCard.backgroundColor = tasksColor
            tasksCurrentContainer.addSubview(taskCard)
            let taskNameLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.20), y: 0, width: CGFloat(taskCard.frame.width * 0.65), height: taskCard.frame.height / 2))
            taskNameLabel.text = taskCard.task.taskName
            taskNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskNameLabel.backgroundColor = whiteColor
            taskNameLabel.layer.borderWidth = 2.0
            taskNameLabel.layer.borderColor = tasksColor.CGColor
            let taskExpLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.20), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.325), height: taskCard.frame.height / 2))
            taskExpLabel.text = "Exp: \(taskCard.task.exp)"
            taskExpLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskExpLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskExpLabel.backgroundColor = whiteColor
            taskExpLabel.layer.borderWidth = 2.0
            taskExpLabel.layer.borderColor = tasksColor.CGColor
            let taskDifficultyLabel = UILabel(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.525), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.325), height: taskCard.frame.height / 2))
            taskDifficultyLabel.text = "Diff: \(taskCard.task.difficulty)"
            taskDifficultyLabel.textAlignment = NSTextAlignment(rawValue: 1)!
            taskDifficultyLabel.font = UIFont(name: "Helvetica", size: 18.0)
            taskDifficultyLabel.backgroundColor = whiteColor
            taskDifficultyLabel.layer.borderWidth = 2.0
            taskDifficultyLabel.layer.borderColor = tasksColor.CGColor
            
            //Complete or Delete Buttons
            let completeButton = UIButton(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: 0, width: CGFloat(taskCard.frame.width * 0.15), height: taskCard.frame.height / 2))
            completeButton.setTitle("!", forState: .Normal)
            completeButton.setTitleColor(whiteColor, forState: .Normal)
            completeButton.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
            //completeButton.layer.cornerRadius = 10.0
            completeButton.addTarget(self, action: "completeButtonTapped:", forControlEvents: .TouchUpInside)
            completeButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
            completeButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
            let deleteButton = UIButton(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: taskCard.frame.height / 2, width: CGFloat(taskCard.frame.width * 0.15), height: taskCard.frame.height / 2))
            deleteButton.setTitle("X", forState: .Normal)
            deleteButton.setTitleColor(whiteColor, forState: .Normal)
            deleteButton.backgroundColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)
            //deleteButton.layer.cornerRadius = 10.0
            deleteButton.addTarget(self, action: "deleteButtonTapped:", forControlEvents: .TouchUpInside)
            deleteButton.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
            deleteButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
            let buttonDivider = UIView(frame: CGRect(x: CGFloat(taskCard.frame.width * 0.85), y: taskCard.frame.height / 2 - 2, width: CGFloat(taskCard.frame.width * 0.15), height: 4))
            buttonDivider.backgroundColor = tasksColor
            
            taskCard.addSubview(taskNameLabel)
            taskCard.addSubview(taskExpLabel)
            taskCard.addSubview(taskDifficultyLabel)
            taskCard.addSubview(completeButton)
            taskCard.addSubview(deleteButton)
            taskCard.addSubview(buttonDivider)
            
            row++
        }
        //Display New Task Creation
        createTaskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72))
        let taskNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: createTaskCard.frame.width, height: 72))
        createTaskCard.layer.cornerRadius = 10.0
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
    
    func refreshTasks() {
        updateTasks()
        
    }
    
    /* Complete Alert and Actions! */
    func completeButtonTapped(button: UIButton) {
        let taskCard = button.superview as TaskCard
        
        let alert = UIAlertController(title: "Complete Task", message: "Did you complete this task?", preferredStyle: UIAlertControllerStyle.Alert)
        let confirmButton = UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler:
        {(action) -> Void in
            self.completeConfirmed(taskCard)
        })
        let cancelButton = UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: {
            action -> Void in
        })
        alert.addAction(confirmButton)
        alert.addAction(cancelButton)
        presentViewController(alert, animated: true, completion: nil)
        
    }
    
    //PDAlert: Dear god man, clean this mess up
    func completeConfirmed(taskCard: TaskCard){
        let task = taskCard.task
        task.completed = 1
        ////Must take into account levelup!
        oldExp = Int(skill.expCurrent)
        currentExpBeforeLevel = Int(skill.expCurrent)
        totalExpBeforeLevel = Int(skill.expTotal)
        oldSkillLevel = Int(skill.level)
        
        skill.expCurrent = Int(self.skill.expCurrent) + Int(task.exp)
        completedTasks.addObject(task)
        currentTasks.removeObject(task)
        
        
        //// Particle Effects ////
        particleZero = 0
        taskCardCenter = taskCard.convertPoint(taskCard.center, toView: nil)
        let expParticleTimer = NSTimer(timeInterval: 0.01, target: self, selector: "expParticleFired:", userInfo: taskCard, repeats: true)
        NSRunLoop.currentRunLoop().addTimer(expParticleTimer, forMode: NSDefaultRunLoopMode)
        //////////////////////////
        
        if saveContext() {
            // Reload the task view and make sure it appears in completedol tooo
            var removedTaskCardFound = false
            for tCard in tasksCurrentContainer.subviews {
                if tCard.isKindOfClass(TaskCard) {
                    let tCardObject = tCard as TaskCard
                    if removedTaskCardFound {
                        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: {
                            tCardObject.center.y = tCardObject.center.y - 76
                        }, completion: {
                            (value: Bool) in
                        })
                    }
                    if (tCard as TaskCard) == taskCard {
                        removedTaskCardFound = true
                        UIView.animateWithDuration(1.0, delay: 0.0, options: nil, animations: {
                            taskCard.alpha = 0.0
                        }, completion: {
                            (value: Bool) in
                                taskCard.removeFromSuperview()
                                removedTaskCardFound = true
                        })
                    }
                }
            } // end for
            
            //////////////// Check for levelup! /////////////////
            var levelUp = false
            var expForNextLevel = Int(skill.expCurrent) - Int(skill.expTotal)
            var newExp = oldExp + Int(task.exp)
            if newExp >= Int(skill.expTotal) {
                //Level Up
                levelUp = true
            }
            var firstAnimationDuration = 2.0
            var firstAnimationOptions = UIViewAnimationOptions.CurveEaseInOut
            if levelUp {
                firstAnimationDuration = 2.0
                firstAnimationOptions = UIViewAnimationOptions.CurveEaseIn
            }
            /////////////////////////////////////////////////////
            
            // Timer should take 2 seconds, so interval should be relative to experience gained
            // First number is seconds it will take, not entirely accurate because of interval
            let interval = 2 / Float(task.exp)
            let timer = NSTimer(timeInterval: NSTimeInterval(interval), target: self, selector: "updateExpLabel:", userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSDefaultRunLoopMode)
            // Now Animate the new exp value and the expbar!
            expBarEmpty.backgroundColor = tasksColor
            //Animations
            UIView.animateWithDuration(firstAnimationDuration, delay: 0.0, options: firstAnimationOptions, animations: {
                let expRatio = CGFloat(self.skill.expCurrent) / CGFloat(self.skill.expTotal)
                let newWidth = CGFloat(CGFloat(self.expBarEmpty.frame.width) * expRatio)
                if levelUp {
                    self.expBarFull.frame = CGRect(x: self.expBarFull.frame.minX, y: self.expBarFull.frame.minY, width: self.expBarEmpty.frame.width, height: self.expBarFull.frame.height)
                } else {
                     self.expBarFull.frame = CGRect(x: self.expBarFull.frame.minX, y: self.expBarFull.frame.minY, width: newWidth, height: self.expBarFull.frame.height)
                }
               
                self.expBarEmpty.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                
                //Completion of first animation
                }, completion: {
                    (value: Bool) in
                    //////// If skill Leveled Up, Time to do lots of stuff!///////
                    if levelUp {
                        //Probably should do a big alert/modal popup
                        /* Change skill Level and needed Exp */
                        
                        self.skill.expCurrent = expForNextLevel
                        self.skill.level = Int(self.skill.level) + 1
                        self.skill.expTotal = Int(Int(self.skill.level) * 100)
                        ///////////////////////////////////////
                        self.expBarFull.frame = CGRect(x: self.expBarFull.frame.minX, y: self.expBarFull.frame.minY, width: 0, height: self.expBarFull.frame.height)
                        //Now add more Exp
                        self.skillNameLabel.text = "Level: \(self.skill.level)"
                        self.expBarEmpty.backgroundColor = self.goldColor
                        self.tasksCurrentContainer.backgroundColor = self.goldColor
                        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
                            let expRatio = CGFloat(self.skill.expCurrent) / CGFloat(self.skill.expTotal)
                            let newWidth = CGFloat(CGFloat(self.expBarEmpty.frame.width) * expRatio)
                            self.expBarFull.frame = CGRect(x: self.expBarFull.frame.minX, y: self.expBarFull.frame.minY, width: newWidth, height: self.expBarFull.frame.height)
                            self.expBarEmpty.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
                            self.tasksCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
                            }, completion: {
                                (value: Bool) in
                                //Final Touches if needed
                                
                        })
                        
                        //Save Context
                        if self.saveContext() {
                            // Good
                        } else {
                            // Bad
                        }
                        
                    }
            })
            
            //Independent level up animations: Fire as soon as task is complete
            if levelUp {
                let backgroundShine = UIView(frame: CGRect(x: self.view.frame.minX - self.view.frame.width, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height))
                backgroundShine.layer.zPosition = -1
                backgroundShine.backgroundColor = self.goldColor
                backgroundShine.alpha = 0.0
                self.view.addSubview(backgroundShine)
                
                let backgroundShineFollow = UIView(frame: self.view.frame)
                backgroundShineFollow.backgroundColor = self.goldColor
                backgroundShineFollow.layer.zPosition = -2

                let containerShine = UIView(frame: CGRect(x: self.view.frame.minX - self.view.frame.width - 8, y: self.view.frame.minY, width: self.view.frame.width - 16, height: self.view.frame.height))
                containerShine.backgroundColor = self.goldColor
                containerShine.layer.zPosition = -2
                containerShine.alpha = 0.0
                
                tasksCurrentContainer.addSubview(containerShine)
                
                //Animate from offscreen to middle
                UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    backgroundShine.alpha = 1.0
                    backgroundShine.frame = CGRect(x: self.view.frame.minX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
                    containerShine.alpha = 1.0
                    containerShine.frame = CGRect(x: self.tasksCurrentContainer.frame.minX - 8, y: self.view.frame.minY, width: self.view.frame.width - 16, height: self.view.frame.height)
                    }, completion: {
                        (value: Bool) in
                        //Animate from middle to offscreen
                        self.view.addSubview(backgroundShineFollow)
                        backgroundShine.removeFromSuperview()
                        UIView.animateWithDuration(2.0, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                            backgroundShineFollow.alpha = 0.0
                            backgroundShine.alpha = 0.0
                            backgroundShine.frame = CGRect(x: self.view.frame.maxX, y: self.view.frame.minY, width: self.view.frame.width, height: self.view.frame.height)
                            containerShine.alpha = 0.0
                            }, completion: {
                                (value: Bool) in
                                //backgroundShine.removeFromSuperview()
                                backgroundShineFollow.removeFromSuperview()
                                containerShine.removeFromSuperview()
                                ///// View to Congratulate! /////
                                self.displayLevelUp()
                        })
                        
                        
                })
            }
            
            
            
            
        } else {
            // Did not save!
        }
        
    }
    
    //PDAlert: Dear god man, clean this mess up
    func updateExpLabel(timer: NSTimer) {
        //Level up may not be necessary, probably not
        var leveledUp = false
        let exp = 2 / Float(timer.timeInterval)
        var increment = Int(exp / 50)
        if increment == 0 {
            increment = 1
        }
        oldExp = oldExp + increment
        if oldSkillLevel < Int(skill.level) {
            leveledUp = true
        }
        
        if leveledUp {
            oldSkillLevel = Int(skill.level)
            oldExp = 0
            leveledUp = false
        }
        
        if oldExp >= Int(skill.expTotal) {
            oldExp = 0
        }
        
        totalLevelLabel.text = "Exp: \(oldExp) / \(skill.expTotal)"
        if oldExp >= Int(skill.expCurrent) {
            totalLevelLabel.text = "Exp: \(skill.expCurrent) / \(skill.expTotal)"
            timer.invalidate()
        }
    
        
       
    }
    
    func expParticleFired(timer: NSTimer) {
        let taskCard = timer.userInfo as TaskCard
        let expMax = Int(taskCard.task.exp)
       
        let expCenter = expBarFull.convertPoint(CGPoint(x: expBarFull.frame.maxX - 10, y: expBarFull.frame.midY), toView: nil)
        let particleView = UIView(frame: CGRect(x: taskCardCenter.x, y: taskCardCenter.y, width: 5, height: 5))
        particleView.backgroundColor = goldColor
        particleView.layer.cornerRadius = particleView.frame.width / 2
        view.addSubview(particleView)
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveLinear, animations: {
            particleView.center = CGPoint(x: expCenter.x, y: expCenter.y)
        }, completion: {
            (value: Bool) in
            particleView.removeFromSuperview()
        })
        particleZero = particleZero + 1
        
        
        if particleZero >= expMax {
            particleZero = 0
            timer.invalidate()
        }
        
        
    }
    
    func deleteButtonTapped(button: UIButton) {
        let taskCard = button.superview as TaskCard
        println("Delete Task: \(taskCard.task.taskName)")
    }
    
    func backButtonTapped() {
        // Fake label behind the moving one
        let headerView = UIView(frame: CGRect(x: 0, y: 20, width: self.view.frame.width, height: 44))
        headerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        logoutButton.setTitle("Logout", forState: .Normal)
        //logoutButton.addTarget(self, action: "logoutButtonTapped", forControlEvents: .TouchUpInside)
        logoutButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "Home"
        headerView.addSubview(headerLabel)
        headerView.addSubview(logoutButton)
        headerView.layer.zPosition = -1
        let optionsButton = AniButton(frame: CGRect(x: headerView.frame.width - 48, y: 6, width: 32, height: 32))
        optionsButton.setImage(UIImage(named: "options-gear"), forState: .Normal)
        headerView.addSubview(optionsButton)
        self.view.addSubview(headerView)
        //Tasks Container and Image
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.tasksContainer.frame.origin = CGPoint(x: self.tasksContainer.frame.minX, y: self.view.frame.height + 8)
            self.skillImageView.alpha = 0.0
            self.expBarEmpty.frame = CGRect(x: self.expBarEmpty.frame.minX, y: self.expBarEmpty.frame.minY, width: self.expBarEmpty.frame.width, height: 0.0)
            self.expBarFull.frame = CGRect(x: self.expBarFull.frame.minX, y: self.expBarFull.frame.minY, width: self.expBarFull.frame.width, height: 0.0)
            }, completion: {
                (value: Bool) in
                
        })
        //Exp Bar container
        UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.expBarContainer.frame = CGRect(x: self.expBarContainer.frame.minX, y: self.expBarContainer.frame.minY, width: self.expBarContainer.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
        })
        //Labels
        UIView.animateWithDuration(0.5, delay: 0.2, options: .CurveEaseInOut, animations: {
            self.skillNameLabel.frame.origin = CGPoint(x: self.view.frame.width + 16, y: self.skillNameLabel.frame.minY)
            }, completion: nil)
        UIView.animateWithDuration(0.5, delay: 0.4, options: .CurveEaseInOut, animations: {
            self.totalLevelLabel.frame.origin = CGPoint(x: self.view.frame.width + 16, y: self.totalLevelLabel.frame.minY)
            }, completion: nil)
        //Header View
        UIView.animateWithDuration(0.5, delay: 1.0, options: .CurveEaseInOut, animations: {
            self.headerView.frame.origin = CGPoint(x: 0, y: self.view.frame.height + 44)
            }, completion: {
                (value: Bool) in
                self.dismissViewControllerAnimated(false, completion: {
                    headerView.removeFromSuperview()
                })
        })
        
        
        
       
    }
    
    func createTaskTapped() {
        let createTaskVC = CreateTaskViewController(skill: self.skill)
        createTaskVC.parentVC = self
        presentViewController(createTaskVC, animated: true, completion: nil)
        //let taskPresentationController = TaskPresentationController()
        //let taskPresentationAnimationController = TaskPresentationAnimationController(isPresenting: true)
        
    }
    
    //Figure out button blocks to make this less annoying
    func displayLevelUp() {
        maskView = UIView(frame: view.frame)
        maskView.backgroundColor = whiteColor
        maskView.alpha = 0.0
        maskView.layer.zPosition = 4
        maskView.userInteractionEnabled = true
        
        congratsView = UIView(frame: CGRect(x: 50, y: 50, width: view.frame.width - 100, height: view.frame.height - 100))
        congratsView.layer.zPosition = 5
        congratsView.backgroundColor = whiteColor
        congratsView.layer.cornerRadius = 10.0
        congratsView.layer.borderWidth = 5.0
        congratsView.layer.borderColor = skillsColor.CGColor
        congratsView.alpha = 0.0
        congratsView.userInteractionEnabled = false
        
        let levelUpTitle = UILabel(frame: CGRect(x: 0, y: 0, width: congratsView.frame.width, height: congratsView.frame.height / 10 + 10))
        levelUpTitle.text = "Level Up!"
        levelUpTitle.font = UIFont(name: "Helvetica", size: 44.0)
        levelUpTitle.textAlignment = NSTextAlignment.Center
        levelUpTitle.textColor = goldColor
        
        let levelUpLabel = UILabel(frame: CGRect(x: 0, y: congratsView.frame.height / 10, width: congratsView.frame.width, height: congratsView.frame.height / 10 + 20))
        levelUpLabel.text = "Congratulations on reaching Level:"
        levelUpLabel.font = UIFont(name: "Helvetica", size: 14.0)
        levelUpLabel.textAlignment = NSTextAlignment.Center
        levelUpLabel.textColor = blackColor
        
        //This will be a cool Image view of the number!
        let newLevelLabel = UILabel(frame: CGRect(x: 0, y: congratsView.frame.height / 5, width: congratsView.frame.width, height: congratsView.frame.height / 2))
        newLevelLabel.text = "\(skill.level)"
        newLevelLabel.font = UIFont(name: "Helvetica", size: 225.0)
        newLevelLabel.textAlignment = NSTextAlignment.Center
        newLevelLabel.textColor = goldColor
        
        let dismissButton = UIButton(frame: CGRect(x: congratsView.frame.width / 4, y: congratsView.frame.height - congratsView.frame.height / 5, width: congratsView.frame.width / 2, height: congratsView.frame.height / 5 - 20))
        dismissButton.backgroundColor = whiteColor
        dismissButton.layer.borderColor = skillsColor.CGColor
        dismissButton.layer.borderWidth = 2.0
        dismissButton.setTitle("Okay!", forState: .Normal)
        dismissButton.setTitleColor(goldColor, forState: .Normal)
        dismissButton.titleLabel?.textAlignment = NSTextAlignment.Center
        dismissButton.titleLabel?.font = UIFont(name: "Helvetica", size: 36.0)
        dismissButton.addTarget(self, action: "dismissMe", forControlEvents: .TouchUpInside)
        
        //Shouldn't need to remove these subviews on cleanup
        congratsView.addSubview(levelUpTitle)
        congratsView.addSubview(levelUpLabel)
        congratsView.addSubview(newLevelLabel)
        congratsView.addSubview(dismissButton)
        
        view.addSubview(maskView)
        view.addSubview(congratsView)
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.congratsView.alpha = 1.0
            self.maskView.alpha = 0.5
            }, completion: {
                (value: Bool) in
                self.congratsView.userInteractionEnabled = true
        })
        
        //This might not be viable
        
        
    }
    
    func dismissMe() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.congratsView.alpha = 0.0
            self.maskView.alpha = 0.0
            }, completion: {
                (value: Bool) in
                self.congratsView.removeFromSuperview()
                self.maskView.removeFromSuperview()
        })
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
    
    func saveContext() -> Bool {
        let managedContext = skill.managedObjectContext!
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        
        return true
    }
    
    class TaskLabel : UILabel {
        
    }
}
//
//  CreateGoalViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 5/24/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class CreateGoalViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {
    
    var user: User!
    
    var skills: NSMutableArray!
    var currentTasks = NSMutableArray()
    
    var headerView: AniView!
    var backButton: UIButton!
    var headerLabel: UILabel!
    
    var goalCards = NSMutableArray()
    
    var newGoalContainer: AniScrollView!
    var newGoalCard: NewGoalCard!
    
    var skillsColor: UIColor!
    var tasksColor: UIColor!
    var goalsColor: UIColor!
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    
    var goalPos = Int()
    
    
    //Load AniViews in proper spot
    override func viewDidLoad() {
        super.viewDidLoad()
        
        skills = NSMutableArray(array: user.skills.allObjects)
        for skill in skills {
            let tasks = NSMutableArray(array: (skill as! Skill).tasks.allObjects)
            for task in tasks {
                if (task as! Task).completed == 0 {
                    currentTasks.addObject(task as! Task)
                    println("Taskname : \((task as! Task).taskName)")
                }
            }
        }
        
        
        
        headerView = AniView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = goalsColor
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        backButton.setTitle("< Back", forState: .Normal)
        backButton.setTitleColor(whiteColor, forState: .Normal)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = whiteColor
        headerLabel.textAlignment = NSTextAlignment.Center
        headerLabel.text = "New Goal"
        
        headerView.addSubview(backButton)
        headerView.addSubview(headerLabel)
        
        newGoalContainer = AniScrollView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: view.frame.height - 80))
        newGoalContainer.layer.borderWidth = 5.0
        newGoalContainer.layer.borderColor = goalsColor.CGColor
        newGoalContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
        newGoalContainer.contentSize = CGSize(width: newGoalContainer.frame.width, height: 12 + 80 + 12) //Extra padding + Card + Padding
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        
        
        newGoalCard = NewGoalCard(frame: CGRect(x: 12, y: 12, width: newGoalContainer.frame.width - 24, height: 80), goalPos: 0)
        newGoalCard.backgroundColor = whiteColor
        newGoalCard.layer.borderWidth = 4
        newGoalCard.layer.cornerRadius = 5.0
        newGoalCard.layer.borderColor = goalsColor.CGColor
        goalCards.addObject(newGoalCard)
        
        let newSkillCardButton = UIButton(frame: CGRect(x: 4, y: 4, width: newGoalCard.frame.width * 0.5, height: newGoalCard.frame.height - 8))
        newSkillCardButton.addTarget(self, action: "createNewSkillCard", forControlEvents: .TouchUpInside)
        newSkillCardButton.layer.borderWidth = 4
        //newSkillCardButton.layer.cornerRadius = 5
        newSkillCardButton.layer.borderColor = skillsColor.CGColor
        newSkillCardButton.backgroundColor = skillsColor
        newSkillCardButton.setTitle("Add Skill", forState: .Normal)
        newSkillCardButton.setTitleColor(whiteColor, forState: .Normal)
        newSkillCardButton.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        newSkillCardButton.titleLabel?.textAlignment = NSTextAlignment.Center
        let newTaskCardButton = UIButton(frame: CGRect(x: newGoalCard.frame.width * 0.5 + 4, y: 4, width: newGoalCard.frame.width * 0.5 - 8, height: newGoalCard.frame.height - 8))
        newTaskCardButton.addTarget(self, action: "createNewTaskCard", forControlEvents: .TouchUpInside)
        newTaskCardButton.layer.borderWidth = 4
        //newTaskCardButton.layer.cornerRadius = 5
        newTaskCardButton.layer.borderColor = tasksColor.CGColor
        newTaskCardButton.backgroundColor = tasksColor
        newTaskCardButton.setTitle("Add Task", forState: .Normal)
        newTaskCardButton.setTitleColor(whiteColor, forState: .Normal)
        newTaskCardButton.titleLabel?.font = UIFont(name: "Helvetica", size: 28.0)
        newTaskCardButton.titleLabel?.textAlignment = NSTextAlignment.Center
        
        newGoalCard.addSubview(newSkillCardButton)
        newGoalCard.addSubview(newTaskCardButton)
        
        newGoalContainer.addSubview(newGoalCard)
        goalPos = 1
        
        view.addSubview(headerView)
        view.addSubview(newGoalContainer)
        
    }
    
    //Move AniViews to off screen
    override func viewWillAppear(animated: Bool) {
        //
    }
    
    //Animate AniViews to proper spot
    override func viewDidAppear(animated: Bool) {
        //
    }
    
    //Need animations here
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //Populate Cards
    func populateGoalCards() {
        for card in goalCards {
            
        }
    }
    
    // Create a new Skill Card
    func createNewSkillCard() {
        let newSkillCard = NewGoalCard(frame: CGRect(x: 12, y: newGoalCard.frame.minY, width: newGoalContainer.frame.width - 24, height: 80), goalPos: goalPos)
        newSkillCard.backgroundColor = whiteColor
        newSkillCard.layer.borderWidth = 3
        newSkillCard.layer.cornerRadius = 5.0
        newSkillCard.layer.borderColor = skillsColor.CGColor
        newSkillCard.alpha = 0.0
        
        let skillPicker = SkillPicker(frame: CGRect(x: 8, y: -40, width: newSkillCard.frame.width * 0.6, height: 162.0))
        skillPicker.delegate = self
        skillPicker.dataSource = self
        
        //skillPicker.backgroundColor = skillsColor
        //skillPicker.
        
        newSkillCard.addSubview(skillPicker)
        
        newGoalContainer.addSubview(newSkillCard)
        newGoalContainer.contentSize.height += (newSkillCard.frame.height + 12)
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
            newSkillCard.alpha = 1.0
            }, completion: {
                (value: Bool) in
                
        })
        goalCards.addObject(newSkillCard)
        moveNewCardDown()
        
        goalPos++
    }
    
    // Create a new Task Card
    func createNewTaskCard() {
        let newTaskCard = NewGoalCard(frame: CGRect(x: 12, y: newGoalCard.frame.minY, width: newGoalContainer.frame.width - 24, height: 80), goalPos: goalPos)
        newTaskCard.backgroundColor = whiteColor
        newTaskCard.layer.borderWidth = 3
        newTaskCard.layer.cornerRadius = 5.0
        newTaskCard.layer.borderColor = tasksColor.CGColor
        newTaskCard.alpha = 0.0
        newGoalContainer.addSubview(newTaskCard)
        newGoalContainer.contentSize.height += (newTaskCard.frame.height + 12)
        
        let taskPicker = TaskPicker(frame: CGRect(x: 8, y: -40, width: newTaskCard.frame.width * 0.6, height: 162.0))
        taskPicker.delegate = self
        taskPicker.dataSource = self
        
        //skillPicker.backgroundColor = skillsColor
        //skillPicker.
        
        newTaskCard.addSubview(taskPicker)

        
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
            newTaskCard.alpha = 1.0
            }, completion: {
                (value: Bool) in
                
        })
        goalCards.addObject(newTaskCard)
        moveNewCardDown()
        
        goalPos++

    }
    
    func moveNewCardDown() {
        UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.newGoalCard.frame.origin.y += (80 + 12)
            }, completion: {
                (value: Bool) in
                
        })
        
    }
    
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView.isKindOfClass(SkillPicker) {
            return skills.count
        } else if pickerView.isKindOfClass(TaskPicker) {
            return currentTasks.count
        } else {
            return 5
        }
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 64.0
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
        if pickerView.isKindOfClass(SkillPicker) {
            return (skills.objectAtIndex(row) as! Skill).skillName
        } else if pickerView.isKindOfClass(TaskPicker) {
            return (currentTasks.objectAtIndex(row) as! Task).taskName
        } else {
            return "Missing!"
        }
        
    }
    
}
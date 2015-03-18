//
//  CreateSkillViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CreateSkillViewController : UIViewController {
    
    var user: User!
    
    var newSkillContainer: UIView!
    var newSkillOriginalButton: UIButton!
    var newSkillTemplateButton: UIButton!
    
    var newSkillOriginalContainer: UIView!
    var newSkillTemplateContainer: UIScrollView!
    
    var skillNameTextField: UITextField!
    var skillDescTextField: UITextField!
    //Needed
    //var skillCategoryTextField: UITextField!
    
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    //var parentVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = skillsColor
        let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        logoutButton.setTitle("< Back", forState: .Normal)
        logoutButton.setTitleColor(whiteColor, forState: .Normal)
        logoutButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = whiteColor
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "New Skill"
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(logoutButton)
        view.addSubview(headerView)
        
        newSkillContainer = UIView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: view.frame.height - 80))
        newSkillContainer.backgroundColor = whiteColor
        newSkillContainer.layer.borderWidth = 5.0
        newSkillContainer.layer.borderColor = skillsColor.CGColor
        
        //Original Button
        newSkillOriginalButton = UIButton(frame: CGRect(x: 0, y: 0, width: newSkillContainer.frame.width / 2 + 2.5, height: 44))
        newSkillOriginalButton.setTitle("From Scratch", forState: .Normal)
        newSkillOriginalButton.titleLabel?.textColor = UIColor(white: 0.0, alpha: 1.0)
        newSkillOriginalButton.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        newSkillOriginalButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        newSkillOriginalButton.addTarget(self, action: "newSkillOriginalTapped", forControlEvents: .TouchUpInside)
        newSkillOriginalButton.layer.borderWidth = 5.0
        newSkillOriginalButton.layer.borderColor = skillsColor.CGColor
        // Original Container
        newSkillOriginalContainer = UIView(frame: CGRect(x: 13, y: newSkillOriginalButton.frame.height, width: newSkillContainer.frame.width - 10, height: newSkillContainer.frame.height - 49))
        skillNameTextField = UITextField(frame: CGRect(x: newSkillOriginalContainer.frame.width / 4, y: 40, width: newSkillOriginalContainer.frame.width / 2, height: 40))
        skillNameTextField.borderStyle = UITextBorderStyle.RoundedRect
        skillNameTextField.placeholder = "Skill Name"
        skillNameTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        skillDescTextField = UITextField(frame: CGRect(x: newSkillOriginalContainer.frame.width / 5, y: 120, width: newSkillOriginalContainer.frame.width * 0.6, height: 40))
        skillDescTextField.borderStyle = UITextBorderStyle.RoundedRect
        skillDescTextField.placeholder = "Skill Description"
        skillDescTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        newSkillOriginalContainer.addSubview(skillNameTextField)
        newSkillOriginalContainer.addSubview(skillDescTextField)
        
        
        //Template Button
        newSkillTemplateButton = UIButton(frame: CGRect(x: newSkillContainer.frame.width / 2 - 2.5, y: 0, width: newSkillContainer.frame.width / 2 + 2.5, height: 44))
        newSkillTemplateButton.setTitle("Use Template", forState: .Normal)
        newSkillTemplateButton.titleLabel?.textColor = UIColor(white: 0.0, alpha: 1.0)
        newSkillTemplateButton.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        newSkillTemplateButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        newSkillTemplateButton.addTarget(self, action: "newSkillTemplateTapped", forControlEvents: .TouchUpInside)
        newSkillTemplateButton.layer.borderWidth = 5.0
        newSkillTemplateButton.layer.borderColor = skillsColor.CGColor
        
        
        
        let createSkillButton = UIButton(frame: CGRect(x: newSkillOriginalContainer.frame.width / 4, y: newSkillOriginalContainer.frame.height - 60, width: newSkillOriginalContainer.frame.width / 2, height: 30))
        createSkillButton.setTitle("Create", forState: .Normal)
        createSkillButton.titleLabel?.textColor = UIColor(white: 0.0, alpha: 1.0)
        createSkillButton.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        createSkillButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        createSkillButton.addTarget(self, action: "createSkillTapped", forControlEvents: .TouchUpInside)
        createSkillButton.layer.borderWidth = 5.0
        createSkillButton.layer.borderColor = skillsColor.CGColor
        
        newSkillOriginalContainer.addSubview(createSkillButton)
        
        newSkillContainer.addSubview(newSkillOriginalButton)
        newSkillContainer.addSubview(newSkillOriginalContainer)
        newSkillContainer.addSubview(newSkillTemplateButton)
        //newSkillContainer.addSubview(newSkillTemplateContainer)
        view.addSubview(newSkillContainer)
    }
    
    func createSkillTapped() {
        let managedContext = user.managedObjectContext!
        let skill = NSEntityDescription.insertNewObjectForEntityForName("Skill", inManagedObjectContext: managedContext) as Skill
        skill.skillName = skillNameTextField.text
        skill.skillDescription = skillDescTextField.text
        skill.level = 1
        skill.expNeeded = 100
        skill.expTotal = 100
        let userSkills = user.skills.mutableCopy() as NSMutableSet
        userSkills.addObject(skill)
        user.skills = userSkills
        if saveContext() {
            println("Skill Created")
        } else {
            println("Error Saving!")
        }
    }
    
    func saveContext() -> Bool {
        var error: NSError?
        if !user.managedObjectContext!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        return true
    }
    
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    func newSkillOriginalTapped() {
        newSkillContainer.bringSubviewToFront(newSkillOriginalContainer)
    }
    func newSkillTemplateTapped() {
        //newSkillContainer.bringSubviewToFront(newSkillTemplateContainer)
    }
    
    
}
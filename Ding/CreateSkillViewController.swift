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
    //var parentVC: HomeViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let createSkillButton = UIButton(frame: CGRect(x: 100, y: 200, width: 100, height: 30))
        createSkillButton.setTitle("Create", forState: .Normal)
        createSkillButton.titleLabel?.textColor = UIColor(white: 0.0, alpha: 1.0)
        createSkillButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        createSkillButton.addTarget(self, action: "createSkillTapped", forControlEvents: .TouchUpInside)
        
        let backButton = UIButton(frame: CGRect(x: view.frame.width / 2, y: view.frame.height / 2 + 200, width: 100, height: 30))
        backButton.setTitle("Back", forState: .Normal)
        backButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        backButton.addTarget(self, action: "backTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(createSkillButton)
        view.addSubview(backButton)
    }
    
    func createSkillTapped() {
        let managedContext = user.managedObjectContext!
        let skill = NSEntityDescription.insertNewObjectForEntityForName("Skill", inManagedObjectContext: managedContext) as Skill
        skill.skillName = "Guitar"
        skill.level = 1
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
    
    func backTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
//
//  HomeViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController : UIViewController {
    
    var user: User!
    var skills: NSMutableArray!
    var tasks: NSMutableArray!
    var goals: [Goal]!
    var achievements: [Achievement]!
    
    var optionsAreOpen: Bool!
    //This will track where the view came from so it knows how to appear/transition
    var transitionCameFrom: UIViewController!
    
    var userImageView: UIImageView!
    var userImage: UIImage!
    
    var headerView: UIView!
    var userContainerView: AniView!
    var optionsButton: AniButton!
    
    var optionsView: AniView!
    
    var skillsTab: AniButton!
    var tasksTab: AniButton!
    var goalsTab: AniButton!
    var achievementsTab: AniButton!
    var skillsContainer: UIScrollView!
    var tasksContainer: UIScrollView!
    var goalsContainer: UIScrollView!
    var achievementsContainer: UIScrollView!
    
    var detailsContainerView: AniView!
    var userNameLabel: AniLabel!
    var totalLevelLabel: AniLabel!
    
    var logoutButton: UIButton!
    var headerLabel: UILabel!
    
    var tasksCurrent: UIButton!
    var tasksSort: UIButton!
    var tasksSearch: UIButton!
    var tasksCompleted: UIButton!
    var tasksSelectedButton: UIButton!
    
    var tasksCurrentContainer: UIScrollView!
    var tasksSortContainer: UIScrollView!
    var tasksSearchContainer: UIScrollView!
    var tasksCompletedContainer: UIScrollView!
    
    var mainContainerView: AniView!
    
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let blackColor = UIColor(white: 0.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    //let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let skillsColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let goalsColor = UIColor(red: 51/255, green: 102/255, blue: 255/255, alpha: 1.0)
    let achievementsColor = UIColor(red: 102/255, green: 51/255, blue: 255/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*************************************************************
        // Everything that will transition can start OFFSCREEN in Load
        // Animate it all in ViewDidAppear
        //*************************************************************
        //
        
        
        
        /*************************************************************/
        
        optionsAreOpen = false
        
        
        userImage = UIImage(named: "philProfile")
        // Need tasks and Goals
        skills = NSMutableArray(array: user.skills.allObjects)
        tasks = NSMutableArray()
        for skill in skills {
            let moreTasks = NSMutableArray(array: (skill as Skill).tasks.allObjects)
            for task in moreTasks {
                tasks.addObject(task as Task)
            }
        }
        //skills = user.skills.mutableCopy() as NSMutableArray
        
        headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.addTarget(self, action: "logoutButtonTapped", forControlEvents: .TouchUpInside)
        logoutButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "Home"
        optionsButton = AniButton(frame: CGRect(x: headerView.frame.width - 48, y: 6, width: 32, height: 32))
        optionsButton.setImage(UIImage(named: "options-gear"), forState: .Normal)
        optionsButton.addTarget(self, action: "optionsButtonTapped", forControlEvents: .TouchUpInside)
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(logoutButton)
        headerView.addSubview(optionsButton)
        view.addSubview(headerView)
        
        ////  Options View ////
        optionsView = AniView(frame: CGRect(x: 8, y: 20 + headerView.frame.height, width: view.frame.width - 16, height: view.frame.height - 20 - headerView.frame.height - 8))
        optionsView.layer.borderColor = goldColor.CGColor
        optionsView.layer.borderWidth = 5.0
        optionsView.backgroundColor = whiteColor
        //optionsView.alpha = 0.0
        view.addSubview(optionsView)
        
        ////  Container Items  ////
        userContainerView = AniView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
        userContainerView.backgroundColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        let profileGR = UITapGestureRecognizer(target: self, action: "profileTapped")
        userContainerView.addGestureRecognizer(profileGR)
        userImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: userContainerView.frame.width - 16, height: 96))
        userImageView.image = UIImage(named: "philProfile")
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userContainerView.addSubview(userImageView)

        
        
        detailsContainerView = AniView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: 112))
        detailsContainerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        
        userNameLabel = AniLabel(frame: CGRect(x: userContainerView.frame.width + 8, y: 8, width: detailsContainerView.frame.width - userContainerView.frame.width - 16, height: userContainerView.frame.height / 2 - 12))
        userNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        userNameLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        userNameLabel.text = user.userName
        userNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        userNameLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        totalLevelLabel = AniLabel(frame: CGRect(x: userContainerView.frame.width + 8, y: userNameLabel.frame.height + 16, width: detailsContainerView.frame.width - userContainerView.frame.width - 16, height: userContainerView.frame.height / 2 - 12))
        totalLevelLabel.font = UIFont(name: "Helvetica", size: 18.0)
        totalLevelLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        totalLevelLabel.text = "Total Level:"
        totalLevelLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        
        detailsContainerView.addSubview(userContainerView)
        detailsContainerView.addSubview(userNameLabel)
        detailsContainerView.addSubview(totalLevelLabel)
        ///////////////////////////
        
        view.addSubview(detailsContainerView)
        
        // Main Container View
        let mainYPos = 20 + headerView.frame.height + 8 + userContainerView.frame.height + 8
        mainContainerView = AniView(frame: CGRect(x: 8, y: mainYPos, width: view.frame.width - 16, height: view.frame.height - mainYPos - 8))
        mainContainerView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.addSubview(mainContainerView)
        
        ////// Main Container SubViews ///////
        let tabWidth = mainContainerView.frame.width / 4
        //Skills Tab
        skillsTab = AniButton(frame: CGRect(x: 0, y: 0, width: tabWidth, height: 48))
        skillsTab.backgroundColor = skillsColor
        skillsTab.setTitle("Skills", forState: .Normal)
        skillsTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        skillsTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        skillsTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        skillsTab.addTarget(self, action: "skillsTabTapped", forControlEvents: .TouchUpInside)
        //Tasks Tab
        tasksTab = AniButton(frame: CGRect(x: tabWidth, y: 0, width: tabWidth, height: 48))
        tasksTab.backgroundColor = tasksColor
        tasksTab.setTitle("Tasks", forState: .Normal)
        tasksTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        tasksTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksTab.addTarget(self, action: "tasksTabTapped", forControlEvents: .TouchUpInside)
        //Goals Tab
        goalsTab = AniButton(frame: CGRect(x: tabWidth * 2, y: 0, width: tabWidth, height: 48))
        goalsTab.backgroundColor = goalsColor
        goalsTab.setTitle("Goals", forState: .Normal)
        goalsTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        goalsTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsTab.addTarget(self, action: "goalsTabTapped", forControlEvents: .TouchUpInside)
        //Achievements Tab
        achievementsTab = AniButton(frame: CGRect(x: tabWidth * 3, y: 0, width: tabWidth, height: 48))
        achievementsTab.backgroundColor = achievementsColor
        achievementsTab.setTitle("Achs", forState: .Normal)
        achievementsTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        achievementsTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        achievementsTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        achievementsTab.addTarget(self, action: "achievementsTabTapped", forControlEvents: .TouchUpInside)
        
        //Skills Container
        // Height of containers will be dynamic based on number of skills
        skillsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        skillsContainer.contentSize = CGSize(width: skillsContainer.frame.width, height: 1000)
        skillsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        skillsContainer.layer.borderWidth = 5.0
        skillsContainer.layer.borderColor = skillsColor.CGColor
        
        
        
        //Tasks Container
        tasksContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        tasksContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        tasksContainer.layer.borderWidth = 5.0
        tasksContainer.layer.borderColor = tasksColor.CGColor
        
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
        // Current Tasks Container - Populate on ViewWillAppear or ButtonPress
        tasksCurrentContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksCurrentContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 750)
        tasksCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        tasksContainer.addSubview(tasksCurrentContainer)
        tasksContainer.addSubview(tasksCurrent)

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
        // Completed Tasks Container - Populate on ViewWillAppear or ButtonPress
        tasksCompletedContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksCompletedContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: 750)
        tasksCompletedContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        tasksContainer.addSubview(tasksCompletedContainer)
        tasksContainer.addSubview(tasksCompleted)
        
        //Sort Tasks Button
        tasksSort = UIButton(frame: CGRect(x: 5 + tasksCurrent.frame.width * 2, y: 5, width: (tasksContainer.frame.width - 10) * 0.15, height: 30))
        tasksSort.addTarget(self, action: "tasksSortTapped", forControlEvents: .TouchUpInside)
        tasksSort.setTitle("Sort", forState: .Normal)
        tasksSort.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksSort.backgroundColor = tasksColor
        tasksSort.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksSort.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksSort.layer.borderWidth = 2.0
        tasksSort.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Sort Tasks Container - Populate on ViewWillAppear or ButtonPress
        tasksSortContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksSortContainer.contentSize = CGSize(width: tasksSortContainer.frame.width, height: 750)
        tasksSortContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        tasksContainer.addSubview(tasksSortContainer)
        tasksContainer.addSubview(tasksSort)
        
        //Search Tasks Button
        tasksSearch = UIButton(frame: CGRect(x: 5 + tasksCurrent.frame.width * 2 + tasksSort.frame.width, y: 5, width: (tasksContainer.frame.width - 10) * 0.15, height: 30))
        tasksSearch.addTarget(self, action: "tasksSearchTapped", forControlEvents: .TouchUpInside)
        tasksSearch.setTitle("Sear", forState: .Normal)
        tasksSearch.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksSearch.backgroundColor = tasksColor
        tasksSearch.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        tasksSearch.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksSearch.layer.borderWidth = 2.0
        tasksSearch.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Search Tasks Container - Populate on ViewWillAppear or ButtonPress
        tasksSearchContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: tasksContainer.frame.width - 10, height: tasksContainer.frame.height - 40))
        tasksSearchContainer.contentSize = CGSize(width: tasksSearchContainer.frame.width, height: 750)
        tasksSearchContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        tasksContainer.addSubview(tasksSearchContainer)
        tasksContainer.addSubview(tasksSearch)
        
        
        //Set selected
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        tasksSelectedButton = tasksCurrent
        
        /*
        println("tasks CuContainer Min X: \(tasksCurrentContainer.frame.minX)")
        println("tasks CuContainer Min Y: \(tasksCurrentContainer.frame.minY)")
        println("tasks CuContainer Max X: \(tasksCurrentContainer.frame.maxX)")
        println("tasks CuContainer Max Y: \(tasksCurrentContainer.frame.maxY)")
        println("tasks CuContainer Width: \(tasksCurrentContainer.frame.width)")
        println("tasks CuContainer Height: \(tasksCurrentContainer.frame.height)")
        */

        
        
        
        //Goals Container
        goalsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        goalsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.layer.borderWidth = 5.0
        goalsContainer.layer.borderColor = goalsColor.CGColor
        //Achievements Container
        achievementsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        achievementsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.layer.borderWidth = 5.0
        achievementsContainer.layer.borderColor = achievementsColor.CGColor
        
        
        mainContainerView.addSubview(skillsTab)
        mainContainerView.addSubview(tasksTab)
        mainContainerView.addSubview(goalsTab)
        mainContainerView.addSubview(achievementsTab)
        
        mainContainerView.addSubview(skillsContainer)
        mainContainerView.addSubview(tasksContainer)
        mainContainerView.addSubview(goalsContainer)
        mainContainerView.addSubview(achievementsContainer)
        mainContainerView.bringSubviewToFront(skillsContainer)
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
//        //Dimension prints
//        println("Skills Container Min X: \(skillsContainer.frame.minX)")
//        println("Skills Container Min Y: \(skillsContainer.frame.minY)")
//        println("Skills Container Max X: \(skillsContainer.frame.maxX)")
//        println("Skills Container Max Y: \(skillsContainer.frame.maxY)")
//        println("Skills Container Width: \(skillsContainer.frame.width)")
//        println("Skills Container Height: \(skillsContainer.frame.height)")
        
        
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
        
        //Reset all the animated views!
        //resetView()
    }
    
    override func viewWillAppear(animated: Bool) {
        //** Put animations and such in all the offscreen places depending on child
        // Login Transitions
        if transitionCameFrom.isMemberOfClass(LoginViewController) {
                detailsContainerView.frame.origin = CGPoint(x: -detailsContainerView.frame.width - 16, y: detailsContainerView.frame.minY)
                mainContainerView.frame.origin = CGPoint(x: mainContainerView.frame.minX, y: view.frame.height)
        }
        //Profile Transitions
        if transitionCameFrom.isMemberOfClass(ProfileViewController) {
            
        }
        //Skill Transitions
        if transitionCameFrom.isMemberOfClass(SkillsViewController) {
             self.userContainerView.backgroundColor = self.skillsColor
        }
       
        optionsView.frame = CGRect(x: 8, y: 20 + headerView.frame.height, width: view.frame.width - 16, height: 0)
        //*************************************************************************
        
        userImageView.image = userImage
        //self.detailsContainerView.backgroundColor = whiteColor
        self.userNameLabel.alpha = 1.0
        self.totalLevelLabel.alpha = 1.0
        self.mainContainerView.alpha = 1.0
        //Fetch Skills, Populate Skills
        //Clean up old subviews
        for view in skillsContainer.subviews {
            view.removeFromSuperview()
        }
        
        skills = NSMutableArray(array: user.skills.allObjects)
        var position = 0, columnOne = true
        var row = 0
        for skill in skills {
            row = position / 2
            if columnOne { // First Column
                //Add Gesture Recognizers to tap and go to skill
                let skillCard = SkillCard(frame: CGRect(x: 8, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), skill: skill as Skill)
                let tapGR = UITapGestureRecognizer(target: self, action: "skillCardTapped:")
                skillCard.addGestureRecognizer(tapGR)
                
                let skillIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
                skillIcon.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                skillIcon.layer.borderWidth = 1.0
                skillIcon.layer.cornerRadius = 5.0
                let skillNameLabel = UILabel(frame: CGRect(x: 48, y: 0, width: skillCard.frame.width - 48, height: 48))
                skillNameLabel.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                skillNameLabel.layer.borderWidth = 1.0
                skillNameLabel.layer.cornerRadius = 5.0
                skillNameLabel.text = skillCard.skill.skillName
                skillNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
                skillNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
                skillNameLabel.font = UIFont(name: "Helvetica", size: 16.0)
                let levelText = UITextView(frame: CGRect(x: 0, y: 48, width: skillCard.frame.width, height: 40))
                levelText.text = "Level: \(skillCard.skill.level)"
                levelText.font = UIFont(name: "Helvetica", size: 16.0)
                levelText.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                levelText.selectable = false
                levelText.editable = false
                let expBarContainer = UIView(frame: CGRect(x: 0, y: 88, width: skillCard.frame.width, height: 40))
                expBarContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                expBarContainer.layer.cornerRadius = 5.0
                let expBarEmpty = UIView(frame: CGRect(x: 8, y: 0, width: skillCard.frame.width - 16, height: 20))
                expBarEmpty.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                expBarEmpty.layer.borderColor = skillsColor.CGColor
                expBarEmpty.layer.borderWidth = 2.0
                expBarEmpty.layer.cornerRadius = 10.0
                
                //Animation Testing
                let expBarFull = UIView(frame: CGRect(x: 8, y: 0, width: 0, height: 20))
                expBarFull.backgroundColor = goldColor
                if skillCard.skill.expCurrent != 0 {
                    UIView.animateWithDuration(2.0, animations: {
                        let expCurrent = Float(skillCard.skill.expCurrent)
                        let actualWidth = CGFloat(Float(expBarEmpty.frame.width) * (expCurrent / Float(skillCard.skill.expTotal)))
                        expBarFull.frame = CGRect(x: 8, y: 0, width: actualWidth, height: 20)
                        }, completion: {
                            (value: Bool) in
                    })
                    //expBarFull.layer.borderColor = skillsColor.CGColor
                    //expBarFull.layer.borderWidth = 2.0
                    expBarFull.layer.cornerRadius = 10.0
                    let topExpBorder = CALayer()
                    topExpBorder.frame = CGRectMake(0, 0, expBarFull.frame.width, 2.0)
                    topExpBorder.backgroundColor = skillsColor.CGColor
                    let leftExpBorder = CALayer()
                    leftExpBorder.frame = CGRectMake(0, 0, 2.0, expBarFull.frame.height)
                    leftExpBorder.backgroundColor = skillsColor.CGColor
                    let bottomExpBorder = CALayer()
                    bottomExpBorder.frame = CGRectMake(0, expBarFull.frame.height - 2.0, expBarFull.frame.width, 2.0)
                    bottomExpBorder.backgroundColor = skillsColor.CGColor
                    expBarFull.layer.addSublayer(topExpBorder)
                    expBarFull.layer.addSublayer(leftExpBorder)
                    expBarFull.layer.addSublayer(bottomExpBorder)
                }
                
                
                expBarContainer.addSubview(expBarEmpty)
                expBarContainer.addSubview(expBarFull)
                skillCard.addSubview(skillIcon)
                skillCard.addSubview(skillNameLabel)
                skillCard.addSubview(levelText)
                skillCard.addSubview(expBarContainer)
                skillsContainer.addSubview(skillCard)
            } else { // Second Column
                let skillCard = SkillCard(frame: CGRect(x: skillsContainer.frame.width / 2 + 4, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), skill: skill as Skill)
                let tapGR = UITapGestureRecognizer(target: self, action: "skillCardTapped:")
                skillCard.addGestureRecognizer(tapGR)
                
                let skillIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: 48, height: 48))
                skillIcon.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                skillIcon.layer.borderWidth = 1.0
                skillIcon.layer.cornerRadius = 5.0
                let skillNameLabel = UILabel(frame: CGRect(x: 48, y: 0, width: skillCard.frame.width - 48, height: 48))
                skillNameLabel.layer.borderColor = UIColor(white: 0.0, alpha: 1.0).CGColor
                skillNameLabel.layer.borderWidth = 1.0
                skillNameLabel.layer.cornerRadius = 5.0
                skillNameLabel.text = skillCard.skill.skillName
                skillNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
                skillNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
                skillNameLabel.font = UIFont(name: "Helvetica", size: 16.0)
                let levelText = UITextView(frame: CGRect(x: 0, y: 48, width: skillCard.frame.width, height: 40))
                levelText.text = "Level: \(skillCard.skill.level)"
                levelText.font = UIFont(name: "Helvetica", size: 16.0)
                levelText.selectable = false
                levelText.editable = false
                levelText.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                let expBarContainer = UIView(frame: CGRect(x: 0, y: 88, width: skillCard.frame.width, height: 40))
                expBarContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                expBarContainer.layer.cornerRadius = 5.0
                let expBarEmpty = UIView(frame: CGRect(x: 8, y: 0, width: skillCard.frame.width - 16, height: 20))
                expBarEmpty.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                expBarEmpty.layer.borderColor = skillsColor.CGColor
                expBarEmpty.layer.borderWidth = 2.0
                expBarEmpty.layer.cornerRadius = 10.0
                //Animation Testing
                let expBarFull = UIView(frame: CGRect(x: 8, y: 0, width: 0, height: 20))
                expBarFull.backgroundColor = goldColor
                if skillCard.skill.expCurrent != 0 {
                    UIView.animateWithDuration(2.0, animations: {
                        let expCurrent = Float(skillCard.skill.expCurrent)
                        let actualWidth = CGFloat(Float(expBarEmpty.frame.width) * (expCurrent / Float(skillCard.skill.expTotal)))
                        expBarFull.frame = CGRect(x: 8, y: 0, width: actualWidth, height: 20)
                        }, completion: {
                            (value: Bool) in
                    })
                    //expBarFull.layer.borderColor = skillsColor.CGColor
                    //expBarFull.layer.borderWidth = 2.0
                    expBarFull.layer.cornerRadius = 10.0
                    let topExpBorder = CALayer()
                    topExpBorder.frame = CGRectMake(0, 0, expBarFull.frame.width, 2.0)
                    topExpBorder.backgroundColor = skillsColor.CGColor
                    let leftExpBorder = CALayer()
                    leftExpBorder.frame = CGRectMake(0, 0, 2.0, expBarFull.frame.height)
                    leftExpBorder.backgroundColor = skillsColor.CGColor
                    let bottomExpBorder = CALayer()
                    bottomExpBorder.frame = CGRectMake(0, expBarFull.frame.height - 2.0, expBarFull.frame.width, 2.0)
                    bottomExpBorder.backgroundColor = skillsColor.CGColor
                    expBarFull.layer.addSublayer(topExpBorder)
                    expBarFull.layer.addSublayer(leftExpBorder)
                    expBarFull.layer.addSublayer(bottomExpBorder)
                }
                
                expBarContainer.addSubview(expBarEmpty)
                expBarContainer.addSubview(expBarFull)
                skillCard.addSubview(skillIcon)
                skillCard.addSubview(skillNameLabel)
                skillCard.addSubview(levelText)
                skillCard.addSubview(expBarContainer)
                skillsContainer.addSubview(skillCard)
            }
            columnOne = !columnOne
            position++
        }
        
        /////////// Add a new Skill, last card /////////////
        if columnOne {
            row = position / 2
            let newSkillCard = UIView(frame: CGRect(x: 8, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128))
            let skillNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: newSkillCard.frame.width, height: newSkillCard.frame.height))
            newSkillCard.layer.cornerRadius = 5.0
            newSkillCard.layer.borderWidth = 2.0
            newSkillCard.layer.borderColor = skillsColor.CGColor
            newSkillCard.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            skillNameLabel.text = "New!"
            skillNameLabel.textAlignment = NSTextAlignment.Center
            skillNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
            skillNameLabel.font = UIFont(name: "Helvetica", size: 24.0)
            newSkillCard.addSubview(skillNameLabel)
            skillsContainer.addSubview(newSkillCard)
            let tapNewSkill = UITapGestureRecognizer(target: self, action: "newSkillTapped:")
            newSkillCard.addGestureRecognizer(tapNewSkill)
        } else {
            row = position / 2
            let newSkillCard = UIView(frame: CGRect(x: skillsContainer.frame.width / 2 + 4, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128))
            let skillNameLabel = UILabel(frame: CGRect(x: 0, y: 0, width: newSkillCard.frame.width, height: newSkillCard.frame.height))
            newSkillCard.layer.cornerRadius = 5.0
            newSkillCard.layer.borderWidth = 2.0
            newSkillCard.layer.borderColor = skillsColor.CGColor
            newSkillCard.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
            skillNameLabel.text = "New!"
            skillNameLabel.textAlignment = NSTextAlignment.Center
            skillNameLabel.textColor = UIColor(white: 0.0, alpha: 1.0)
            skillNameLabel.font = UIFont(name: "Helvetica", size: 24.0)
            newSkillCard.addSubview(skillNameLabel)
            skillsContainer.addSubview(newSkillCard)
            let tapNewSkill = UITapGestureRecognizer(target: self, action: "newSkillTapped:")
            newSkillCard.addGestureRecognizer(tapNewSkill)
        }
        ///////////////////////////////////////////////////////
        
        
    }
    
    override func viewDidAppear(animated: Bool) {
        //** Now Animate all of the views into their proper position
        
        //Login Transitions
        if transitionCameFrom.isMemberOfClass(LoginViewController) {
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.detailsContainerView.frame.origin = self.detailsContainerView.originalOrigin
                }, completion: {
                    (value: Bool) in
                    
            })
            UIView.animateWithDuration(1.0, delay: 0.2, options: .CurveEaseOut, animations: {
                self.mainContainerView.frame.origin = self.mainContainerView.originalOrigin
                }, completion: {
                    (value: Bool) in
                    
            })
        }
        
        //Profile Transitions
        if transitionCameFrom.isMemberOfClass(ProfileViewController) {
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.mainContainerView.frame.origin = self.mainContainerView.originalOrigin
            }, completion: {
                (value: Bool) in
                //Tabs
                //Skills
                UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.skillsTab.frame = self.skillsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.skillsTab.setTitle("Skills", forState: .Normal)
                })
                //Tasks
                UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseInOut, animations: {
                    self.tasksTab.frame = self.tasksTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.tasksTab.setTitle("Tasks", forState: .Normal)
                })
                //Goals
                UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseInOut, animations: {
                    self.goalsTab.frame = self.goalsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.goalsTab.setTitle("Goals", forState: .Normal)
                })
                //Achievements
                UIView.animateWithDuration(0.2, delay: 0.3, options: .CurveEaseInOut, animations: {
                    self.achievementsTab.frame = self.achievementsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.achievementsTab.setTitle("Achs", forState: .Normal)
                })
            })
            //Labels into container view
            UIView.animateWithDuration(0.4, delay: 1.5, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.detailsContainerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                self.userNameLabel.frame.origin = self.userNameLabel.originalOrigin
            }, completion: {
                (value: Bool) in
                    
            })
            UIView.animateWithDuration(0.4, delay: 1.7, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.totalLevelLabel.frame.origin = self.totalLevelLabel.originalOrigin
                }, completion: {
                    (value: Bool) in
                    
            })
        }
        
        //Skill Transition
        if transitionCameFrom.isMemberOfClass(SkillsViewController) {
            UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: {
                self.userImageView.alpha = 1.0
                self.userContainerView.backgroundColor = self.goldColor
                }, completion: {
                    (value: Bool) in
                    
            })
            resetMainContainer()
            //User Name Label frame
            UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseInOut, animations: {
                self.userNameLabel.frame.origin = self.userNameLabel.originalOrigin
                }, completion: {
                    (value: Bool) in
                    
            })
            //Total Level Label
            UIView.animateWithDuration(0.5, delay: 0.7, options: .CurveEaseInOut, animations: {
                self.totalLevelLabel.frame.origin = self.totalLevelLabel.originalOrigin
                }, completion: {
                    (value: Bool) in
                    
            })
            
            
        }
        
    }
    
    @IBAction func logoutTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logoutButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    //PDAlert: Bugged, rotates twice the same way at first
    func optionsButtonTapped() {
        if let optionBool = optionsAreOpen {
            if !optionBool {
                println("OptionAreOpen : \(optionsAreOpen)")
                println("Spin 90 Deg")
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.optionsButton.transform = CGAffineTransformMakeRotation(-90.0)
                    self.view.bringSubviewToFront(self.optionsView)
                    self.optionsView.frame = self.optionsView.originalFrame
                    //self.optionsView.alpha = 1.0
                }, completion: nil)
            } else {
                println("OptionAreOpen : \(optionsAreOpen)")
                println("Spin -90 Deg")
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.optionsButton.transform = CGAffineTransformMakeRotation(90.0)
                    self.optionsView.frame = CGRect(x: 8, y: 20 + self.headerView.frame.height, width: self.view.frame.width - 16, height: 0)
                    //self.optionsView.alpha = 0.0
                }, completion: nil)
            }
        }
       
        optionsAreOpen = !optionsAreOpen

        
    }
    
    func skillCardTapped(gr: UITapGestureRecognizer) {
        let skillTapped = (gr.view as SkillCard).skill
        //let skillsVC = storyboard?.instantiateViewControllerWithIdentifier("SkillsViewController") as SkillsViewController
        let skillsVC = SkillsViewController()
        skillsVC.user = user
        skillsVC.skill = skillTapped
        transitionCameFrom = skillsVC
        
        //////////* Animate */////////
        let skillHeaderView = AniView(frame: CGRect(x: 0, y: view.frame.height + 8, width: view.frame.width, height: 44))
        skillHeaderView.backgroundColor = skillsColor
        let skillBackButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        skillBackButton.setTitle("< Back", forState: .Normal)
        skillBackButton.setTitleColor(whiteColor, forState: .Normal)
        let skillHeaderLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        skillHeaderLabel.font = UIFont(name: "Helvetica", size: 24.0)
        skillHeaderLabel.textColor = whiteColor
        skillHeaderLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        skillHeaderLabel.text = "\(skillTapped.skillName)"
        skillHeaderView.addSubview(skillBackButton)
        skillHeaderView.addSubview(skillHeaderLabel)
        view.addSubview(skillHeaderView)
        //Animate
        //Skills Tab
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseIn, animations: {
            self.skillsTab.frame = CGRect(x: self.skillsTab.frame.minX, y: self.skillsTab.frame.maxY, width: self.skillsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.skillsTab.setTitle("", forState: .Normal)
        })
        //Tasks Tab
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseIn, animations: {
            self.tasksTab.frame = CGRect(x: self.tasksTab.frame.minX, y: self.tasksTab.frame.maxY, width: self.tasksTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.tasksTab.setTitle("", forState: .Normal)
        })
        //Goals Tab
        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseIn, animations: {
            self.goalsTab.frame = CGRect(x: self.goalsTab.frame.minX, y: self.goalsTab.frame.maxY, width: self.goalsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.goalsTab.setTitle("", forState: .Normal)
        })
        //Achievements Tab
        UIView.animateWithDuration(0.2, delay: 0.3, options: .CurveEaseIn, animations: {
            self.achievementsTab.frame = CGRect(x: self.achievementsTab.frame.minX, y: self.achievementsTab.frame.maxY, width: self.achievementsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.achievementsTab.setTitle("", forState: .Normal)
        })
        //Main Container and Image View
        UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseIn, animations: {
            self.mainContainerView.frame.origin = CGPoint(x: self.mainContainerView.frame.minX, y: self.view.frame.height + 8)
            self.userImageView.alpha = 0.0
            }, completion: {
                (value: Bool) in
        })
        //User Name Label frame
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseInOut, animations: {
            self.userNameLabel.frame.origin = CGPoint(x: self.view.frame.width + 16, y: self.userNameLabel.frame.minY)
            }, completion: {
                (value: Bool) in
                
        })
        //Total Level Label
        UIView.animateWithDuration(0.5, delay: 0.7, options: .CurveEaseInOut, animations: {
            self.totalLevelLabel.frame.origin = CGPoint(x: self.view.frame.width + 16, y: self.totalLevelLabel.frame.minY)
            }, completion: {
                (value: Bool) in
                
        })
        //Add Fake header, then transition
        UIView.animateWithDuration(0.8, delay: 1.5, options: .CurveEaseInOut, animations: {
                skillHeaderView.frame.origin = CGPoint(x: 0, y: 20)
            }, completion: {
                (value: Bool) in
                self.presentViewController(skillsVC, animated: false, completion: {
                    skillHeaderView.removeFromSuperview()
                })
        })

        
        
        
    }
    
    func newSkillTapped(gr: UITapGestureRecognizer) {
        let createSkillVC = storyboard?.instantiateViewControllerWithIdentifier("CreateSkillViewController") as CreateSkillViewController
        createSkillVC.user = user
        createSkillVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        transitionCameFrom = createSkillVC
        
        
        //** Time to animate some shiiiiii **////
        
        
        
        
        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        presentViewController(createSkillVC, animated: true, completion: nil)
    }
    
    //Go to ProfileVC After tapping User Image
    func profileTapped() {
        view.userInteractionEnabled = false
        let profileVC = ProfileViewController()
        profileVC.user = user
        profileVC.parentVC = self
        transitionCameFrom = profileVC
        
        //Profile Bounce
        let currentProfileFrame = userImageView.frame
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
            self.userImageView.frame = CGRect(x: currentProfileFrame.minX - 8, y: currentProfileFrame.minY - 8, width: currentProfileFrame.width + 16, height: currentProfileFrame.height + 16)
        }, completion: {
            (value: Bool) in
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                self.userImageView.frame = currentProfileFrame
            }, completion: nil)
        })
        
        //Skills Tab
        UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseIn, animations: {
            self.skillsTab.frame = CGRect(x: self.skillsTab.frame.minX, y: self.skillsTab.frame.maxY, width: self.skillsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.skillsTab.setTitle("", forState: .Normal)
        })
        //Tasks Tab
        UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseIn, animations: {
            self.tasksTab.frame = CGRect(x: self.tasksTab.frame.minX, y: self.tasksTab.frame.maxY, width: self.tasksTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.tasksTab.setTitle("", forState: .Normal)
        })
        //Goals Tab
        UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseIn, animations: {
            self.goalsTab.frame = CGRect(x: self.goalsTab.frame.minX, y: self.goalsTab.frame.maxY, width: self.goalsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.goalsTab.setTitle("", forState: .Normal)
        })
        //Achievements Tab
        UIView.animateWithDuration(0.2, delay: 0.3, options: .CurveEaseIn, animations: {
            self.achievementsTab.frame = CGRect(x: self.achievementsTab.frame.minX, y: self.achievementsTab.frame.maxY, width: self.achievementsTab.frame.width, height: 0)
            }, completion: {
                (value: Bool) in
                self.achievementsTab.setTitle("", forState: .Normal)
        })
        //Username Label
        UIView.animateWithDuration(0.5, delay: 0.5, options: .CurveEaseIn, animations: {
            self.userNameLabel.frame.origin = CGPoint(x: self.view.frame.width, y: self.userNameLabel.frame.minY)
            }, completion: {
                (value: Bool) in
                
        })
        //Total Level Label
        UIView.animateWithDuration(0.5, delay: 0.7, options: .CurveEaseIn, animations: {
            self.totalLevelLabel.frame.origin = CGPoint(x: self.view.frame.width, y: self.totalLevelLabel.frame.minY)
            }, completion: {
                (value: Bool) in
                
        })
        //Main Container View + Details Container Background Color
        UIView.animateWithDuration(1.0, delay: 0.5, options: .CurveEaseIn, animations: {
            self.mainContainerView.frame.origin = CGPoint(x: self.mainContainerView.frame.minX, y: self.view.frame.height + 50)
            self.detailsContainerView.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
            }, completion: {
                (value: Bool) in
                self.view.userInteractionEnabled = true
                self.presentViewController(profileVC, animated: true, completion: nil)
        })
        
    }
    
    //Used for putting back buttons and container frame
    func resetMainContainer() {
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.mainContainerView.frame.origin = self.mainContainerView.originalOrigin
            }, completion: {
                (value: Bool) in
                //Tabs
                //Skills
                UIView.animateWithDuration(0.2, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.skillsTab.frame = self.skillsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.skillsTab.setTitle("Skills", forState: .Normal)
                })
                //Tasks
                UIView.animateWithDuration(0.2, delay: 0.1, options: .CurveEaseInOut, animations: {
                    self.tasksTab.frame = self.tasksTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.tasksTab.setTitle("Tasks", forState: .Normal)
                })
                //Goals
                UIView.animateWithDuration(0.2, delay: 0.2, options: .CurveEaseInOut, animations: {
                    self.goalsTab.frame = self.goalsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.goalsTab.setTitle("Goals", forState: .Normal)
                })
                //Achievements
                UIView.animateWithDuration(0.2, delay: 0.3, options: .CurveEaseInOut, animations: {
                    self.achievementsTab.frame = self.achievementsTab.originalFrame
                    }, completion: {
                        (value: Bool) in
                        self.achievementsTab.setTitle("Achs", forState: .Normal)
                })
        })

    }
    //Make a Reset function!!
    ////////////////////
    func resetView() {
        // Use in viewDidDisappear
        
        //Reset Main ContainerView
        let mainYPos = 20 + headerView.frame.height + 8 + userContainerView.frame.height + 8
        self.mainContainerView.frame.origin = CGPoint(x: self.mainContainerView.frame.minX, y: mainYPos)
        //Reset Tab Buttons
        let tabWidth = mainContainerView.frame.width / 4
        skillsTab.frame = CGRect(x: 0, y: 0, width: tabWidth, height: 48)
        skillsTab.setTitle("Skills", forState: .Normal)
        tasksTab.frame = CGRect(x: tabWidth, y: 0, width: tabWidth, height: 48)
        tasksTab.setTitle("Tasks", forState: .Normal)
        goalsTab.frame = CGRect(x: tabWidth * 2, y: 0, width: tabWidth, height: 48)
        goalsTab.setTitle("Goals", forState: .Normal)
        achievementsTab.frame = CGRect(x: tabWidth * 3, y: 0, width: tabWidth, height: 48)
        achievementsTab.setTitle("Achs", forState: .Normal)
        //Username and Total Level labels
        userNameLabel.frame.origin = CGPoint(x: userContainerView.frame.width + 8, y: 8)
        totalLevelLabel.frame.origin = CGPoint(x: userContainerView.frame.width + 8, y: userNameLabel.frame.height + 16)
        //Details Container BG Color
        detailsContainerView.backgroundColor = whiteColor
    }
    //////////////////
    
    //Main Container Tabs
    func skillsTabTapped() {
        mainContainerView.bringSubviewToFront(skillsContainer)
        let currentFrame = skillsTab.frame
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.skillsTab.frame = CGRect(x: currentFrame.minX, y: currentFrame.minY - 30, width: currentFrame.width, height: currentFrame.height + 30)
        }, completion: {
            (value: Bool) in
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                self.skillsTab.frame = self.skillsTab.originalFrame
            }, completion: nil)

        })
        
        //Set Tasks Back
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        
    }
    func tasksTabTapped() {
        let currentFrame = tasksTab.frame
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.tasksTab.frame = CGRect(x: currentFrame.minX, y: currentFrame.minY - 30, width: currentFrame.width, height: currentFrame.height + 30)
        }, completion: {
            (value: Bool) in
            UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                self.tasksTab.frame = self.tasksTab.originalFrame
            }, completion: nil)
        })
        
        
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        mainContainerView.bringSubviewToFront(tasksContainer)
    }
    func goalsTabTapped() {
        mainContainerView.bringSubviewToFront(goalsContainer)
        
        let currentFrame = goalsTab.frame
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.goalsTab.frame = CGRect(x: currentFrame.minX, y: currentFrame.minY - 30, width: currentFrame.width, height: currentFrame.height + 30)
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                    self.goalsTab.frame = self.goalsTab.originalFrame
                    }, completion: nil)
        })
        
        
        //Set Tasks Back
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
    }
    func achievementsTabTapped() {
        mainContainerView.bringSubviewToFront(achievementsContainer)
        
        let currentFrame = achievementsTab.frame
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveEaseInOut, animations: {
            self.achievementsTab.frame = CGRect(x: currentFrame.minX, y: currentFrame.minY - 30, width: currentFrame.width, height: currentFrame.height + 30)
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                    self.achievementsTab.frame = self.achievementsTab.originalFrame
                    }, completion: nil)
        })
        
        //Set Tasks Back
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
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
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksSort
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksSortContainer)
    }
    func tasksSearchTapped() {
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksSearch
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksSearchContainer)
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

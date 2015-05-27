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
    var currentTasks: NSMutableArray!
    var completedTasks: NSMutableArray!
    var goals: [Goal]!
    var currentGoals: NSMutableArray!
    var completedGoals: NSMutableArray!
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
    var optionsColorSchemeLabel: AniLabel!
    var optionsColorSchemeScrollView: UIScrollView!
    var optionsVoicePackLabel: AniLabel!
    var optionsVoicePackScrollView: UIScrollView!
    
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
    
    var totalLevel: Int = 0
    
    var tasksCurrent: UIButton!
    var tasksSort: UIButton!
    var tasksSearch: UIButton!
    var tasksCompleted: UIButton!
    var tasksSelectedButton: UIButton!
    
    var tasksCurrentContainer: UIScrollView!
    var tasksSortContainer: UIScrollView!
    var tasksSearchContainer: UIScrollView!
    var tasksCompletedContainer: UIScrollView!
    
    var goalsCurrent: UIButton!
    var goalsSort: UIButton!
    var goalsSearch: UIButton!
    var goalsCompleted: UIButton!
    var goalsSelectedButton: UIButton!
    
    var goalsCurrentContainer: UIScrollView!
    var goalsSortContainer: UIScrollView!
    var goalsSearchContainer: UIScrollView!
    var goalsCompletedContainer: UIScrollView!
    
    var achievementsCurrent: UIButton!
    var achievementsSort: UIButton!
    var achievementsSearch: UIButton!
    var achievementsCompleted: UIButton!
    var achievementsSelectedButton: UIButton!
    
    var achievementsCurrentContainer: UIScrollView!
    var achievementsSortContainer: UIScrollView!
    var achievementsSearchContainer: UIScrollView!
    var achievementsCompletedContainer: UIScrollView!
    
    var mainContainerView: AniView!
    
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let blackColor = UIColor(white: 0.0, alpha: 1.0)
    /*
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let skillsColor = UIColor(red: 0.0, green: 0.8, blue: 0.0, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let goalsColor = UIColor(red: 51/255, green: 102/255, blue: 255/255, alpha: 1.0)
    let achievementsColor = UIColor(red: 102/255, green: 51/255, blue: 255/255, alpha: 1.0)
    */
    
    var goldColor: UIColor!
    var skillsColor: UIColor!
    var tasksColor: UIColor!
    var goalsColor: UIColor!
    var achievementsColor: UIColor!
    
    
    var colorSchemes: NSMutableArray!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //*************************************************************
        // Everything that will transition can start OFFSCREEN in Load
        // Animate it all in ViewDidAppear
        //*************************************************************
        //
        
        
        //////////// Color Scheme ///////////////
        var colorSchemeSelection = user.colorScheme as Int
        goldColor = (colorSchemes.objectAtIndex(colorSchemeSelection) as! ColorScheme).home
        skillsColor = (colorSchemes.objectAtIndex(colorSchemeSelection) as! ColorScheme).skills
        tasksColor = (colorSchemes.objectAtIndex(colorSchemeSelection) as! ColorScheme).tasks
        goalsColor = (colorSchemes.objectAtIndex(colorSchemeSelection) as! ColorScheme).goals
        achievementsColor = (colorSchemes.objectAtIndex(colorSchemeSelection) as! ColorScheme).achievements
        
        /*************************************************************/
        
        optionsAreOpen = false
        
        
        userImage = UIImage(named: "philProfile")
        // Need tasks and Goals
        skills = NSMutableArray(array: user.skills.allObjects)
        currentTasks = NSMutableArray()
        totalLevel = 0
        for skill in skills {
            let moreTasks = NSMutableArray(array: (skill as! Skill).tasks.allObjects)
            for task in moreTasks {
                currentTasks.addObject(task as! Task)
            }
            totalLevel += Int((skill as! Skill).level)
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
        
        ////////////////////     Options View     ////////////////////////////
        optionsView = AniView(frame: CGRect(x: 8, y: 20 + headerView.frame.height, width: view.frame.width - 16, height: view.frame.height - 20 - headerView.frame.height - 8))
        optionsView.layer.borderColor = goldColor.CGColor
        optionsView.layer.borderWidth = 5.0
        optionsView.backgroundColor = whiteColor
        //optionsView.alpha = 0.0
        
        optionsColorSchemeLabel = AniLabel(frame: CGRect(x: 5, y: 5, width: optionsView.frame.width - 10, height: 50))
        optionsColorSchemeLabel.text = "Color Scheme"
        optionsColorSchemeLabel.font = UIFont(name: "Helvetica", size: 24.0)
        optionsColorSchemeLabel.textAlignment = NSTextAlignment.Center
        optionsColorSchemeLabel.textColor = goldColor
        optionsColorSchemeLabel.alpha = 0.0
        //Clicking a Scheme will drop down the scroll view to reveal the colors
        optionsColorSchemeScrollView = UIScrollView(frame: CGRect(x: 20, y: 5 + optionsColorSchemeLabel.frame.height, width: optionsView.frame.width - 40, height: 80))
        optionsColorSchemeScrollView.layer.borderWidth = 3.0
        optionsColorSchemeScrollView.layer.cornerRadius = 10.0
        optionsColorSchemeScrollView.layer.borderColor = goldColor.CGColor
        optionsColorSchemeScrollView.contentSize = CGSize(width: 750, height: 80) // Will adjust with amount of schemes
        optionsColorSchemeScrollView.alpha = 0.0
        var pos = 0
        for scheme in colorSchemes {
            //Should be custom uiviews with scheme
            let schemeImageView = ColorSchemeView(frame: CGRect(x: 10 + (pos * 70), y: 10, width: 60, height: 60), num: pos)
            schemeImageView.backgroundColor = (scheme as! ColorScheme).skills
            schemeImageView.layer.cornerRadius = 10.0
            let schemeLabel = UILabel(frame: CGRect(x: 0, y: 0, width: schemeImageView.frame.width, height: schemeImageView.frame.height))
            schemeLabel.text = "\(pos + 1)"
            schemeLabel.textAlignment = NSTextAlignment.Center
            schemeLabel.textColor = whiteColor
            schemeLabel.font = UIFont(name: "Helvetica", size: 36.0)
            let schemeGR = UITapGestureRecognizer(target: self, action: "colorSchemeTapped:")
            schemeImageView.addGestureRecognizer(schemeGR)
            schemeImageView.addSubview(schemeLabel)
            optionsColorSchemeScrollView.addSubview(schemeImageView)
            pos++
        }
        
        optionsVoicePackLabel = AniLabel(frame: CGRect(x: 5, y: 5 + optionsColorSchemeLabel.frame.height + 5 + optionsColorSchemeScrollView.frame.height + 5, width: optionsView.frame.width - 10, height: 50))
        optionsVoicePackLabel.text = "Voice Pack"
        optionsVoicePackLabel.font = UIFont(name: "Helvetica", size: 24.0)
        optionsVoicePackLabel.textAlignment = NSTextAlignment.Center
        optionsVoicePackLabel.textColor = goldColor
        optionsVoicePackLabel.alpha = 0.0
        //Clicking a Scheme will drop down the scroll view to reveal the colors
        optionsVoicePackScrollView = UIScrollView(frame: CGRect(x: 20, y: 5 + optionsColorSchemeLabel.frame.height + 5 + optionsColorSchemeScrollView.frame.height + 5 + optionsVoicePackLabel.frame.height, width: optionsView.frame.width - 40, height: 80))
        optionsVoicePackScrollView.layer.borderWidth = 3.0
        optionsVoicePackScrollView.layer.cornerRadius = 10.0
        optionsVoicePackScrollView.layer.borderColor = goldColor.CGColor
        optionsVoicePackScrollView.contentSize = CGSize(width: 750, height: 80) // Will adjust with amount of schemes
        optionsVoicePackScrollView.alpha = 0.0
        pos = 0
        /*
        for voice in voicePacks {
            //Should be custom uiviews with scheme
            let schemeImageView = UIView(frame: CGRect(x: 10 + (pos * 70), y: 10, width: 60, height: 60))
            schemeImageView.backgroundColor = (scheme as ColorScheme).skills
            schemeImageView.layer.cornerRadius = 10.0
            let schemeGR = UITapGestureRecognizer(target: self, action: "colorSchemeTapped:")
            schemeImageView.addGestureRecognizer(schemeGR)
            optionsColorSchemeScrollView.addSubview(schemeImageView)
            pos++
        }
        */

        
        optionsView.addSubview(optionsColorSchemeLabel)
        optionsView.addSubview(optionsColorSchemeScrollView)
        optionsView.addSubview(optionsVoicePackLabel)
        optionsView.addSubview(optionsVoicePackScrollView)
        view.addSubview(optionsView)
        
        ////////////////////////////////////////////////////////////////////////
        
        
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
        totalLevelLabel.text = "Total Level: \(totalLevel)"
        totalLevelLabel.textAlignment = NSTextAlignment.Center
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
        
        /////////////////////////////     SKILLS     ////////////////////////////////
        //Skills Container
        // Height of containers will be dynamic based on number of skills
        skillsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        skillsContainer.contentSize = CGSize(width: skillsContainer.frame.width, height: 1000)
        skillsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        skillsContainer.layer.borderWidth = 5.0
        skillsContainer.layer.borderColor = skillsColor.CGColor
        /////////////////////////////     SKILLS     ////////////////////////////////
        
        /////////////////////////////     TASKS     ////////////////////////////////
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
        /////////////////////////////     TASKS     ////////////////////////////////
        
        
        /////////////////////////////     GOALS     ////////////////////////////////
        //Goals Container
        goalsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        goalsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.layer.borderWidth = 5.0
        goalsContainer.layer.borderColor = goalsColor.CGColor
        
        //Current Goals Button
        goalsCurrent = UIButton(frame: CGRect(x: 5, y: 5, width: (goalsContainer.frame.width - 10) * 0.35, height: 30))
        goalsCurrent.addTarget(self, action: "goalsCurrentTapped", forControlEvents: .TouchUpInside)
        goalsCurrent.setTitle("Current", forState: .Normal)
        goalsCurrent.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsCurrent.backgroundColor = goalsColor
        goalsCurrent.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        goalsCurrent.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsCurrent.layer.borderWidth = 2.0
        goalsCurrent.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Current goals Container - Populate on ViewWillAppear or ButtonPress
        goalsCurrentContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: goalsContainer.frame.width - 10, height: goalsContainer.frame.height - 40))
        goalsCurrentContainer.contentSize = CGSize(width: goalsCurrentContainer.frame.width, height: 750)
        goalsCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.addSubview(goalsCurrentContainer)
        goalsContainer.addSubview(goalsCurrent)
        
        //Completed goals Button
        goalsCompleted = UIButton(frame: CGRect(x: 5 + goalsCurrent.frame.width, y: 5, width: (goalsContainer.frame.width - 10) * 0.35, height: 30))
        goalsCompleted.addTarget(self, action: "goalsCompletedTapped", forControlEvents: .TouchUpInside)
        goalsCompleted.setTitle("Completed", forState: .Normal)
        goalsCompleted.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsCompleted.backgroundColor = goalsColor
        goalsCompleted.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        goalsCompleted.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsCompleted.layer.borderWidth = 2.0
        goalsCompleted.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Completed goals Container - Populate on ViewWillAppear or ButtonPress
        goalsCompletedContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: goalsContainer.frame.width - 10, height: goalsContainer.frame.height - 40))
        goalsCompletedContainer.contentSize = CGSize(width: goalsCurrentContainer.frame.width, height: 750)
        goalsCompletedContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.addSubview(goalsCompletedContainer)
        goalsContainer.addSubview(goalsCompleted)
        
        //Sort goals Button
        goalsSort = UIButton(frame: CGRect(x: 5 + goalsCurrent.frame.width * 2, y: 5, width: (goalsContainer.frame.width - 10) * 0.15, height: 30))
        goalsSort.addTarget(self, action: "goalsSortTapped", forControlEvents: .TouchUpInside)
        goalsSort.setTitle("Sort", forState: .Normal)
        goalsSort.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsSort.backgroundColor = goalsColor
        goalsSort.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        goalsSort.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsSort.layer.borderWidth = 2.0
        goalsSort.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Sort goals Container - Populate on ViewWillAppear or ButtonPress
        goalsSortContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: goalsContainer.frame.width - 10, height: goalsContainer.frame.height - 40))
        goalsSortContainer.contentSize = CGSize(width: goalsSortContainer.frame.width, height: 750)
        goalsSortContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.addSubview(goalsSortContainer)
        goalsContainer.addSubview(goalsSort)
        
        //Search goals Button
        goalsSearch = UIButton(frame: CGRect(x: 5 + goalsCurrent.frame.width * 2 + goalsSort.frame.width, y: 5, width: (goalsContainer.frame.width - 10) * 0.15, height: 30))
        goalsSearch.addTarget(self, action: "goalsSearchTapped", forControlEvents: .TouchUpInside)
        goalsSearch.setTitle("Sear", forState: .Normal)
        goalsSearch.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsSearch.backgroundColor = goalsColor
        goalsSearch.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        goalsSearch.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsSearch.layer.borderWidth = 2.0
        goalsSearch.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Search goals Container - Populate on ViewWillAppear or ButtonPress
        goalsSearchContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: goalsContainer.frame.width - 10, height: goalsContainer.frame.height - 40))
        goalsSearchContainer.contentSize = CGSize(width: goalsSearchContainer.frame.width, height: 750)
        goalsSearchContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        goalsContainer.addSubview(goalsSearchContainer)
        goalsContainer.addSubview(goalsSearch)
        
        goalsSelectedButton = goalsCurrent
        
        //Set selected
        goalsContainer.bringSubviewToFront(goalsCurrentContainer)
        goalsSelectedButton = goalsCurrent
        /////////////////////////////     GOALS     ////////////////////////////////
        
        
        
        
        
        /////////////////////////     ACHIEVEMENTS     /////////////////////////////
        //Achievements Container
        achievementsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        achievementsContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.layer.borderWidth = 5.0
        achievementsContainer.layer.borderColor = achievementsColor.CGColor
        
        //Current Achievements Button
        achievementsCurrent = UIButton(frame: CGRect(x: 5, y: 5, width: (achievementsContainer.frame.width - 10) * 0.35, height: 30))
        achievementsCurrent.addTarget(self, action: "achievementsCurrentTapped", forControlEvents: .TouchUpInside)
        achievementsCurrent.setTitle("Current", forState: .Normal)
        achievementsCurrent.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        achievementsCurrent.backgroundColor = achievementsColor
        achievementsCurrent.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        achievementsCurrent.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        achievementsCurrent.layer.borderWidth = 2.0
        achievementsCurrent.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Current achievements Container - Populate on ViewWillAppear or ButtonPress
        achievementsCurrentContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: achievementsContainer.frame.width - 10, height: achievementsContainer.frame.height - 40))
        achievementsCurrentContainer.contentSize = CGSize(width: achievementsCurrentContainer.frame.width, height: 750)
        achievementsCurrentContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.addSubview(achievementsCurrentContainer)
        achievementsContainer.addSubview(achievementsCurrent)
        
        //Completed achievements Button
        achievementsCompleted = UIButton(frame: CGRect(x: 5 + achievementsCurrent.frame.width, y: 5, width: (achievementsContainer.frame.width - 10) * 0.35, height: 30))
        achievementsCompleted.addTarget(self, action: "achievementsCompletedTapped", forControlEvents: .TouchUpInside)
        achievementsCompleted.setTitle("Completed", forState: .Normal)
        achievementsCompleted.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        achievementsCompleted.backgroundColor = achievementsColor
        achievementsCompleted.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        achievementsCompleted.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        achievementsCompleted.layer.borderWidth = 2.0
        achievementsCompleted.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Completed achievements Container - Populate on ViewWillAppear or ButtonPress
        achievementsCompletedContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: achievementsContainer.frame.width - 10, height: achievementsContainer.frame.height - 40))
        achievementsCompletedContainer.contentSize = CGSize(width: achievementsCurrentContainer.frame.width, height: 750)
        achievementsCompletedContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.addSubview(achievementsCompletedContainer)
        achievementsContainer.addSubview(achievementsCompleted)
        
        //Sort achievements Button
        achievementsSort = UIButton(frame: CGRect(x: 5 + achievementsCurrent.frame.width * 2, y: 5, width: (achievementsContainer.frame.width - 10) * 0.15, height: 30))
        achievementsSort.addTarget(self, action: "achievementsSortTapped", forControlEvents: .TouchUpInside)
        achievementsSort.setTitle("Sort", forState: .Normal)
        achievementsSort.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        achievementsSort.backgroundColor = achievementsColor
        achievementsSort.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        achievementsSort.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        achievementsSort.layer.borderWidth = 2.0
        achievementsSort.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Sort achievements Container - Populate on ViewWillAppear or ButtonPress
        achievementsSortContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: achievementsContainer.frame.width - 10, height: achievementsContainer.frame.height - 40))
        achievementsSortContainer.contentSize = CGSize(width: achievementsSortContainer.frame.width, height: 750)
        achievementsSortContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.addSubview(achievementsSortContainer)
        achievementsContainer.addSubview(achievementsSort)
        
        //Search achievements Button
        achievementsSearch = UIButton(frame: CGRect(x: 5 + achievementsCurrent.frame.width * 2 + achievementsSort.frame.width, y: 5, width: (achievementsContainer.frame.width - 10) * 0.15, height: 30))
        achievementsSearch.addTarget(self, action: "achievementsSearchTapped", forControlEvents: .TouchUpInside)
        achievementsSearch.setTitle("Sear", forState: .Normal)
        achievementsSearch.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        achievementsSearch.backgroundColor = achievementsColor
        achievementsSearch.titleLabel?.font = UIFont(name: "Helvetica", size: 16.0)
        achievementsSearch.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        achievementsSearch.layer.borderWidth = 2.0
        achievementsSearch.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        // Search achievements Container - Populate on ViewWillAppear or ButtonPress
        achievementsSearchContainer = UIScrollView(frame: CGRect(x: 5, y: 35, width: achievementsContainer.frame.width - 10, height: achievementsContainer.frame.height - 40))
        achievementsSearchContainer.contentSize = CGSize(width: achievementsSearchContainer.frame.width, height: 750)
        achievementsSearchContainer.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        achievementsContainer.addSubview(achievementsSearchContainer)
        achievementsContainer.addSubview(achievementsSearch)
        
        achievementsSelectedButton = achievementsCurrent
        //Set selected
        goalsContainer.bringSubviewToFront(goalsCurrentContainer)
        goalsSelectedButton = goalsCurrent
        
        /////////////////////////     ACHIEVEMENTS     /////////////////////////////
        
        
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
                let skillCard = SkillCard(frame: CGRect(x: 8, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), skill: skill as! Skill, color: skillsColor)
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
                let expBarContainer = ExpBarContainer(frame: CGRect(x: 0, y: 88, width: skillCard.frame.width, height: 40))
                expBarContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                expBarContainer.layer.cornerRadius = 5.0
                let expBarEmpty = ExpBarEmpty(frame: CGRect(x: 8, y: 0, width: skillCard.frame.width - 16, height: 20))
                expBarEmpty.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                expBarEmpty.layer.borderColor = skillsColor.CGColor
                expBarEmpty.layer.borderWidth = 2.0
                expBarEmpty.layer.cornerRadius = 10.0
                
                //Animation Testing
                let expBarFull = ExpBarFull(frame: CGRect(x: 8, y: 0, width: 0, height: 20))
                expBarFull.backgroundColor = skillsColor
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
//                    let topExpBorder = CALayer()
//                    topExpBorder.frame = CGRectMake(0, 0, expBarFull.frame.width, 2.0)
//                    topExpBorder.backgroundColor = skillsColor.CGColor
//                    let leftExpBorder = CALayer()
//                    leftExpBorder.frame = CGRectMake(0, 0, 2.0, expBarFull.frame.height)
//                    leftExpBorder.backgroundColor = skillsColor.CGColor
//                    let bottomExpBorder = CALayer()
//                    bottomExpBorder.frame = CGRectMake(0, expBarFull.frame.height - 2.0, expBarFull.frame.width, 2.0)
//                    bottomExpBorder.backgroundColor = skillsColor.CGColor
//                    expBarFull.layer.addSublayer(topExpBorder)
//                    expBarFull.layer.addSublayer(leftExpBorder)
//                    expBarFull.layer.addSublayer(bottomExpBorder)
                }
                
                
                expBarContainer.addSubview(expBarEmpty)
                expBarContainer.addSubview(expBarFull)
                skillCard.addSubview(skillIcon)
                skillCard.addSubview(skillNameLabel)
                skillCard.addSubview(levelText)
                skillCard.addSubview(expBarContainer)
                skillsContainer.addSubview(skillCard)
            } else { // Second Column
                let skillCard = SkillCard(frame: CGRect(x: skillsContainer.frame.width / 2 + 4, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), skill: skill as! Skill, color: skillsColor)
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
                let expBarContainer = ExpBarContainer(frame: CGRect(x: 0, y: 88, width: skillCard.frame.width, height: 40))
                expBarContainer.backgroundColor = UIColor(white: 0.95, alpha: 1.0)
                expBarContainer.layer.cornerRadius = 5.0
                let expBarEmpty = ExpBarEmpty(frame: CGRect(x: 8, y: 0, width: skillCard.frame.width - 16, height: 20))
                expBarEmpty.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                expBarEmpty.layer.borderColor = skillsColor.CGColor
                expBarEmpty.layer.borderWidth = 2.0
                expBarEmpty.layer.cornerRadius = 10.0
                //Animation Testing
                let expBarFull = ExpBarFull(frame: CGRect(x: 8, y: 0, width: 0, height: 20))
                expBarFull.backgroundColor = skillsColor
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
//                    let topExpBorder = CALayer()
//                    topExpBorder.frame = CGRectMake(0, 0, expBarFull.frame.width, 2.0)
//                    topExpBorder.backgroundColor = skillsColor.CGColor
//                    let leftExpBorder = CALayer()
//                    leftExpBorder.frame = CGRectMake(0, 0, 2.0, expBarFull.frame.height)
//                    leftExpBorder.backgroundColor = skillsColor.CGColor
//                    let bottomExpBorder = CALayer()
//                    bottomExpBorder.frame = CGRectMake(0, expBarFull.frame.height - 2.0, expBarFull.frame.width, 2.0)
//                    bottomExpBorder.backgroundColor = skillsColor.CGColor
//                    expBarFull.layer.addSublayer(topExpBorder)
//                    expBarFull.layer.addSublayer(leftExpBorder)
//                    expBarFull.layer.addSublayer(bottomExpBorder)
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
            let newSkillCard = SkillCard(frame: CGRect(x: 8, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), color: skillsColor)
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
            let newSkillCard = SkillCard(frame: CGRect(x: skillsContainer.frame.width / 2 + 4, y: CGFloat(row * 136) + 8, width: skillsContainer.frame.width / 2 - 12, height: 128), color: skillsColor)
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
        
        //Number of skills = row * 2
        if row <= 1 {
            skillsContainer.contentSize = CGSize(width: skillsContainer.frame.width, height: 144)
        } else {
            skillsContainer.contentSize = CGSize(width: skillsContainer.frame.width, height: CGFloat(row * 136) + 136 + 8)
        }
       

        ///////////////////////////////////////////////////////
        
        ///////////////////     TASKS      ////////////////////
        //Refresh subviews
        for view in tasksCurrentContainer.subviews {
            view.removeFromSuperview()
        }
        for view in tasksCompletedContainer.subviews {
            view.removeFromSuperview()
        }
        
        currentTasks = NSMutableArray()
        for skill in skills {
            let moreTasks = NSMutableArray(array: (skill as! Skill).tasks.allObjects)
            for task in moreTasks {
                currentTasks.addObject(task as! Task)
            }
        }
        
        completedTasks = NSMutableArray()
        for task in currentTasks {
            if (task as! Task).completed == 1 {
                completedTasks.addObject(task)
                currentTasks.removeObject(task)
            }
        }
        
        //Display Current Tasks
        
        row = 0
        for task in currentTasks {
            let taskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCurrentContainer.frame.width - 8), height: 72), task: task as! Task, color: tasksColor)
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
            /*
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
            */
            taskCard.addSubview(taskNameLabel)
            taskCard.addSubview(taskExpLabel)
            taskCard.addSubview(taskDifficultyLabel)
            //taskCard.addSubview(completeButton)
            //taskCard.addSubview(deleteButton)
            //taskCard.addSubview(buttonDivider)
            
            row++
        }
        //Number of tasks = row
        tasksCurrentContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: CGFloat(row * 76) + 8)
        //Display Completed Tasks
        row = 0
        for task in completedTasks {
            let taskCard = TaskCard(frame: CGRect(x: 4, y: CGFloat(row * 76) + 4, width: CGFloat(tasksCompletedContainer.frame.width - 8), height: 72), task: task as! Task, color: tasksColor)
            taskCard.backgroundColor = tasksColor
            tasksCompletedContainer.addSubview(taskCard)
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
            /*
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
            */
            taskCard.addSubview(taskNameLabel)
            taskCard.addSubview(taskExpLabel)
            taskCard.addSubview(taskDifficultyLabel)
            //taskCard.addSubview(completeButton)
            //taskCard.addSubview(deleteButton)
            //taskCard.addSubview(buttonDivider)
            
            row++
        }
        //Number of tasks = row
        tasksCompletedContainer.contentSize = CGSize(width: tasksCompletedContainer.frame.width, height: CGFloat(row * 76) + 8)
        
        
        
        ///////////////////     GOALS      ////////////////////
        //Refresh subviews
        for view in goalsCurrentContainer.subviews {
            view.removeFromSuperview()
        }
        for view in goalsCompletedContainer.subviews {
            view.removeFromSuperview()
        }
        currentGoals = NSMutableArray(array: user.goals.allObjects)
        completedGoals = NSMutableArray()
        for goal in currentGoals {
            if (goal as! Goal).completed == 1 {
                completedGoals.addObject(goal)
                currentGoals.removeObject(goal)
            }
        }
        
        row = 0
        for goal in currentGoals {
            let goalCard = GoalCard(frame: CGRect(x: 4, y: CGFloat(row * 136) + 8, width: goalsCurrentContainer.frame.width - 8, height: 128), goal: goal as! Goal)
            row++
        }
        goalsCurrentContainer.contentSize = CGSize(width: tasksCurrentContainer.frame.width, height: CGFloat(row * 136) + 8)
        
        //// New Goal Card /////
        let newGoalCard = GoalCard(frame: CGRect(x: 4, y: CGFloat(row * 136) + 8, width: goalsCurrentContainer.frame.width - 8, height: 128))
        newGoalCard.backgroundColor = whiteColor
        newGoalCard.layer.borderWidth = 2.0
        newGoalCard.layer.borderColor = goalsColor.CGColor
        let goalCardGR = UITapGestureRecognizer(target: self, action: "newGoalTapped")
        newGoalCard.addGestureRecognizer(goalCardGR)
        let newGoalLabel = UILabel(frame: CGRect(x: 4, y: 4, width: newGoalCard.frame.width - 8, height: newGoalCard.frame.height - 8))
        newGoalLabel.text = "New!"
        newGoalLabel.font = UIFont(name: "Helvetica", size: 36.0)
        newGoalLabel.textColor = blackColor
        newGoalLabel.textAlignment = NSTextAlignment.Center
        newGoalCard.addSubview(newGoalLabel)
        goalsCurrentContainer.addSubview(newGoalCard)
        
        
        
        
        ///////////////////////////////////////////////////////
        
        //Set Current Tasks as Selected
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        //Set Current Goals as Selected
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = goalsColor
        goalsSelectedButton = goalsCurrent
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = whiteColor
        goalsContainer.bringSubviewToFront(goalsCurrentContainer)
        //Set Current Achievements as Selected
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = achievementsColor
        achievementsSelectedButton = achievementsCurrent
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsContainer.bringSubviewToFront(achievementsCurrentContainer)
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
            
            //Options are Now Visible
            if !optionBool {
//                println("OptionAreOpen : \(optionsAreOpen)")
//                println("Spin 90 Deg")
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.optionsButton.transform = CGAffineTransformMakeRotation(-90.0)
                    self.view.bringSubviewToFront(self.optionsView)
                    self.optionsView.frame = self.optionsView.originalFrame
                    //self.optionsView.alpha = 1.0
                }, completion: nil)
                //ColorScheme Label
                UIView.animateWithDuration(0.4, delay: 0.1, options: .CurveEaseOut, animations: {
                    self.optionsColorSchemeLabel.alpha = 1.0
                }, completion: nil)
                //ColorScheme Scroll View
                UIView.animateWithDuration(0.4, delay: 0.2, options: .CurveEaseOut, animations: {
                    self.optionsColorSchemeScrollView.alpha = 1.0
                }, completion: nil)
                //VoicePack Label
                UIView.animateWithDuration(0.4, delay: 0.3, options: .CurveEaseOut, animations: {
                    self.optionsVoicePackLabel.alpha = 1.0
                }, completion: nil)
                //VoicePack Scroll View
                UIView.animateWithDuration(0.4, delay: 0.4, options: .CurveEaseOut, animations: {
                    self.optionsVoicePackScrollView.alpha = 1.0
                }, completion: nil)

            } else { // Options are now hidden
//                println("OptionAreOpen : \(optionsAreOpen)")
//                println("Spin -90 Deg")
                //VoicePack Scroll View
                UIView.animateWithDuration(0.4, delay: 0.1, options: .CurveEaseOut, animations: {
                    self.optionsVoicePackScrollView.alpha = 0.0
                }, completion: nil)
                //VoicePack Label
                UIView.animateWithDuration(0.4, delay: 0.2, options: .CurveEaseOut, animations: {
                    self.optionsVoicePackLabel.alpha = 0.0
                }, completion: nil)
                //ColorScheme Scroll View
                UIView.animateWithDuration(0.4, delay: 0.3, options: .CurveEaseOut, animations: {
                    self.optionsColorSchemeScrollView.alpha = 0.0
                    }, completion: nil)
                //ColorScheme Label
                UIView.animateWithDuration(0.4, delay: 0.4, options: .CurveEaseOut, animations: {
                    self.optionsColorSchemeLabel.alpha = 0.0
                }, completion: nil)
                
                
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
                    self.optionsButton.transform = CGAffineTransformMakeRotation(90.0)
                    self.optionsView.frame = CGRect(x: 8, y: 20 + self.headerView.frame.height, width: self.view.frame.width - 16, height: 0)
                    //self.optionsView.alpha = 0.0
                }, completion: nil)
            }
        }
       
        optionsAreOpen = !optionsAreOpen

        
    }
    
    func colorSchemeTapped(gr: UITapGestureRecognizer) {
        let thisScheme = gr.view! as! ColorSchemeView
        let schemeNum = thisScheme.schemeNumber
        user.colorScheme = schemeNum
        skillsColor = (colorSchemes.objectAtIndex(schemeNum) as! ColorScheme).skills
        tasksColor = (colorSchemes.objectAtIndex(schemeNum) as! ColorScheme).tasks
        goalsColor = (colorSchemes.objectAtIndex(schemeNum) as! ColorScheme).goals
        achievementsColor = (colorSchemes.objectAtIndex(schemeNum) as! ColorScheme).achievements
        if saveContext() {
            //Saved
        } else {
            println("Error Saving")
        }
        let currentFrame = thisScheme.frame
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
            thisScheme.frame = CGRect(x: thisScheme.frame.minX - 8, y: thisScheme.frame.minY - 8, width: thisScheme.frame.width + 16, height: thisScheme.frame.height + 16)
            }, completion: {
                (value: Bool) in
                UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.25, initialSpringVelocity: 0.75, options: .CurveEaseInOut, animations: {
                    thisScheme.frame = currentFrame
                    }, completion: nil)
        })
        
        refreshHomeColors()
    }
    
    func refreshHomeColors() {
        ///// Skills /////
        skillsTab.backgroundColor = skillsColor
        skillsContainer.layer.borderColor = skillsColor.CGColor
        for skillCard in skillsContainer.subviews {
            if skillCard.isKindOfClass(SkillCard) {
                (skillCard as! SkillCard).layer.borderColor = skillsColor.CGColor
                var fill = false
                for expBar in skillCard.subviews {
                    if expBar.isKindOfClass(ExpBarContainer) {
                        (expBar as! ExpBarContainer).layer.borderColor = skillsColor.CGColor
                        for childBar in expBar.subviews {
                            if childBar.isKindOfClass(ExpBarEmpty) {
                                (childBar as! ExpBarEmpty).layer.borderColor = skillsColor.CGColor
                            }
                            if childBar.isKindOfClass(ExpBarFull) {
                                (childBar as! ExpBarFull).backgroundColor = skillsColor
                            }
                            
                        }
                    }
                }
            }
        }
        
        ///// Tasks //////
        tasksTab.backgroundColor = tasksColor
        tasksContainer.layer.borderColor = tasksColor.CGColor
        for taskCard in tasksCurrentContainer.subviews {
            if taskCard.isKindOfClass(TaskCard) {
                (taskCard as! TaskCard).layer.borderColor = tasksColor.CGColor
                (taskCard as! TaskCard).mainColor = tasksColor
                (taskCard as! TaskCard).backgroundColor = tasksColor
                for label in taskCard.subviews {
                    (label as! UILabel).layer.borderColor = tasksColor.CGColor
                }
            }
        }
        for taskCard in tasksCompletedContainer.subviews {
            if taskCard.isKindOfClass(TaskCard) {
                (taskCard as! TaskCard).layer.borderColor = tasksColor.CGColor
                (taskCard as! TaskCard).mainColor = tasksColor
                (taskCard as! TaskCard).backgroundColor = tasksColor
                for label in taskCard.subviews {
                    (label as! UILabel).layer.borderColor = tasksColor.CGColor
                }

            }
        }
        tasksCurrent.backgroundColor = tasksColor
        tasksCompleted.backgroundColor = tasksColor
        tasksSort.backgroundColor = tasksColor
        tasksSearch.backgroundColor = tasksColor
        tasksSelectedButton.backgroundColor = whiteColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        
        
        ///// Goals //////
        goalsTab.backgroundColor = goalsColor
        goalsContainer.layer.borderColor = goalsColor.CGColor
        /// Will need to go through goal cards
        for goalCard in goalsCurrent.subviews {
            if goalCard.isKindOfClass(GoalCard) {
                (goalCard as! GoalCard).layer.borderColor = goalsColor.CGColor
            }
        }
        goalsCurrent.backgroundColor = goalsColor
        goalsCompleted.backgroundColor = goalsColor
        goalsSort.backgroundColor = goalsColor
        goalsSearch.backgroundColor = goalsColor
        goalsSelectedButton.backgroundColor = whiteColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        
        //// Achievements /////
        achievementsTab.backgroundColor = achievementsColor
        achievementsContainer.layer.borderColor = achievementsColor.CGColor
        // Will need to go through achs cards
        achievementsCurrent.backgroundColor = achievementsColor
        achievementsCompleted.backgroundColor = achievementsColor
        achievementsSort.backgroundColor = achievementsColor
        achievementsSearch.backgroundColor = achievementsColor
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        
    }
    
    func skillCardTapped(gr: UITapGestureRecognizer) {
        let skillTapped = (gr.view as! SkillCard).skill
        //let skillsVC = storyboard?.instantiateViewControllerWithIdentifier("SkillsViewController") as SkillsViewController
        let skillsVC = SkillsViewController()
        skillsVC.user = user
        skillsVC.skill = skillTapped
        skillsVC.skillsColor = skillsColor
        skillsVC.tasksColor = tasksColor
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
        let createSkillVC = storyboard?.instantiateViewControllerWithIdentifier("CreateSkillViewController") as! CreateSkillViewController
        createSkillVC.user = user
        createSkillVC.skillsColor = skillsColor
        createSkillVC.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
        transitionCameFrom = createSkillVC
        
        let realOrigin = gr.view!.superview!.convertPoint(gr.view!.frame.origin, toView: nil)
        let newSkillOverlay = UIView(frame: CGRect(x: realOrigin.x, y: realOrigin.y, width: gr.view!.frame.width, height: gr.view!.frame.height))
        newSkillOverlay.backgroundColor = whiteColor
        newSkillOverlay.layer.borderWidth = 3.0
        newSkillOverlay.layer.borderColor = skillsColor.CGColor
        self.view.addSubview(newSkillOverlay)
        self.view.bringSubviewToFront(newSkillOverlay)
        println("Skill Card Origin: \(gr.view!.frame.origin)")
        println("realOrigin: \(realOrigin)")
        UIView.animateWithDuration(0.1, delay: 0.0, options: .CurveLinear, animations: {
            newSkillOverlay.frame = CGRectInset(newSkillOverlay.frame, 10, 10)
            gr.view!.hidden = true
        }, completion: {
                (value: Bool) in
                
                UIView.animateWithDuration(1.0, delay: 0.0, options: .CurveEaseInOut, animations: {
                    newSkillOverlay.frame = CGRect(x: 0, y: 20, width: self.view.frame.width, height: self.view.frame.height - 20)
                    }, completion: {
                        (value: Bool) in
                        gr.view!.hidden = false
                        //Test
                        newSkillOverlay.frame = CGRect(x: realOrigin.x, y: realOrigin.y, width: gr.view!.frame.width, height: gr.view!.frame.height)
                        self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                        self.presentViewController(createSkillVC, animated: false, completion: {
                            newSkillOverlay.removeFromSuperview()
                        })
                })
                
        })
        
        //** Time to animate some shiiiiii **////
        
        
    }
    
    func newGoalTapped() {
        let createGoalVC = CreateGoalViewController()
        createGoalVC.user = user
        createGoalVC.skillsColor = skillsColor
        createGoalVC.tasksColor = tasksColor
        createGoalVC.goalsColor = goalsColor
        
        transitionCameFrom = createGoalVC
        presentViewController(createGoalVC, animated: true, completion: nil)
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
    
    /// Used After ColorScheme Change
    func resetColors() {
        
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
        /*
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = tasksColor
        tasksSelectedButton = tasksCurrent
        tasksSelectedButton.layer.borderColor = whiteColor.CGColor
        tasksSelectedButton.setTitleColor(tasksColor, forState: .Normal)
        tasksSelectedButton.backgroundColor = whiteColor
        tasksContainer.bringSubviewToFront(tasksCurrentContainer)
        */
        
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
    
    //Goal Container Buttons
    func goalsCurrentTapped() {
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = goalsColor
        goalsSelectedButton = goalsCurrent
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = whiteColor
        goalsContainer.bringSubviewToFront(goalsCurrentContainer)
    }
    func goalsSortTapped() {
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = goalsColor
        goalsSelectedButton = goalsSort
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = whiteColor
        goalsContainer.bringSubviewToFront(goalsSortContainer)
    }
    func goalsSearchTapped() {
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = goalsColor
        goalsSelectedButton = goalsSearch
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = whiteColor
        goalsContainer.bringSubviewToFront(goalsSearchContainer)
    }
    func goalsCompletedTapped() {
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = goalsColor
        goalsSelectedButton = goalsCompleted
        goalsSelectedButton.layer.borderColor = whiteColor.CGColor
        goalsSelectedButton.setTitleColor(goalsColor, forState: .Normal)
        goalsSelectedButton.backgroundColor = whiteColor
        goalsContainer.bringSubviewToFront(goalsCompletedContainer)
    }
    
    //Achievement Container Buttons
    func achievementsCurrentTapped() {
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = achievementsColor
        achievementsSelectedButton = achievementsCurrent
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsContainer.bringSubviewToFront(achievementsCurrentContainer)
    }
    func achievementsSortTapped() {
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = achievementsColor
        achievementsSelectedButton = achievementsSort
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsContainer.bringSubviewToFront(achievementsSortContainer)
    }
    func achievementsSearchTapped() {
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = achievementsColor
        achievementsSelectedButton = achievementsSearch
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsContainer.bringSubviewToFront(achievementsSearchContainer)
    }
    func achievementsCompletedTapped() {
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(whiteColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = achievementsColor
        achievementsSelectedButton = achievementsCompleted
        achievementsSelectedButton.layer.borderColor = whiteColor.CGColor
        achievementsSelectedButton.setTitleColor(achievementsColor, forState: .Normal)
        achievementsSelectedButton.backgroundColor = whiteColor
        achievementsContainer.bringSubviewToFront(achievementsCompletedContainer)
    }

    func saveContext() -> Bool {
        let managedContext = user.managedObjectContext!
        
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
            return false
        }
        
        return true
    }

}

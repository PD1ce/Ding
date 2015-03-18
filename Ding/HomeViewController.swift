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
    var skills: [Skill]!
    var tasks: [Task]!
    var goals: [Goal]!
    var achievements: [Achievement]!
    
    var skillsTab: UIButton!
    var tasksTab: UIButton!
    var goalsTab: UIButton!
    var achievementsTab: UIButton!
    var skillsContainer: UIScrollView!
    var tasksContainer: UIScrollView!
    var goalsContainer: UIScrollView!
    var achievementsContainer: UIScrollView!
    
    var mainContainerView: UIView!
    
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    let goalsColor = UIColor(red: 51/255, green: 102/255, blue: 255/255, alpha: 1.0)
    let achievementsColor = UIColor(red: 102/255, green: 51/255, blue: 255/255, alpha: 1.0)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
        logoutButton.setTitle("Logout", forState: .Normal)
        logoutButton.addTarget(self, action: "logoutButtonTapped", forControlEvents: .TouchUpInside)
        logoutButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
        let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "Ding!"
        
        headerView.addSubview(headerLabel)
        headerView.addSubview(logoutButton)
        view.addSubview(headerView)
        
        ////  Container Items  ////
        let userContainerView = UIView(frame: CGRect(x: 0, y: 0, width: 112, height: 112))
        userContainerView.backgroundColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        
        let userImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: userContainerView.frame.width - 16, height: 96))
        userImageView.image = UIImage(named: "philProfile")
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        userContainerView.addSubview(userImageView)
        
        
        let detailsContainerView = UIView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: 112))
        detailsContainerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        
        let userNameLabel = UILabel(frame: CGRect(x: userContainerView.frame.width + 8, y: 8, width: detailsContainerView.frame.width - userContainerView.frame.width - 16, height: userContainerView.frame.height / 2 - 12))
        userNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        userNameLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        userNameLabel.text = user.userName
        userNameLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        userNameLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        let totalLevelLabel = UILabel(frame: CGRect(x: userContainerView.frame.width + 8, y: userNameLabel.frame.height + 16, width: detailsContainerView.frame.width - userContainerView.frame.width - 16, height: userContainerView.frame.height / 2 - 12))
        totalLevelLabel.font = UIFont(name: "Helvetica", size: 18.0)
        totalLevelLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        totalLevelLabel.text = "Total Level:"
        totalLevelLabel.backgroundColor = UIColor(white: 0.9, alpha: 1.0) // Test
        
        detailsContainerView.addSubview(userContainerView)
        detailsContainerView.addSubview(userNameLabel)
        detailsContainerView.addSubview(totalLevelLabel)
        ///////////////////////////
        
        view.addSubview(detailsContainerView)
        
        let mainYPos = 20 + headerView.frame.height + 8 + userContainerView.frame.height + 8
        mainContainerView = UIView(frame: CGRect(x: 8, y: mainYPos, width: view.frame.width - 16, height: view.frame.height - mainYPos - 8))
        mainContainerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        view.addSubview(mainContainerView)
        
        ////// Main Container SubViews ///////
        let tabWidth = mainContainerView.frame.width / 4
        //Skills Tab
        skillsTab = UIButton(frame: CGRect(x: 0, y: 0, width: tabWidth, height: 48))
        skillsTab.backgroundColor = skillsColor
        skillsTab.setTitle("Skills", forState: .Normal)
        skillsTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        skillsTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        skillsTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        skillsTab.addTarget(self, action: "skillsTabTapped", forControlEvents: .TouchUpInside)
        //Tasks Tab
        tasksTab = UIButton(frame: CGRect(x: tabWidth, y: 0, width: tabWidth, height: 48))
        tasksTab.backgroundColor = tasksColor
        tasksTab.setTitle("Tasks", forState: .Normal)
        tasksTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        tasksTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        tasksTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        tasksTab.addTarget(self, action: "tasksTabTapped", forControlEvents: .TouchUpInside)
        //Goals Tab
        goalsTab = UIButton(frame: CGRect(x: tabWidth * 2, y: 0, width: tabWidth, height: 48))
        goalsTab.backgroundColor = goalsColor
        goalsTab.setTitle("Goals", forState: .Normal)
        goalsTab.setTitleColor(UIColor(white: 1.0, alpha: 1.0), forState: .Normal)
        goalsTab.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        goalsTab.titleLabel?.textAlignment = NSTextAlignment(rawValue: 1)!
        goalsTab.addTarget(self, action: "goalsTabTapped", forControlEvents: .TouchUpInside)
        //Achievements Tab
        achievementsTab = UIButton(frame: CGRect(x: tabWidth * 3, y: 0, width: tabWidth, height: 48))
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
        skillsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        skillsContainer.layer.borderWidth = 5.0
        skillsContainer.layer.borderColor = skillsColor.CGColor
        //Tasks Container
        tasksContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        tasksContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        tasksContainer.layer.borderWidth = 5.0
        tasksContainer.layer.borderColor = tasksColor.CGColor
        //Goals Container
        goalsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        goalsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        goalsContainer.layer.borderWidth = 5.0
        goalsContainer.layer.borderColor = goalsColor.CGColor
        //Achievements Container
        achievementsContainer = UIScrollView(frame: CGRect(x: 0, y: skillsTab.frame.height, width: mainContainerView.frame.width, height: mainContainerView.frame.height - skillsTab.frame.height))
        achievementsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
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
        
        view.backgroundColor = UIColor(red: 0.85, green: 0.85, blue: 0.85, alpha:1)
        //Dimension prints
        println("Skills Container Min X: \(skillsContainer.frame.minX)")
        println("Skills Container Min Y: \(skillsContainer.frame.minY)")
        println("Skills Container Max X: \(skillsContainer.frame.maxX)")
        println("Skills Container Max Y: \(skillsContainer.frame.maxY)")
        println("Skills Container Width: \(skillsContainer.frame.width)")
        println("Skills Container Height: \(skillsContainer.frame.height)")
        
    }
    @IBAction func logoutTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func logoutButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func skillsTabTapped() {
        mainContainerView.bringSubviewToFront(skillsContainer)
    }
    func tasksTabTapped() {
        mainContainerView.bringSubviewToFront(tasksContainer)
    }
    func goalsTabTapped() {
        mainContainerView.bringSubviewToFront(goalsContainer)
    }
    func achievementsTabTapped() {
        mainContainerView.bringSubviewToFront(achievementsContainer)
    }
}

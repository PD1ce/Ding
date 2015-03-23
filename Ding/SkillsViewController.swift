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
    
    let skillsColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.85, alpha: 1.0)
        
        tasks = NSMutableArray(array: skill.tasks.allObjects)
        
        detailsContainer = UIView(frame: CGRect(x: 8, y: 72, width: view.frame.width - 16, height: 112))
        detailsContainer.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
        let headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
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
        var expCurrent = Int(skill.expTotal) - Int(skill.expNeeded)
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

        view.addSubview(expBarContainer)
        view.addSubview(detailsContainer)
        view.addSubview(headerView)
    }
    
    override func viewDidAppear(animated: Bool) {
        currentExp = Float(skill.expTotal) - Float(skill.expNeeded)
        realWidth = currentExp / Float(skill.expTotal) * Float(expBarEmpty.frame.width)
        UIView.animateWithDuration(2.0, animations: {
            self.expBarFull.frame = CGRect(x: self.expBarEmpty.frame.minX, y: self.expBarEmpty.frame.minY, width: CGFloat(self.realWidth), height: self.expBarEmpty.frame.height)
            self.expBarFull.backgroundColor = UIColor(red: 0.645, green: 0.8, blue: 0.2, alpha: 1)
            }, completion: {
                (value: Bool) in
        })
    }
    
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
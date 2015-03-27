//
//  ProfileViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/27/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

// PDAlert: Stat Tracking, dates, ranges, for completed tasks, leveled up skills, everything
class ProfileViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var user: User!
    var parentVC: HomeViewController!
    
    var editable: Bool!
    
    var userImage: UIImage!
    
    var userContainerView: UIView!
    var userImageView: UIImageView!
    
    var headerView: UIView!
    var editButton: UIButton!
    var backButton: UIButton!
    
    var userNameLabel: UILabel!
    var totalLevelLabel: UILabel!
    var highestSkillLabel: UILabel!
    
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let blackColor = UIColor(white: 0.0, alpha: 1.0)
    let goldColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
    let editColor = UIColor(red: 0.8, green: 0.0, blue: 0.0, alpha: 1.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userImage = parentVC.userImage
        editable = false
        
        headerView = UIView(frame: CGRect(x: 0, y: 20, width: view.frame.width, height: 44))
        headerView.backgroundColor = goldColor
        backButton = UIButton(frame: CGRect(x: 0, y: 0, width: 64, height: 44))
        backButton.setTitle("< Back", forState: .Normal)
        backButton.setTitleColor(whiteColor, forState: .Normal)
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        editButton = UIButton(frame: CGRect(x: headerView.frame.width - 72, y: 0, width: 72, height: 44))
        editButton.setTitle("Edit", forState: .Normal)
        editButton.setTitleColor(whiteColor, forState: .Normal)
        editButton.addTarget(self, action: "editButtonTapped", forControlEvents: .TouchUpInside)
        
        let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
        headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
        headerLabel.textColor = whiteColor
        headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        headerLabel.text = "Profile"
        
        headerView.addSubview(backButton)
        headerView.addSubview(editButton)
        headerView.addSubview(headerLabel)
        
        view.addSubview(headerView)
    }
    
    override func viewDidAppear(animated: Bool) {
        //Might be better to seperate these
        userContainerView = UIView(frame: CGRect(x: 8, y: 72, width: 112, height: 112))
        userContainerView.backgroundColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
        userImageView = UIImageView(frame: CGRect(x: 8, y: 8, width: userContainerView.frame.width - 16, height: 96))
        userImageView.image = userImage
        userImageView.layer.masksToBounds = true
        userImageView.layer.borderWidth = 3.0
        userImageView.layer.borderColor = UIColor(white: 1.0, alpha: 1.0).CGColor
        userImageView.layer.cornerRadius = userImageView.frame.width / 2
        let profilePictureGR = UITapGestureRecognizer(target: self, action: "profilePictureTapped")
        userImageView.addGestureRecognizer(profilePictureGR)
        userContainerView.addSubview(userImageView)
        
        let newHeight = userContainerView.frame.height * 1.5
        let divisionHeight = userContainerView.frame.height / 12
        userNameLabel = UILabel(frame: CGRect(x: view.frame.width, y: divisionHeight, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4))
        userNameLabel.text = "\(user.userName)"
        userNameLabel.font = UIFont(name: "Helvetica", size: 18.0)
        userNameLabel.textAlignment = NSTextAlignment.Center
        userNameLabel.textColor = goldColor
        userNameLabel.backgroundColor = whiteColor
        userNameLabel.layer.borderColor = whiteColor.CGColor
        userNameLabel.layer.borderWidth = 2.0
        totalLevelLabel = UILabel(frame: CGRect(x: view.frame.width, y: userNameLabel.frame.height + divisionHeight * 2, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4))
        totalLevelLabel.text = "Total Level: 5" //Placeholder
        totalLevelLabel.font = UIFont(name: "Helvetica", size: 18.0)
        totalLevelLabel.textAlignment = NSTextAlignment.Center
        totalLevelLabel.textColor = goldColor
        totalLevelLabel.backgroundColor = whiteColor
        totalLevelLabel.layer.borderColor = whiteColor.CGColor
        totalLevelLabel.layer.borderWidth = 2.0
        highestSkillLabel = UILabel(frame: CGRect(x: view.frame.width, y: userNameLabel.frame.height + totalLevelLabel.frame.height + divisionHeight * 3, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4))
        highestSkillLabel.text = "Highest Skill: Guitar" //Placeholder
        highestSkillLabel.font = UIFont(name: "Helvetica", size: 18.0)
        highestSkillLabel.textAlignment = NSTextAlignment.Center
        highestSkillLabel.textColor = goldColor
        highestSkillLabel.backgroundColor = whiteColor
        highestSkillLabel.layer.borderColor = whiteColor.CGColor
        highestSkillLabel.layer.borderWidth = 2.0
        
        userContainerView.addSubview(userNameLabel)
        userContainerView.addSubview(totalLevelLabel)
        userContainerView.addSubview(highestSkillLabel)
        
        view.addSubview(userContainerView)
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        view.userInteractionEnabled = false
        UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut,animations: {
            self.userContainerView.frame = CGRect(x: 8, y: 72, width: self.view.frame.width - 16, height: self.userContainerView.frame.height * 1.5)
            self.userImageView.frame = CGRect(x: 8, y: self.userImageView.frame.minY, width: self.userContainerView.frame.width / 3, height: self.userContainerView.frame.height - 16)
            //self.userImageView.layer.cornerRadius = self.userImageView.frame.width / 2
            
            }, completion: {
                (value: Bool) in
                
                UIView.animateWithDuration(0.2, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.userNameLabel.frame = CGRect(x: self.userImageView.frame.width + 16, y: divisionHeight, width: self.userContainerView.frame.width - self.userImageView.frame.width - 24, height: newHeight / 4)
                    }, completion: {
                        (value: Bool) in
                        
                })
                UIView.animateWithDuration(0.2, delay: 0.1, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.totalLevelLabel.frame = CGRect(x: self.userImageView.frame.width + 16, y: self.userNameLabel.frame.height + divisionHeight * 2, width: self.userContainerView.frame.width - self.userImageView.frame.width - 24, height: newHeight / 4)
                    }, completion: {
                        (value: Bool) in
                        
                })
                UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: {
                    self.highestSkillLabel.frame = CGRect(x: self.userImageView.frame.width + 16, y: self.userNameLabel.frame.height + self.totalLevelLabel.frame.height + divisionHeight * 3, width: self.userContainerView.frame.width - self.userImageView.frame.width - 24, height: newHeight / 4)
                    }, completion: {
                        (value: Bool) in
                        //Animations finished, allow interaction
                        self.view.userInteractionEnabled = true
                })
        })
    }
    override func viewWillDisappear(animated: Bool) {
        parentVC.userImage = userImage
    }
    override func viewDidDisappear(animated: Bool) {
        userContainerView.frame = CGRect(x: 8, y: 72, width: 112, height: 112)
        let newHeight = userContainerView.frame.height * 1.5
        let divisionHeight = userContainerView.frame.height / 12
        userImageView.layer.borderColor = whiteColor.CGColor
        userImageView.frame = CGRect(x: 8, y: 8, width: userContainerView.frame.width - 16, height: 96)
        userNameLabel.frame = CGRect(x: view.frame.width, y: divisionHeight, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4)
        totalLevelLabel.frame = CGRect(x: view.frame.width, y: userNameLabel.frame.height + divisionHeight * 2, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4)
        highestSkillLabel.frame = CGRect(x: view.frame.width, y: userNameLabel.frame.height + totalLevelLabel.frame.height + divisionHeight * 3, width: userContainerView.frame.width - userImageView.frame.width - 24, height: newHeight / 4)
        editButton.setTitle("Edit", forState: .Normal)
        backButton.userInteractionEnabled = true
        editable = false

    }
    
    func profilePictureTapped() {
        println("profile pic tapped")
        view.userInteractionEnabled = true
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.SavedPhotosAlbum) {
            //UIImagePickerController.availableMediaTypesForSourceType(.SavedPhotosAlbum)
            imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }
        
    }
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        userImage = image
        userImageView.image = userImage
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func editButtonTapped() {
        //begin editing
        if !editable {
            userImageView.userInteractionEnabled = true
            userImageView.layer.borderColor = editColor.CGColor
            userNameLabel.layer.borderColor = editColor.CGColor
            
            editButton.setTitle("Finish", forState: .Normal)
            
            backButton.userInteractionEnabled = false // Or maybe send an alert for why
            editable = !editable
        } else { //Stop editing
            userImageView.userInteractionEnabled = false
            userImageView.layer.borderColor = whiteColor.CGColor
            userNameLabel.layer.borderColor = whiteColor.CGColor
            
            editButton.setTitle("Edit", forState: .Normal)
            
            backButton.userInteractionEnabled = true
            editable = !editable
        }
    }
    
    func backButtonTapped() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}
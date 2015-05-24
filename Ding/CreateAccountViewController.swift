//
//  CreateAccountViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CreateAccountViewController : UIViewController {
    
    var appDelegate: AppDelegate!
    var titleLabel: UILabel!
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var incorrectLabel: UILabel!
    var createAccountButton: UIButton!
    var backButton: UIButton!
    
    let goldColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(white: 0.9, alpha: 1.0)
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: view.frame.height * 0.2))
        titleLabel.text = "Create Account"
        titleLabel.font = UIFont(name: "Helvetica", size: 48.0)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment.Center
        
        userNameTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.25, width: view.frame.width * 0.7, height: 50))
        userNameTextField.placeholder = "Username"
        userNameTextField.textAlignment = NSTextAlignment.Center
        userNameTextField.borderStyle = UITextBorderStyle.RoundedRect
        userNameTextField.textColor = goldColor
        userNameTextField.font = UIFont(name: "Helvetica", size: 24.0)

        passwordTextField = UITextField(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.25 + 55, width: view.frame.width * 0.7, height: 50))
        passwordTextField.placeholder = "Password"
        passwordTextField.textAlignment = NSTextAlignment.Center
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.textColor = goldColor
        passwordTextField.font = UIFont(name: "Helvetica", size: 24.0)
        passwordTextField.secureTextEntry = true
        
        incorrectLabel = UILabel(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.6, width: view.frame.width * 0.7, height: 50))
        incorrectLabel.textAlignment = NSTextAlignment.Center
        incorrectLabel.font = UIFont(name: "Helvetica", size: 24.0)
        incorrectLabel.textColor = goldColor

        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.425, width: view.frame.width * 0.7, height: 50))
        createAccountButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        createAccountButton.setTitleColor(goldColor, forState: .Normal)
        createAccountButton.setTitle("Create Account", forState: .Normal)
        createAccountButton.titleLabel?.textAlignment = NSTextAlignment.Center
        createAccountButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        createAccountButton.layer.shadowOpacity = 0.3
        createAccountButton.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
        createAccountButton.layer.shadowRadius = 1.0
        createAccountButton.addTarget(self, action: "createAccountButtonTapped", forControlEvents: .TouchUpInside)
        
        backButton = UIButton(frame: CGRect(x: view.frame.width * 0.15, y: view.frame.height * 0.75, width: view.frame.width * 0.7, height: 50))
        backButton.titleLabel?.font = UIFont(name: "Helvetica", size: 24.0)
        backButton.setTitleColor(goldColor, forState: .Normal)
        backButton.setTitle("Back", forState: .Normal)
        backButton.titleLabel?.textAlignment = NSTextAlignment.Center
        backButton.layer.shadowOffset = CGSize(width: 0, height: 2)
        backButton.layer.shadowOpacity = 0.3
        backButton.layer.shadowColor = UIColor(white: 0.0, alpha: 1.0).CGColor
        backButton.layer.shadowRadius = 1.0
        backButton.addTarget(self, action: "backButtonTapped", forControlEvents: .TouchUpInside)
        
        view.addSubview(titleLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(incorrectLabel)
        view.addSubview(createAccountButton)
        view.addSubview(backButton)
    }
    
    override func viewDidDisappear(animated: Bool) {
        incorrectLabel.text = ""
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    
    func createAccountButtonTapped() {
        //Should dynamically check if username is taken
        if saveContext() {
            println("User saved!")
          
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            incorrectLabel.text = "Please enter a valid username and password"
            println("Error saving!")
        }
    }
    
    func backButtonTapped() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveContext() -> Bool {
        let managedContext = appDelegate.managedObjectContext!
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext) as! User
        if let userName = userNameTextField.text, password = passwordTextField.text {
            if userName != "" && password != "" {
                user.userName = userName
                user.password = password
                var error: NSError?
                if !managedContext.save(&error) {
                    println("Could not save \(error), \(error?.userInfo)")
                    return false
                }
            } else { return false }
        } else { return false }
        
        return true
    }
}

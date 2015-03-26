//
//  LoginViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    var user: User!
    var titleLabel: UILabel!
    let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    
    let goldColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var usernameLabel: UILabel!
    var passwordLabel: UILabel!
    var incorrectLabel: UILabel!
    
    var emptyLoadView: UIView!
    var fullLoadView: UIView!
    
    var loginButton: UIButton!
    var createAccountButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //** Load up labels and fields **//
        //PDAlert: All of these need to be converted to dynamic frame
        usernameLabel = UILabel(frame: CGRect(x: 16, y: 126, width: 79, height: 21))
        usernameLabel.text = "Username"
        usernameLabel.font = UIFont(name: "Helvetica", size: 12.0)
        usernameLabel.textAlignment = NSTextAlignment.Left
        usernameLabel.textColor = goldColor
        passwordLabel = UILabel(frame: CGRect(x: 192, y: 126, width: 79, height: 21))
        passwordLabel.text = "Password"
        passwordLabel.font = UIFont(name: "Helvetica", size: 12.0)
        passwordLabel.textAlignment = NSTextAlignment.Left
        passwordLabel.textColor = goldColor
        
        userNameTextField = UITextField(frame: CGRect(x: 16, y: 155, width: 167, height: 30))
        userNameTextField.textAlignment = NSTextAlignment.Center
        userNameTextField.borderStyle = UITextBorderStyle.RoundedRect
        userNameTextField.textColor = goldColor
        userNameTextField.font = UIFont(name: "Helvetica", size: 16.0)
        passwordTextField = UITextField(frame: CGRect(x: 192, y: 155, width: 167, height: 30))
        passwordTextField.textAlignment = NSTextAlignment.Center
        passwordTextField.borderStyle = UITextBorderStyle.RoundedRect
        passwordTextField.textColor = goldColor
        passwordTextField.font = UIFont(name: "Helvetica", size: 16.0)
        passwordTextField.secureTextEntry = true
        
        incorrectLabel = UILabel(frame: CGRect(x: 16, y: 237, width: 343, height: 21))
        incorrectLabel.textAlignment = NSTextAlignment.Center
        incorrectLabel.font = UIFont(name: "Helvetica", size: 16.0)
        incorrectLabel.textColor = goldColor
        
        emptyLoadView = UIView(frame: CGRect(x: 16, y: 292, width: 343, height: 32))
        emptyLoadView.layer.zPosition = 2
        emptyLoadView.layer.cornerRadius = 10.0
        emptyLoadView.backgroundColor = whiteColor
        fullLoadView = UIView(frame: CGRect(x: self.emptyLoadView.frame.minX, y: emptyLoadView.frame.minY, width: 0.0, height: emptyLoadView.frame.height))

        titleLabel = UILabel(frame: CGRect(x: 0, y: 30, width: view.bounds.width, height: 36.0))
        titleLabel.text = "DING!"
        titleLabel.font = UIFont(name: "Helvetica", size: 36.0)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        
        loginButton = UIButton(frame: CGRect(x: 155, y: 193, width: 64, height: 36))
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        loginButton.setTitleColor(goldColor, forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel?.textAlignment = NSTextAlignment.Center
        loginButton.addTarget(self, action: "loginButtonTapped", forControlEvents: .TouchUpInside)
        
        createAccountButton = UIButton(frame: CGRect(x: 125, y: 370, width:124, height: 36))
        createAccountButton.titleLabel?.font = UIFont(name: "Helvetica", size: 18.0)
        createAccountButton.setTitleColor(goldColor, forState: .Normal)
        createAccountButton.setTitle("Create Account", forState: .Normal)
        createAccountButton.titleLabel?.textAlignment = NSTextAlignment.Center
        createAccountButton.addTarget(self, action: "createAccountButtonTapped", forControlEvents: .TouchUpInside)

        view.addSubview(titleLabel)
        view.addSubview(usernameLabel)
        view.addSubview(passwordLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(incorrectLabel)
        view.addSubview(emptyLoadView)
        view.addSubview(fullLoadView)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        
        view.backgroundColor = UIColor(red: 0.9, green: 0.9, blue: 0.9, alpha:1)
        view.userInteractionEnabled = true
        /************************/
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        incorrectLabel.text = ""
        userNameTextField.text = ""
        passwordTextField.text = ""
        fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: 0, height: self.emptyLoadView.frame.height)
        view.userInteractionEnabled = true
    }

    func loginButtonTapped() {
        //Chain this in 1.2
        //Make it so "" is not legal
        if let userName = userNameTextField.text {
            if let password = passwordTextField.text {
                if userName != "" && password != "" {
                    let managedContext = appDelegate.managedObjectContext!
                    var fetchRequest = NSFetchRequest(entityName: "User")
                    var error: NSError?
                    let predicate = NSPredicate(format: "userName = %@ AND password = %@", userName, password)
                    fetchRequest.predicate = predicate
                    
                    let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [User]?
                    if !fetchedResults!.isEmpty { // Found User
                        //view.userInteractionEnabled = false
                        fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: 0, height: self.emptyLoadView.frame.height)
                        fullLoadView.layer.cornerRadius = 10.0
                        fullLoadView.layer.zPosition = 3
                        fullLoadView.backgroundColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
                        
                        UIView.animateWithDuration(2.0, animations: {
                            self.fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: self.emptyLoadView.frame.width, height: self.emptyLoadView.frame.height)
                            self.fullLoadView.backgroundColor = UIColor(red: 0.645, green: 0.8, blue: 0.2, alpha: 1)
                            }, completion: {
                                (value: Bool) in
                                self.user = fetchedResults![0]
                                let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as HomeViewController
                                homeViewController.user = self.user
                                self.presentViewController(homeViewController, animated: true, completion: nil)
                                
                        })
                    } else { // Did not find user
                        incorrectLabel.text = "Incorrect username or password"
                    }
                } else {
                    incorrectLabel.text = "Please enter a username and password"
                }
            }
        }
    }
    
    func createAccountButtonTapped() {
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as CreateAccountViewController
        createAccountViewController.appDelegate = appDelegate
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }

}


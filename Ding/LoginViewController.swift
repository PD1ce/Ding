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
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var incorrectLabel: UILabel!
    
    @IBOutlet weak var emptyLoadView: UIView!
    var fullLoadView: UIView!
    
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Styling and creation */
        view.layer.zPosition = 1
        emptyLoadView.layer.zPosition = 2
        emptyLoadView.layer.cornerRadius = 10.0
        loginButton.setTitleColor(UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1), forState: .Normal)
        usernameLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        passwordLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        userNameTextField.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        passwordTextField.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        userNameTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        passwordTextField.textAlignment = NSTextAlignment(rawValue: 1)!
        passwordTextField.secureTextEntry = true
        view.backgroundColor = UIColor(red: 0.5, green: 0.8, blue: 1, alpha:1)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 10, width: view.bounds.width, height: 96.0))
        titleLabel.text = "DING!"
        titleLabel.font = UIFont(name: "Helvetica", size: 64.0)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        view.addSubview(titleLabel)
        /************************/
        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(animated: Bool) {
        incorrectLabel.text = ""
        fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: 0, height: self.emptyLoadView.frame.height)
    }

    @IBAction func loginButtonTapped(sender: AnyObject) {
        //Chain this in 1.2
        if let userName = userNameTextField.text {
            if let password = passwordTextField.text {
                let managedContext = appDelegate.managedObjectContext!
                var fetchRequest = NSFetchRequest(entityName: "User")
                var error: NSError?
                let predicate = NSPredicate(format: "userName = %@ AND password = %@", userName, password)
                fetchRequest.predicate = predicate
                
                let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as [User]?
                if !fetchedResults!.isEmpty { // Found User
                    fullLoadView = UIView(frame: CGRect(x: self.emptyLoadView.frame.minX, y: emptyLoadView.frame.minY, width: 0.0, height: emptyLoadView.frame.height))
                    fullLoadView.layer.cornerRadius = 10.0
                    view.addSubview(fullLoadView)
                    fullLoadView.layer.zPosition = 3
                    fullLoadView.backgroundColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
                    
                    UIView.animateWithDuration(1.0, animations: {
                        self.fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: self.emptyLoadView.frame.width, height: self.emptyLoadView.frame.height)
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
            }
        }

        
    }
    
    @IBAction func createAccountButtonTapped(sender: AnyObject) {
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as CreateAccountViewController
        createAccountViewController.appDelegate = appDelegate
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }

}


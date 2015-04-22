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
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var incorrectLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        passwordTextField.secureTextEntry = true
    }
    
    override func viewDidDisappear(animated: Bool) {
        incorrectLabel.text = ""
        userNameTextField.text = ""
        passwordTextField.text = ""
    }
    @IBAction func createAccountTapped(sender: AnyObject) {
        //Should dynamically check if username is taken
        if saveContext() {
            println("User saved!")
          
            dismissViewControllerAnimated(true, completion: nil)
        } else {
            incorrectLabel.text = "Please enter a valid username and password"
            println("Error saving!")
        }
    }
    
    func saveContext() -> Bool {
        let managedContext = appDelegate.managedObjectContext!
        let user = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: managedContext) as! User
        if let userName = userNameTextField.text {
            if let password = passwordTextField.text {
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
        } else { return false }
        
        return true
    }
}

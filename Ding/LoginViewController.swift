//
//  LoginViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit
import CoreData
import AVFoundation
import Alamofire

class LoginViewController: UIViewController {
    
    var user: User!
    var titleLabel: UILabel!
    let appDelegate = UIApplication.sharedApplication().delegate! as! AppDelegate
    
    let goldColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
    let whiteColor = UIColor(white: 1.0, alpha: 1.0)
    let tasksColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    
    var userNameTextField: UITextField!
    var passwordTextField: UITextField!
    var usernameLabel: UILabel!
    var passwordLabel: UILabel!
    var incorrectLabel: UILabel!
    
    var emptyLoadView: UIView!
    var fullLoadView: UIView!
    
    var loginButton: UIButton!
    var createAccountButton: UIButton!
    
    var colorSchemes: NSMutableArray!
    
    var audioPlayer = AVAudioPlayer()
    var clickSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click-login", ofType: "wav")!)
    
    override func viewDidLoad() {
        super.viewDidLoad()
       /*
        Alamofire.request(.GET, "http://httpbin.org/get", parameters: ["foo": "bar"])
            .response { (request, response, data, error) in
                println("Request: \(request)")
                println("Response: \(response)")
                println("Data: \(data)")
                println("Error: \(error)")
        }
        */
        /*
        Alamofire.request(.GET, "https://api.500px.com/v1/photos", parameters: ["consumer_key": "63QtZxAmzrSO0ybQoR3FwfSwZgBzE9wMPFEuHFgp"]).responseJSON() {
            (_, _, data, _) in
            println(data)
        }
        */
        /*
        Alamofire.request(.GET, "http://httpbin.org/get")
            .responseJSON { (_, _, JSON, _) in
                println(JSON)
        }*/
//        request(.GET, "http://httpbin.org/get")
//            .responseString { (_, _, string, _) in
//                println(string)
//        }
        ///////////////////////    Color Schemes    /////////////////////////
        
            
        colorSchemes = NSMutableArray()
        let data = NSData(contentsOfFile: "/Users/Phil/Desktop/Swift/Ding/Ding/ColorSchemes.json")
        let parsedObject: AnyObject? = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments,error: nil)
        let colorsArray = parsedObject as! NSArray
        for color in colorsArray {
            var schemeName: String = ""; var schemeId: Int = 0; var bgRed: CGFloat = 0; var bgGreen: CGFloat = 0; var bgBlue: CGFloat = 0; var homeRed: CGFloat = 0; var homeGreen: CGFloat = 0; var homeBlue: CGFloat = 0; var skillsRed: CGFloat = 0; var skillsGreen: CGFloat = 0; var skillsBlue: CGFloat = 0; var tasksRed: CGFloat = 0; var tasksGreen: CGFloat = 0; var tasksBlue: CGFloat = 0; var goalsRed: CGFloat = 0; var goalsGreen: CGFloat = 0; var goalsBlue: CGFloat = 0; var achievementsRed: CGFloat = 0; var achievementsGreen: CGFloat = 0; var achievementsBlue: CGFloat = 0;
            if let newSchemeName = color.valueForKey("schemeName") as? String { schemeName = newSchemeName }
            if let newSchemeId = color.valueForKey("schemeId") as? Int { schemeId = newSchemeId }
            if let newbgRed = color.valueForKey("bgRed") as? CGFloat { bgRed = newbgRed }
            if let newbgGreen = color.valueForKey("bgGreen") as? CGFloat { bgGreen = newbgGreen }
            if let newbgBlue = color.valueForKey("bgBlue") as? CGFloat { bgBlue = newbgBlue }
            if let newhomeRed = color.valueForKey("homeRed") as? CGFloat { homeRed = newhomeRed }
            if let newhomeGreen = color.valueForKey("homeGreen") as? CGFloat { homeGreen = newhomeGreen }
            if let newhomeBlue = color.valueForKey("homeBlue") as? CGFloat { homeBlue = newhomeBlue }
            if let newskillsRed = color.valueForKey("skillsRed") as? CGFloat { skillsRed = newskillsRed }
            if let newskillsGreen = color.valueForKey("skillsGreen") as? CGFloat { skillsGreen = newskillsGreen }
            if let newskillsBlue = color.valueForKey("skillsBlue") as? CGFloat { skillsBlue = newskillsBlue }
            if let newtasksRed = color.valueForKey("tasksRed") as? CGFloat { tasksRed = newtasksRed }
            if let newtasksGreen = color.valueForKey("tasksGreen") as? CGFloat { tasksGreen = newtasksGreen }
            if let newtasksBlue = color.valueForKey("tasksBlue") as? CGFloat { tasksBlue = newtasksBlue }
            if let newgoalsRed = color.valueForKey("goalsRed") as? CGFloat { goalsRed = newgoalsRed }
            if let newgoalsGreen = color.valueForKey("goalsGreen") as? CGFloat { goalsGreen = newgoalsGreen }
            if let newgoalsBlue = color.valueForKey("goalsBlue") as? CGFloat { goalsBlue = newgoalsBlue }
            if let newachievementsRed = color.valueForKey("achievementsRed") as? CGFloat { achievementsRed = newachievementsRed }
            if let newachievementsGreen = color.valueForKey("achievementsGreen") as? CGFloat { achievementsGreen = newachievementsGreen }
            if let newachievementsBlue = color.valueForKey("achievementsBlue") as? CGFloat { achievementsBlue = newachievementsBlue }
            colorSchemes.addObject(ColorScheme(schemeName: schemeName, schemeId: schemeId, bgRed: bgRed, bgGreen: bgGreen, bgBlue: bgBlue, homeRed: homeRed, homeGreen: homeGreen, homeBlue: homeBlue, skillsRed: skillsRed, skillsGreen: skillsGreen, skillsBlue: skillsBlue, tasksRed: tasksRed, tasksGreen: tasksGreen, tasksBlue: tasksBlue, goalsRed: goalsRed, goalsGreen: goalsGreen, goalsBlue: goalsBlue, achievementsRed: achievementsRed, achievementsGreen: achievementsGreen, achievementsBlue: achievementsBlue))
        }
        

        //** Load up labels and fields **//
        //PDAlert: All of these need to be converted to dynamic frame
        /*
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
        */
        
        titleLabel = UILabel(frame: CGRect(x: 0, y: 20, width: view.bounds.width, height: view.frame.height * 0.2))
        titleLabel.text = "DING!"
        titleLabel.font = UIFont(name: "Helvetica", size: 96.0)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        
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
        
        incorrectLabel = UILabel(frame: CGRect(x: 16, y: 237, width: 343, height: 21))
        incorrectLabel.textAlignment = NSTextAlignment.Center
        incorrectLabel.font = UIFont(name: "Helvetica", size: 16.0)
        incorrectLabel.textColor = goldColor
        
        emptyLoadView = UIView(frame: CGRect(x: 16, y: view.frame.height * 0.6, width: view.frame.width - 32, height: 32))
        emptyLoadView.layer.zPosition = 2
        emptyLoadView.layer.cornerRadius = 10.0
        emptyLoadView.backgroundColor = whiteColor
        fullLoadView = UIView(frame: CGRect(x: self.emptyLoadView.frame.minX, y: emptyLoadView.frame.minY, width: 0.0, height: emptyLoadView.frame.height))
        
        loginButton = UIButton(frame: CGRect(x: view.frame.width * 0.333, y: view.frame.height * 0.425, width: view.frame.width * 0.333, height: 36))
        loginButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
        loginButton.setTitleColor(goldColor, forState: .Normal)
        loginButton.setTitle("Login", forState: .Normal)
        loginButton.titleLabel?.textAlignment = NSTextAlignment.Center
        loginButton.backgroundColor = UIColor.whiteColor()
        loginButton.layer.borderColor = goldColor.CGColor
        loginButton.layer.borderWidth = 2
        loginButton.layer.cornerRadius = 10.0
        loginButton.addTarget(self, action: "loginButtonTapped", forControlEvents: .TouchUpInside)
        
        createAccountButton = UIButton(frame: CGRect(x: view.frame.width * 0.1, y: view.frame.height * 0.75, width: view.frame.width * 0.8, height: 36))
        createAccountButton.titleLabel?.font = UIFont(name: "Helvetica", size: 20.0)
        createAccountButton.setTitleColor(goldColor, forState: .Normal)
        createAccountButton.setTitle("Create Account", forState: .Normal)
        createAccountButton.titleLabel?.textAlignment = NSTextAlignment.Center
        createAccountButton.backgroundColor = UIColor.whiteColor()
        createAccountButton.layer.borderColor = goldColor.CGColor
        createAccountButton.layer.borderWidth = 2
        createAccountButton.layer.cornerRadius = 10.0
        createAccountButton.addTarget(self, action: "createAccountButtonTapped", forControlEvents: .TouchUpInside)

        view.addSubview(titleLabel)
        //view.addSubview(usernameLabel)
        //view.addSubview(passwordLabel)
        view.addSubview(userNameTextField)
        view.addSubview(passwordTextField)
        view.addSubview(incorrectLabel)
        view.addSubview(emptyLoadView)
        view.addSubview(fullLoadView)
        view.addSubview(loginButton)
        view.addSubview(createAccountButton)
        
        
        view.backgroundColor = UIColor(white: 0.90, alpha: 1.0)
        view.userInteractionEnabled = true
        /************************/
        
        
        //Sounds
        audioPlayer = AVAudioPlayer(contentsOfURL: clickSound, error: nil)
        audioPlayer.prepareToPlay()
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
        //self.usernameLabel.frame.origin = CGPoint(x: self.usernameLabel.frame.minX, y: 126)
        //self.passwordLabel.frame.origin = CGPoint(x: self.passwordLabel.frame.minX, y: 126)
        self.userNameTextField.frame.origin = CGPoint(x: self.userNameTextField.frame.minX, y: view.frame.height * 0.25)
        self.passwordTextField.frame.origin = CGPoint(x: self.passwordTextField.frame.minX, y: view.frame.height * 0.25 + 55)
        self.titleLabel.frame.origin = CGPoint(x: self.titleLabel.frame.minX, y: 30)
        self.loginButton.frame.origin = CGPoint(x: self.loginButton.frame.minX, y: view.frame.height * 0.425)
        self.createAccountButton.frame.origin = CGPoint(x: self.createAccountButton.frame.minX, y: view.frame.height * 0.8)
        self.emptyLoadView.alpha = 1.0
        self.fullLoadView.alpha = 1.0
    }

    func loginButtonTapped() {
        //Chain this in 1.2
        //Make it so "" is not legal
        
        //// Click Sound ////
        // Load
        //println("\(NSBundle.mainBundle().executablePath)")
        
        
        audioPlayer.play()
        
        /////////////////////
        
        
        if let userName = userNameTextField.text {
            if let password = passwordTextField.text {
                if userName != "" && password != "" {
                    let managedContext = appDelegate.managedObjectContext!
                    var fetchRequest = NSFetchRequest(entityName: "User")
                    var error: NSError?
                    let predicate = NSPredicate(format: "userName = %@ AND password = %@", userName, password)
                    fetchRequest.predicate = predicate
                    
                    let fetchedResults = managedContext.executeFetchRequest(fetchRequest, error: &error) as! [User]?
                    if !fetchedResults!.isEmpty { // Found User
                        //view.userInteractionEnabled = false
                        fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: 0, height: self.emptyLoadView.frame.height)
                        fullLoadView.layer.cornerRadius = 10.0
                        fullLoadView.layer.zPosition = 3
                        fullLoadView.backgroundColor = UIColor(red: 0.0, green: 0.8, blue: 0, alpha: 1)
                        view.userInteractionEnabled = false
                        
                        UIView.animateWithDuration(2.0, animations: {
                            self.fullLoadView.frame = CGRect(x: self.emptyLoadView.frame.minX, y: self.emptyLoadView.frame.minY, width: self.emptyLoadView.frame.width, height: self.emptyLoadView.frame.height)
                            //self.fullLoadView.backgroundColor = UIColor(red: 0.645, green: 0.8, blue: 0.2, alpha: 1)
                            //Moving other views off screen
                            //self.usernameLabel.frame.origin = CGPoint(x: self.usernameLabel.frame.minX, y: -50)
                            //self.passwordLabel.frame.origin = CGPoint(x: self.passwordLabel.frame.minX, y: -50)
                            self.userNameTextField.frame.origin = CGPoint(x: self.userNameTextField.frame.minX, y: -50)
                            self.passwordTextField.frame.origin = CGPoint(x: self.passwordTextField.frame.minX, y: -50)
                            self.titleLabel.frame.origin = CGPoint(x: self.titleLabel.frame.minX, y: -120)
                            self.loginButton.frame.origin = CGPoint(x: self.loginButton.frame.minX, y: -50)
                            self.createAccountButton.frame.origin = CGPoint(x: self.createAccountButton.frame.minX, y: self.view.frame.height + 50)
                            
                            
                            }, completion: {
                                (value: Bool) in
                                self.user = fetchedResults![0]
                                let homeViewController = self.storyboard?.instantiateViewControllerWithIdentifier("HomeViewController") as! HomeViewController
                                homeViewController.user = self.user
                                homeViewController.colorSchemes = self.colorSchemes
                                homeViewController.transitionCameFrom = self
                                
                                homeViewController.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                                self.modalTransitionStyle = UIModalTransitionStyle.CrossDissolve
                            
                                
                                
                                /* The Fake Header view to animate */
                                let headerView = UIView(frame: CGRect(x: 0, y: self.view.frame.height + 44, width: self.view.frame.width, height: 44))
                                headerView.backgroundColor = UIColor(white: 1.0, alpha: 1.0)
                                let logoutButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 44))
                                logoutButton.setTitle("Logout", forState: .Normal)
                                //logoutButton.addTarget(self, action: "logoutButtonTapped", forControlEvents: .TouchUpInside)
                                logoutButton.setTitleColor(UIColor(white: 0.0, alpha: 1.0), forState: .Normal)
                                let headerLabel = UILabel(frame: CGRect(x: headerView.frame.width / 4, y: 0, width: headerView.frame.width / 2, height: headerView.frame.height))
                                headerLabel.font = UIFont(name: "Helvetica", size: 24.0)
                                headerLabel.textColor = UIColor(red: 1.0, green: 0.65, blue: 0.1, alpha: 1.0)
                                headerLabel.textAlignment = NSTextAlignment(rawValue: 1)!
                                headerLabel.text = "Home"
                                let optionsButton = AniButton(frame: CGRect(x: headerView.frame.width - 48, y: 6, width: 32, height: 32))
                                optionsButton.setImage(UIImage(named: "options-gear"), forState: .Normal)
                                headerView.addSubview(optionsButton)
                                headerView.addSubview(headerLabel)
                                headerView.addSubview(logoutButton)
                                self.view.addSubview(headerView)
                                /************************************/
                                
                                UIView.animateWithDuration(0.5, delay: 0.0, options: .CurveEaseOut, animations: {
                                    //Final Animation
                                    self.fullLoadView.backgroundColor = self.goldColor
                                    self.emptyLoadView.alpha = 0.0
                                    self.fullLoadView.alpha = 0.0
                                    }, completion: {
                                        (value: Bool) in
                                        UIView.animateWithDuration(0.75, delay: 0.0, options: .CurveEaseOut, animations: {
                                            //Header animation
                                            headerView.frame.origin = CGPoint(x: 0, y: 20)
                                        }, completion: {
                                            (value: Bool) in
                                            self.presentViewController(homeViewController, animated: false, completion: {
                                                headerView.removeFromSuperview()
                                            })
                                        })
                                })
                                
                                
                                
                                
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
        let createAccountViewController = storyboard?.instantiateViewControllerWithIdentifier("CreateAccountViewController") as! CreateAccountViewController
        createAccountViewController.appDelegate = appDelegate
        presentViewController(createAccountViewController, animated: true, completion: nil)
    }

}


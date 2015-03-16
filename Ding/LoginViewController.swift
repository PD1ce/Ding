//
//  LoginViewController.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(red: 0.25, green: 0.25, blue: 1, alpha:1)
        titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 96.0))
        titleLabel.text = "DING!"
        titleLabel.font = UIFont(name: "Helvetica", size: 64.0)
        titleLabel.textColor = UIColor(red: 1.0, green: 0.645, blue: 0, alpha: 1)
        titleLabel.textAlignment = NSTextAlignment(rawValue: 1)!
        view.addSubview(titleLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


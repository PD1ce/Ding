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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    @IBAction func logoutTapped(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}

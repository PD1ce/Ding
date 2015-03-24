//
//  TaskCard.swift
//  Ding
//
//  Created by Philip Deisinger on 3/18/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class TaskCard : UIView {
    var task: Task!
    let mainColor = UIColor(red: 51/255, green: 204/255, blue: 255/255, alpha: 1.0)
    
    init(frame: CGRect, task: Task) {
        super.init(frame: frame)
        self.task = task
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    //Used for creation of new task cards
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
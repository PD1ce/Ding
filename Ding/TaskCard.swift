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
    var mainColor: UIColor!
    
    init(frame: CGRect, task: Task, color: UIColor) {
        super.init(frame: frame)
        self.task = task
        mainColor = color
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    //Used for creation of new task cards
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        mainColor = color
        layer.cornerRadius = 10.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
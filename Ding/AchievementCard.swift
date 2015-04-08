//
//  AchievementCard.swift
//  Ding
//
//  Created by Philip Deisinger on 4/2/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class AchievementCard : UIView {
    var goal: Goal!
    let mainColor = UIColor(red: 102/255, green: 51/255, blue: 255/255, alpha: 1.0)
    
    init(frame: CGRect, goal: Goal) {
        super.init(frame: frame)
        self.goal = goal
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
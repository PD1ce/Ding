//
//  SkillCard.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class SkillCard : UIView {
    var skill: Skill!
    //let mainColor = UIColor(red: 51/255, green: 255/255, blue: 204/255, alpha: 1.0)
    var mainColor: UIColor!
    
    init(frame: CGRect, skill: Skill, color: UIColor) {
        super.init(frame: frame)
        self.skill = skill
        self.mainColor = color
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
        
    }
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        self.mainColor = color
        layer.cornerRadius = 5.0
        layer.borderWidth = 2.0
        layer.borderColor = mainColor.CGColor
        backgroundColor = UIColor(white: 1.0, alpha: 1.0)
    }
    
     required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
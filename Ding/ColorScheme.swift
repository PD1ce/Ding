//
//  ColorScheme.swift
//  Ding
//
//  Created by Philip Deisinger on 4/7/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import UIKit

class ColorScheme {
    var schemeName: String!
    var schemeId: Int!
    var bg: UIColor!
    var home: UIColor!
    var skills: UIColor!
    var tasks: UIColor!
    var goals: UIColor!
    var achievements: UIColor!
    
    init(schemeName: String!, schemeId: Int!, bg: UIColor, home: UIColor, skills: UIColor, tasks: UIColor, goals: UIColor, achievements: UIColor) {
        self.schemeName = schemeName
        self.schemeId = schemeId
        self.bg = bg
        self.home = home
        self.skills = skills
        self.tasks = tasks
        self.goals = goals
        self.achievements = achievements
    }
    
    init(schemeName: String!, schemeId: Int!, bgRed: CGFloat, bgGreen: CGFloat, bgBlue: CGFloat, homeRed: CGFloat, homeGreen: CGFloat, homeBlue: CGFloat, skillsRed: CGFloat, skillsGreen: CGFloat, skillsBlue: CGFloat, tasksRed: CGFloat, tasksGreen: CGFloat, tasksBlue: CGFloat, goalsRed: CGFloat, goalsGreen: CGFloat, goalsBlue: CGFloat, achievementsRed: CGFloat, achievementsGreen: CGFloat, achievementsBlue: CGFloat) {
        
        self.schemeName = schemeName
        self.schemeId = schemeId
        self.bg = UIColor(red: bgRed, green: bgGreen, blue: bgBlue, alpha: 1.0)
        self.home = UIColor(red: homeRed, green: homeGreen, blue: homeBlue, alpha: 1.0)
        self.skills = UIColor(red: skillsRed, green: skillsGreen, blue: skillsBlue, alpha: 1.0)
        self.tasks = UIColor(red: tasksRed, green: tasksGreen, blue: tasksBlue, alpha: 1.0)
        self.goals = UIColor(red: goalsRed, green: goalsGreen, blue: goalsBlue, alpha: 1.0)
        self.achievements = UIColor(red: achievementsRed, green: achievementsGreen, blue: achievementsBlue, alpha: 1.0)
        
    }
}

//
//  SkillGoal.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class SkillGoal: NSManagedObject {

    @NSManaged var goalLevel: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var skill: Ding.Skill

}

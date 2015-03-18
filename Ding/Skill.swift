//
//  Skill.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Skill: NSManagedObject {

    @NSManaged var expNeeded: NSNumber
    @NSManaged var expTotal: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var skillDescription: String
    @NSManaged var skillName: String
    @NSManaged var skillType: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var levelUpDates: NSOrderedSet
    @NSManaged var tasks: NSOrderedSet
    @NSManaged var user: Ding.User

}

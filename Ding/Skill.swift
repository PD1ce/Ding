//
//  Skill.swift
//  Ding
//
//  Created by Philip Deisinger on 3/23/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Skill: NSManagedObject {

    @NSManaged var expTotal: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var skillDescription: String
    @NSManaged var skillName: String
    @NSManaged var skillType: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var expNeeded: NSNumber
    @NSManaged var expCurrent: NSNumber
    @NSManaged var levelUpDates: NSSet
    @NSManaged var tasks: NSSet
    @NSManaged var user: Ding.User

}

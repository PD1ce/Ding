//
//  Skill.swift
//  Ding
//
//  Created by Philip Deisinger on 3/16/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Skill: NSManagedObject {

    @NSManaged var expNeeded: NSNumber
    @NSManaged var expTotal: NSNumber
    @NSManaged var level: NSNumber
    @NSManaged var skillname: String
    @NSManaged var levelUpDates: NSOrderedSet
    @NSManaged var tasks: NSOrderedSet
    @NSManaged var user: Ding.User

}

//
//  Task.swift
//  Ding
//
//  Created by Philip Deisinger on 3/24/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Task: NSManagedObject {

    @NSManaged var accomplishedDate: NSDate
    @NSManaged var difficulty: NSNumber
    @NSManaged var exp: NSNumber
    @NSManaged var id: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var taskDescription: String
    @NSManaged var taskName: String
    @NSManaged var taskType: NSNumber
    @NSManaged var completed: NSNumber
    @NSManaged var skill: Ding.Skill

}

//
//  Goal.swift
//  Ding
//
//  Created by Philip Deisinger on 3/17/15.
//  Copyright (c) 2015 PDice. All rights reserved.
//

import Foundation
import CoreData

class Goal: NSManagedObject {

    @NSManaged var accomplishedDate: NSDate
    @NSManaged var goalCompletion: NSNumber
    @NSManaged var goalLevel: NSNumber
    @NSManaged var goalName: String
    @NSManaged var id: NSNumber
    @NSManaged var startDate: NSDate
    @NSManaged var skillGoals: NSSet
    @NSManaged var taskGoals: NSSet
    @NSManaged var user: Ding.User

}
